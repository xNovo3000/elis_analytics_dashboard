import 'dart:convert';

import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/component/responsive_layout.dart';
import 'package:elis_analytics_dashboard/foundation/fetcher.dart';
import 'package:elis_analytics_dashboard/foundation/utils.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_attendance.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_visits.dart';
import 'package:elis_analytics_dashboard/model/data/weather_daily.dart';
import 'package:elis_analytics_dashboard/model/enum/area.dart';
import 'package:elis_analytics_dashboard/model/exception/invalid_token.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/weekly_data.dart';
import 'package:elis_analytics_dashboard/view/weekly_smartphone.dart';
import 'package:flutter/material.dart';

class RouteWeekly extends StatelessWidget {

  static const _underConstruction = false;
  static const _isShowingHumidityAndWind = false;

  final fetcher = Fetcher();

  @override
  Widget build(BuildContext context) {
    // Build the child widget
    final child = ResponsiveLayout(
      smartphoneWidget: ViewWeeklySmartphone(),
    );
    // Unfinished
    if (_underConstruction) {
      return ModelInheritedError(
        child: child,
        error: 'Questa visualizzazione è ancora in fase di costruzione',
      );
    }
    // Get specific week from route arguments dispatch
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || !(args is Map<String, dynamic>) || !(args['week'] is DateTimeRange) || !(args['last_available_week'] is DateTimeRange)) {
      return ModelInheritedError(
        child: child,
        error: 'Si è verificato un errore sconosciuto',
      );
    }
    // Build UI
    return ComponentManagedFutureBuilder<Map<String, dynamic>>(
      future: _getWeeklyData(args['week']),
      onSuccess: (context, data) => ModelInheritedWeeklyData(
        child: child,
        weathers: data['weathers'],
        attendance: data['attendance'],
        visits: data['visits'],
        campusVodafone: data['campus_vodafone'],
        neighborhoodVodafone: data['neighborhood_vodafone'],
      ),
      onError: (context, error) => ModelInheritedError(
        child: child,
        error: '$error',
      ),
      onWait: (context) => child,
    );
  }

  // TODO: generate real requests
  Future<Map<String, dynamic>> _getWeeklyData(final DateTimeRange range) async => {
    'weathers': await _getWeatherData(range),
    'attendance': List.generate(7, (index) => SensorAttendance.test(index), growable: false),
    'visits': List.generate(7, (index) => SensorVisits.test(index), growable: false),
    'campus_vodafone': VodafoneDailyList.test(startingDate: DateTime.now(), area: Area.campus),
    'neighborhood_vodafone': VodafoneDailyList.test(startingDate: DateTime.now(), area: Area.neighborhood)
  };

  Future<List<WeatherDaily>> _getWeatherData(final DateTimeRange range) async {
    // Make requests and check them
    final ambientTemperatureMaxResponse = await fetcher.get(Utils.getWeeklyWeatherTemperatureMaxUri(range));
    switch (ambientTemperatureMaxResponse.statusCode) {
      case 200:
        break;
      case 401:
        throw InvalidTokenException('');
      default:
        throw ambientTemperatureMaxResponse.statusCode;
    }
    final ambientTemperatureMinResponse = await fetcher.get(Utils.getWeeklyWeatherTemperatureMinUri(range));
    switch (ambientTemperatureMinResponse.statusCode) {
      case 200:
        break;
      case 401:
        throw InvalidTokenException('');
      default:
        throw ambientTemperatureMinResponse.statusCode;
    }
    var humidityAndWindResponse;
    if (_isShowingHumidityAndWind) {
      humidityAndWindResponse = await fetcher.get(Utils.getWeeklyWeatherWindAndHumidityAverageUri(range));
      switch (humidityAndWindResponse.statusCode) {
        case 200:
          break;
        case 401:
          throw InvalidTokenException('');
        default:
          throw humidityAndWindResponse.statusCode;
      }
    }
    final rainfallResponse = await fetcher.get(Utils.getWeeklyWeatherRainfallSumUri(range));
    switch (rainfallResponse.statusCode) {
      case 200:
        break;
      case 401:
        throw InvalidTokenException('');
      default:
        throw rainfallResponse.statusCode;
    }
    // Ambient temperature decoding and renaming
    final ambientTemperatureMaxJson = json.decode(ambientTemperatureMaxResponse.body);
    final ambientTemperatureMinJson = json.decode(ambientTemperatureMinResponse.body);
    ambientTemperatureMaxJson['ambient_temperature_max'] = ambientTemperatureMaxJson['ambient_temperature'];
    ambientTemperatureMinJson['ambient_temperature_min'] = ambientTemperatureMinJson['ambient_temperature'];
    ambientTemperatureMaxJson.remove('ambient_temperature');
    ambientTemperatureMinJson.remove('ambient_temperature');
    // Generate complete result
    final result = ambientTemperatureMinJson
      ..addAll(ambientTemperatureMaxJson)
      ..addAll(json.decode(rainfallResponse.body));
    if (_isShowingHumidityAndWind) {
      result..addAll(json.decode(humidityAndWindResponse.body));
    }
    // Return data
    final dispatched = Utils.dispatchThingsboardResponse(result);
    return List.generate(dispatched.length, (index) => WeatherDaily.fromMap(dispatched[index]));
  }

}
