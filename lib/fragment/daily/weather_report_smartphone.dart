import 'package:elis_analytics_dashboard/model/container/weather_instant_list.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class FragmentDailyWeatherReportSmartphone extends StatelessWidget {

  const FragmentDailyWeatherReportSmartphone({
    required this.weathers,
  });

  final WeatherInstantList weathers;

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
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.green[50],
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.of(context).pushNamed('/daily/weather_report', arguments: {
                    'weather_report': weathers[(index / 2).floor()],
                  }),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 8),
                      BoxedIcon(weathers[(index / 2).floor()].icon, size: 36),
                      Text('${weathers[(index / 2).floor()].ambientTemperature.round()}°C', textScaleFactor: 1.5),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ) : SizedBox(width: index == 0 ? 24 : 8),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

}
