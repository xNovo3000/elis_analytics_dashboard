import 'dart:async';
import 'dart:convert';

import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/component/responsive_layout.dart';
import 'package:elis_analytics_dashboard/foundation/fetcher.dart';
import 'package:elis_analytics_dashboard/model/enum/thingsboard_device.dart';
import 'package:elis_analytics_dashboard/model/exception/invalid_token.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/home_data.dart';
import 'package:elis_analytics_dashboard/view/home_smartphone.dart';
import 'package:flutter/material.dart';

class RouteHome extends StatefulWidget {

  final fetcher = Fetcher();

  @override _RouteHomeState createState() => _RouteHomeState();

}

class _RouteHomeState extends State<RouteHome> {

  late Timer timer;

  @override
  void initState() {
    // Every 1 minute update
    timer = Timer.periodic(Duration(minutes: 1), _onTimerTick);
    // Flutter init
    super.initState();
  }

  @override
  void dispose() {
    // Cancel auto-update
    timer.cancel();
    // Flutter dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize child
    final child = ResponsiveLayout(
      smartphoneWidget: ViewHomeSmartphone(),
    );
    // Build UI
    return ComponentManagedFutureBuilder<Map<String, dynamic>>(
      future: _getData(context),
      onSuccess: (context, data) => ModelInheritedHomeData(
        child: child,
        lastWeekRange: data['last_week_range'],
      ),
      onError: (context, error) => ModelInheritedError(
        child: child,
        error: '$error',
      ),
      onWait: (context) => child,
    );
  }

  void _onTimerTick(Timer timer) {
    if (mounted) {
      setState(() => null);
    }
  }

  Future<Map<String, dynamic>> _getData(BuildContext context) async => {
    'last_week_range': await _getLastWeekRange(context),
  };

  Future<DateTimeRange> _getLastWeekRange(BuildContext context) async {
    // Generate
    final uri = Uri.parse('plugins/telemetry/DEVICE/${ThingsboardDevice.vodafoneCampus}/values/timeseries');
    // Send request
    final response = await widget.fetcher.get(uri);
    switch (response.statusCode) {
      case 200:
        final jsonResponse = json.decode(response.body);
        var timestamp = DateTime.fromMillisecondsSinceEpoch(jsonResponse['visitors'][0]['ts'], isUtc: true).toLocal();
        timestamp = DateTime(timestamp.year, timestamp.month, timestamp.day);
        if (timestamp.weekday != 7) {
          timestamp = timestamp.subtract(Duration(days: timestamp.weekday));
        }
        timestamp = timestamp.add(Duration(days: 1));
        return DateTimeRange(
          start: timestamp.subtract(Duration(days: 7)),
          end: timestamp,
        );
      case 401:
        throw InvalidTokenException('');
      default:
        throw response.statusCode;
    }
  }

}
