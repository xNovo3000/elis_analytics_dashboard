import 'package:elis_analytics_dashboard/model/data/weather_instant.dart';
import 'package:elis_analytics_dashboard/model/inherited/weather_report.dart';
import 'package:elis_analytics_dashboard/view/weather_report.dart';
import 'package:flutter/material.dart';

class RouteWeatherReport extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Pre-build the widget
    final child = ViewWeatherReport();
    // Check if there is a WeatherInstant
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic> && args['weather_report'] is WeatherInstant) {
      return ModelInheritedWeatherReport(
        weather: args['weather_report'],
        child: child,
      );
    } else {
      return child;
    }
  }

}
