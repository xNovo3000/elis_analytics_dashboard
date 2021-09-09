import 'package:flutter/material.dart';

class RouteWeatherReport extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check if there is a WeatherInstant
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || !(args is Map<String, dynamic>)) {

    }
    return Container();
  }

}
