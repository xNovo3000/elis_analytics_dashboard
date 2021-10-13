import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/component/responsive_layout.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/container/weather_instant_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:elis_analytics_dashboard/model/enum/area.dart';
import 'package:elis_analytics_dashboard/model/inherited/daily_data.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/view/daily_smartphone.dart';
import 'package:flutter/material.dart';

class RouteDaily extends StatelessWidget {

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
        dailySensor: data['daily_sensor'],
        timedSensor: data['timed_sensor'],
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
  Future<Map<String, dynamic>> _getDailyData(final DateTime day) async => {
    'weathers': WeatherInstantList.test(length: 4),
    'daily_sensor': SensorData.test(),
    'timed_sensor': List.generate(48, (index) => SensorData.test(index), growable: false),
    'campus_vodafone': VodafoneDaily.test(date: DateTime.now(), area: Area.campus),
    'neighborhood_vodafone': VodafoneDaily.test(date: DateTime.now(), area: Area.neighborhood),
  };

  // TODO: create other futures to get data

}
