import 'package:elis_analytics_dashboard/model/inherited/weather_report.dart';
import 'package:elis_analytics_dashboard/view/weather_report.dart';
import 'package:flutter/material.dart';

class RouteWeatherReport extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Pre-build the widget
    final child = ViewWeatherReport();
    // Check if there is a WeatherInstant
    // TODO: broken logic, fix
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic> && args.containsKey('weather_report')) {
      return ModelInheritedWeatherReport(
        weather: args['weather_report'],
        child: child,
      );
    } else {
      return child;
    }
  }

}
