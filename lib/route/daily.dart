import 'dart:convert';

import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/component/responsive_layout.dart';
import 'package:elis_analytics_dashboard/foundation/fetcher.dart';
import 'package:elis_analytics_dashboard/foundation/utils.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/container/weather_instant_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_attendance.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_visits.dart';
import 'package:elis_analytics_dashboard/model/enum/area.dart';
import 'package:elis_analytics_dashboard/model/exception/invalid_token.dart';
import 'package:elis_analytics_dashboard/model/inherited/daily_data.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/view/daily_smartphone.dart';
import 'package:flutter/material.dart';

class RouteDaily extends StatelessWidget {

  final fetcher = Fetcher();

  @override
  Widget build(BuildContext context) {
    // Build the child widget
    // TODO: create the second view
    final child = ResponsiveLayout(
      smartphoneWidget: ViewDailySmartphone(),
    );
    // Get specific day from route arguments dispatch
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || !(args is Map<String, dynamic>) || !args.containsKey('day') || !(args['day'] is DateTime)) {
      return ModelInheritedError(
        child: child,
        error: 'Si è verificato un errore sconosciuto',
      );
    }
    // Build UI
    return ComponentManagedFutureBuilder<Map<String, dynamic>>(
      future: _getDailyData(args['day']),
      onSuccess: (context, data) => ModelInheritedDailyData(
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

  // TODO: generate REAL data
  Future<Map<String, dynamic>> _getDailyData(DateTime day) async => {
    'weathers': await _getWeatherData(day),
    'attendance': List.generate(48, (index) => SensorAttendance.test(index), growable: false),
    'visits': List.generate(48, (index) => SensorVisits.test(index), growable: false),
    'campus_vodafone': VodafoneDaily.test(date: DateTime.now(), area: Area.campus),
    'neighborhood_vodafone': VodafoneDaily.test(date: DateTime.now(), area: Area.neighborhood),
  };

  // TODO: create other futures to get data
  Future<WeatherInstantList> _getWeatherData(DateTime day) async {
    // Make requests and check them
    final completeResponse = await fetcher.get(Utils.getDailyCompleteWeatherUri(day));
    switch (completeResponse.statusCode) {
      case 200:
        break;
      case 401:
        throw InvalidTokenException('');
      default:
        throw completeResponse.statusCode;
    }
    final rainfallResponse = await fetcher.get(Utils.getDailyRainfallWeatherUri(day));
    switch (rainfallResponse.statusCode) {
      case 200:
        break;
      case 401:
        throw InvalidTokenException('');
      default:
        throw completeResponse.statusCode;
    }
    // Generate complete result
    final result = json.decode(completeResponse.body)..addAll(json.decode(rainfallResponse.body));
    // Return data
    return WeatherInstantList.fromListAndTotalDuration(Utils.dispatchThingsboardResponse(result), Duration(days: 1));
  }

}
