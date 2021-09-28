import 'package:elis_analytics_dashboard/component/colored_app_bar.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/error.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/wait.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/weekly_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class ViewWeeklySmartphone extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check for data
    final weeklyData = ModelInheritedWeeklyData.maybeOf(context);
    final error = ModelInheritedError.maybeOf(context);
    // Build UI
    return Scaffold(
      appBar: ColoredAppBar(
        title: Text('Visualizzazione settimanale'),
      ),
      body: weeklyData != null
        ? _ViewWeeklySmartphoneData(weekRange: (ModalRoute.of(context)!.settings.arguments as Map)['week'])
        : error != null
          ? ComponentModalFullscreenError(error: error.error)
          : ComponentModalFullscreenWait(),
    );
  }

}

class _ViewWeeklySmartphoneData extends StatelessWidget {

  static const _oneWeek = Duration(days: 7);
  static const _epsilonTime = Duration(seconds: 1);
  static final _minimumDate = DateTime(2021, 6, 28);
  static final _startDateResolver = DateFormat('d', 'it');
  static final _endDateResolver = DateFormat('d MMMM yyyy', 'it');
  static final _weatherDateResolver = DateFormat('EEEE d MMMM y', 'it');

  const _ViewWeeklySmartphoneData({
    required this.weekRange,
  });

  final DateTimeRange weekRange;

  @override
  Widget build(BuildContext context) {
    // Retrieve data
    final weeklyData = ModelInheritedWeeklyData.of(context);
    // Build UI
    return ListView(
      key: PageStorageKey('_ViewWeeklySmartphoneDataList'),
      children: [
        ListTile(
          title: Text('${_startDateResolver.format(weekRange.start)}-${_endDateResolver.format(weekRange.end.subtract(_epsilonTime))}'),
          // subtitle: const Text('Settimana'),
          trailing: Wrap(
            children: [
              if (_canGoBackwardInTime) IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).popAndPushNamed(
                  '/weekly',
                  arguments: {'week': DateTimeRange(
                    start: weekRange.start.subtract(_oneWeek),
                    end: weekRange.end.subtract(_oneWeek),
                  )}
                ),
              ),
              if (_canGoForwardInTime) IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => Navigator.of(context).popAndPushNamed(
                  '/weekly',
                  arguments: {'week': DateTimeRange(
                    start: weekRange.start.add(_oneWeek),
                    end: weekRange.end.add(_oneWeek),
                  )}
                ),
              ),
            ],
          ),
        ),
        Divider(indent: 8, endIndent: 8),
        ListTile(
          title: Text(
            'RAPPORTO METEO',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
        ),
        for (var weather in weeklyData.weathers)
          ListTile(
            leading: BoxedIcon(weather.icon),
            title: Text('${weather.ambientTemperatureMin.floor()}°C / ${weather.ambientTemperatureMax.floor()}°C'),
            subtitle: Text(_weatherDateResolver.format(weather.timestamp)),
          ),
        Divider(indent: 8, endIndent: 8),
      ],
    );
  }

  bool get _canGoBackwardInTime => weekRange.start.subtract(_oneWeek).isAfter(_minimumDate);
  bool get _canGoForwardInTime => weekRange.end.add(_oneWeek).isBefore(DateTime.now());

}
