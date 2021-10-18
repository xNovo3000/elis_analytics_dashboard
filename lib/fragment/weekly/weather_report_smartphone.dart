import 'package:elis_analytics_dashboard/model/data/weather_daily.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';

class FragmentWeeklyWeatherReportSmartphone extends StatelessWidget {

  static final _dateResolver = DateFormat('EEEE d MMMM y', 'it');

  const FragmentWeeklyWeatherReportSmartphone({
    required this.weatherDailyList,
  });

  final List<WeatherDaily> weatherDailyList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var weatherDaily in weatherDailyList)
          ListTile(
            leading: BoxedIcon(weatherDaily.icon),
            title: Text('${weatherDaily.ambientTemperatureMin.floor()}°C - ${weatherDaily.ambientTemperatureMax.floor()}°C'),
            subtitle: Text(_dateResolver.format(weatherDaily.timestamp)),
          ),
      ],
    );
  }

}
