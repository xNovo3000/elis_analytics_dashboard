import 'package:elis_analytics_dashboard/model/inherited/weather_report.dart';
import 'package:elis_analytics_dashboard/view/error.dart';
import 'package:elis_analytics_dashboard/view/weather_report/data.dart';
import 'package:flutter/material.dart';

class ViewWeatherReport extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check if there is the report
    final report = ModelInheritedWeatherReport.maybeOf(context);
    // Build the resulting widget
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rapporto meteo'),
      ),
      body: report != null
        ? ViewWeatherReportData()
        : ViewError(error: 'Si è verificato un errore sconosciuto'),
    );
  }

}