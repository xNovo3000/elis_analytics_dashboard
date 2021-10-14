import 'package:elis_analytics_dashboard/model/container/weather_instant_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class FragmentDailyWeatherReportSmartphone extends StatelessWidget {

  static final _hourResolver = DateFormat('HH:mm');

  const FragmentDailyWeatherReportSmartphone({
    required this.weathers,
  });

  final WeatherInstantList weathers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var weather in weathers)
          ListTile(
            leading: BoxedIcon(weather.icon),
            title: Text('${weather.ambientTemperature.floor()}°C'),
            subtitle: Text('Umidità: ${weather.humidity.floor()}% · Vento: ${weather.windSpeed.floor()} km/h ${weather.windDirection}'),
            trailing: Text('${_hourResolver.format(weather.beginTimestamp)}-${_hourResolver.format(weather.endTimestamp)}'),
            onTap: () => Navigator.of(context).pushNamed('/daily/weather_report', arguments: {'weather_report': weather}),
          ),
      ],
    );
  }

}
