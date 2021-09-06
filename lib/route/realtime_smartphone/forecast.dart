import 'package:elis_analytics_dashboard/model/data/weather_instant.dart';
import 'package:flutter/material.dart';

class RouteRealtimeSmartphoneForecast extends StatelessWidget {

  const RouteRealtimeSmartphoneForecast({
    required this.forecast
  });

  final WeatherInstant forecast;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rapporto meteo'),
      ),
    );
  }

}
