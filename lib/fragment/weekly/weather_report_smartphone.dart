import 'package:elis_analytics_dashboard/model/data/weather_daily.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';

class FragmentWeeklyWeatherReportSmartphone extends StatelessWidget {
  
  static final _dateResolver = DateFormat('d/M', 'it');

  const FragmentWeeklyWeatherReportSmartphone({
    required this.weathers,
  });

  final List<WeatherDaily> weathers;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4, horizontal: 2,
      ),
      child: Row(
        children: List.generate(
          weathers.length,
          (index) => Expanded(
            child: Card(
              margin: EdgeInsets.all(2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Colors.green[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 4),
                  Text(_dateResolver.format(weathers[index].timestamp)),
                  BoxedIcon(weathers[index].icon),
                  Text('${weathers[index].ambientTemperatureMin.round()}°C'),
                  Text('${weathers[index].ambientTemperatureMax.round()}°C'),
                  SizedBox(height: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
