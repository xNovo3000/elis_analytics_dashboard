import 'package:elis_analytics_dashboard/model/inherited/weather_report.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class ViewWeatherReportData extends StatelessWidget {

  static final DateFormat _reportDateResolver = DateFormat('', 'it');

  @override
  Widget build(BuildContext context) {
    // Retrieve the report
    final report = ModelInheritedWeatherReport.of(context);
    // Build the UI
    return ListView(
      children: [
        ListTile(

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
      ],
    );
  }

}
