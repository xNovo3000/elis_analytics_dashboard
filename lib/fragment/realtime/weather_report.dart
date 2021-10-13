import 'package:elis_analytics_dashboard/model/data/weather_instant.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';

class FragmentRealtimeWeatherReport extends StatelessWidget {

  const FragmentRealtimeWeatherReport({
    required this.weatherInstant,
  });

  final WeatherInstant weatherInstant;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: BoxedIcon(weatherInstant.icon, color: weatherInstant.iconColor),
      title: Text('Temperatura: ${weatherInstant.ambientTemperature.round()}°C'),
      subtitle: Text(
        'Vento: ${weatherInstant.windSpeed.round()} km/h ${weatherInstant.windDirection} · '
        'Umidità: ${weatherInstant.humidity.round()}%'
      ),
      // isThreeLine: true,
    );
  }

}
