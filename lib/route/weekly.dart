import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/component/responsive_layout.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_attendance.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_visits.dart';
import 'package:elis_analytics_dashboard/model/data/weather_daily.dart';
import 'package:elis_analytics_dashboard/model/enum/area.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/weekly_data.dart';
import 'package:elis_analytics_dashboard/view/weekly_smartphone.dart';
import 'package:flutter/material.dart';

class RouteWeekly extends StatelessWidget {

  static const _underConstruction = false;

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
    if (args == null || !(args is Map<String, dynamic>) || !(args['week'] is DateTimeRange)) {
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
  Future<Map<String, dynamic>> _getWeeklyData(final DateTimeRange range) async =>
    Future.delayed(Duration(seconds: 1), () => {
      'weathers': List.generate(7, (index) => WeatherDaily.test(index), growable: false),
      'attendance': List.generate(7, (index) => SensorAttendance.test(index), growable: false),
      'visits': List.generate(7, (index) => SensorVisits.test(index), growable: false),
      'campus_vodafone': VodafoneDailyList.test(startingDate: DateTime.now(), area: Area.campus),
      'neighborhood_vodafone': VodafoneDailyList.test(startingDate: DateTime.now(), area: Area.neighborhood)
    });

}
