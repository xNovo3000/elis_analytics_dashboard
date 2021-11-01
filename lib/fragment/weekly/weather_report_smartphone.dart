import 'package:elis_analytics_dashboard/model/data/weather_daily.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';

class FragmentWeeklyWeatherReportSmartphone extends StatelessWidget {

  const FragmentWeeklyWeatherReportSmartphone({
    required this.weathers,
  });

  final List<WeatherDaily> weathers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 4),
        Row(
          children: List.generate(
            weathers.length * 2 + 1,
            (index) => index.isOdd ? Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Colors.green[50],
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => Navigator.of(context).pushNamed('/daily/weather_report', arguments: {
                    'weather_report': weathers[(index / 2).floor()],
                  }),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 4),
                      BoxedIcon(weathers[(index / 2).floor()].icon),
                      Text('${weathers[(index / 2).floor()].ambientTemperatureMin.round()}°C'),
                      Text('${weathers[(index / 2).floor()].ambientTemperatureMax.round()}°C'),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
            ) : SizedBox(width: index == 0 ? 12 : 4),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
    // return Column(
    //   children: [
    //     for (var weatherDaily in weatherDailyList)
    //       ListTile(
    //         leading: BoxedIcon(weatherDaily.icon),
    //         title: Text('${weatherDaily.ambientTemperatureMin.floor()}°C - ${weatherDaily.ambientTemperatureMax.floor()}°C'),
    //         subtitle: Text(_dateResolver.format(weatherDaily.timestamp)),
    //       ),
    //   ],
    // );
  }

}
