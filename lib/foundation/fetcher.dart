import 'dart:convert';

import 'package:elis_analytics_dashboard/model/data/session.dart';
import 'package:elis_analytics_dashboard/model/enum/thingsboard_device.dart';
import 'package:elis_analytics_dashboard/model/exception/invalid_token.dart';
import 'package:http/http.dart';
import 'package:mutex/mutex.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Fetcher extends BaseClient {

  // Features
  static const bool isLoggingEnabled = false;

  /* Base Thingsboard url */
  static final Uri _baseUrl = Uri.parse('https://iothings.netcomgroup.eu/api/');

  /* Singleton pattern */
  static final Fetcher _instance = Fetcher._();
  factory Fetcher() => _instance;

  /* Private constructor */
  Fetcher._() :
    _cacheBlacklist = Set.of(
      List.generate(
        ThingsboardDevice.values.length,
        (index) => _baseUrl.resolve('plugins/telemetry/DEVICE/${ThingsboardDevice.values[index].id}/values/timeseries'),
        growable: false
      )
    ),
    _futureCache = <Uri, Future<Response>>{},
    _sessionMutex = Mutex(),
    _client = Client();

  final Set<Uri> _cacheBlacklist;
  final Map<Uri, Future<Response>> _futureCache;
  final Mutex _sessionMutex;
  final Client _client;
  Session? _session;

  @override
  Future<Response> get(Uri url, {Map<String, String>? headers}) {
    // Resolve the uri
    Uri completeUrl = _baseUrl.resolveUri(url);
    // Check if blacklisted
    if (_cacheBlacklist.contains(completeUrl)) {
      return super.get(completeUrl, headers: headers);
    } else {
      return _futureCache.putIfAbsent(completeUrl, () => super.get(completeUrl, headers: headers));
    }
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    // Get a Session from Thingsboard if needed (only one request at a time)
    await _sessionMutex.protect(() async {
      // Check if there is not a token or the token has expired
      if (_session == null || _session!.expired) {
        // Get SharedPreferences instance
        SharedPreferences preferences = await SharedPreferences.getInstance();
        // INJECT: "Email" and "Password" if user cannot login/logout
        if (!isLoggingEnabled) {
          if (!preferences.containsKey('Email')) {
            await preferences.setString('Email', 'elisgroup@elis.org');
          }
          if (!preferences.containsKey('Password')) {
            await preferences.setString('Password', 'elisgroup');
          }
        }
        // Check
        if (preferences.containsKey('Email') && preferences.containsKey('Password')) {
          // Try to get a new token
          try {
            Response response = await _client.post(
              _baseUrl.resolve('/api/auth/login'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
              },
              body: json.encode(<String, String>{
                'username': preferences.getString('Email')!,
                'password': preferences.getString('Password')!,
              })
            );
            if (response.statusCode == 200) {
              _session = Session.fromMap(json.decode(response.body));
            } else {  // Force catch
              throw response.statusCode;
            }
          } catch (e) {
            await preferences.remove('Email');
            await preferences.remove('Password');
            throw InvalidTokenException('Status code: $e');
          }
        } else {
          await preferences.remove('Email');
          await preferences.remove('Password');
          throw InvalidTokenException('None');
        }
      }
    });
    // Inject the token if there is one
    if (_session != null) {
      request.headers['X-Authorization'] = 'Bearer ${_session!.token}';
    }
    // Send the request to the lower layers
    return _client.send(request);
  }

  bool get hasSession => _session != null;

  void clearCache() => _futureCache.clear();

}