import 'package:elis_analytics_dashboard/model/inherited/weather_report.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class ViewWeatherReportData extends StatelessWidget {

  static final DateFormat _reportDateTimeResolver = DateFormat('EEEE d/M/y - HH:mm', 'it');

  @override
  Widget build(BuildContext context) {
    // Retrieve the report
    final report = ModelInheritedWeatherReport.of(context);
    // Build the UI
    return ListView(
      children: [
        ListTile(
          title: Text(_reportDateTimeResolver.format(report.weather.timestamp)),
          subtitle: const Text('Data e ora'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              BoxedIcon(report.weather.icon, size: 72),
              SizedBox(width: 16),
              Text('${report.weather.ambientTemperature.round()}°C', textScaleFactor: 3),
            ],
          ),
        ),
        ListTile(
          leading: BoxedIcon(WeatherIcons.thermometer_internal),
          title: Text('${report.weather.groundTemperature.round()}°C'),
          subtitle: const Text('Temperatura del terreno'),
        ),
        ListTile(
          leading: BoxedIcon(WeatherIcons.barometer),
          title: Text('${report.weather.pressure.round()} mbar'),
          subtitle: const Text('Pressione atmosferica'),
        ),
        ListTile(
          leading: BoxedIcon(WeatherIcons.wind),
          title: Text('${report.weather.windSpeed.round()} km/h ${report.weather.windDirection}'),
          subtitle: const Text('Direzione e velocità del vento'),
        ),
        ListTile(
          leading: BoxedIcon(WeatherIcons.strong_wind),
          title: Text('${report.weather.windGust.round()} km/h'),
          subtitle: const Text('Velocità delle raffiche di vento'),
        ),
        ListTile(
          leading: BoxedIcon(WeatherIcons.humidity),
          title: Text('${report.weather.humidity.round()}%'),
          subtitle: const Text('Umidità'),
        ),
        ListTile(
          leading: BoxedIcon(WeatherIcons.raindrop),
          title: Text('${report.weather.rainfall.round()} mm'),
          subtitle: const Text('Pioggia'),
        ),
      ],
    );
  }

}
