import 'package:elis_analytics_dashboard/component/modal/fullscreen/error.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/wait.dart';
import 'package:elis_analytics_dashboard/model/inherited/daily_data.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class ViewDailySmartphone extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check data
    final error = ModelInheritedError.maybeOf(context);
    final data = ModelInheritedDailyData.maybeOf(context);
    // Build UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizzazione giornaliera'),
      ),
      body: data != null
        ? _ViewDailySmartphoneData(
          day: (ModalRoute.of(context)!.settings.arguments as Map)['day']
        )
        : error != null
          ? ComponentModalFullscreenError(error: error.error)
          : ComponentModalFullscreenWait(),
    );
  }

}

class _ViewDailySmartphoneData extends StatelessWidget {

  static final _dateResolver = DateFormat('EEEE d MMMM y', 'it');
  static final _hourResolver = DateFormat('HH');

  const _ViewDailySmartphoneData({
    required this.day,
  });

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    // Extract data
    final dailyData = ModelInheritedDailyData.of(context);
    // Build UI
    return ListView(
      key: PageStorageKey('_ViewDailySmartphoneDataList'),
      children: [
        ListTile(
          title: Text(_dateResolver.format(day)),
          subtitle: const Text('Data'),
          trailing: Wrap(
            children: [
              if (_canGoBackwardInTime) IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => _onDateBackPressed(context),
              ),
              if (_canGoForwardInTime) IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => _onDateForwardPressed(context),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _onDateSelectPressed(context),
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
        for (var weather in dailyData.weathers)
          ListTile(
            leading: BoxedIcon(weather.icon),
            title: Text('${weather.ambientTemperature.floor()}°C'),
            subtitle: Text('Umidità: ${weather.humidity.floor()}% · Vento: ${weather.windSpeed.floor()} km/h ${weather.windDirection}'),
            trailing: Text('${_hourResolver.format(weather.beginTimestamp)}-${_hourResolver.format(weather.endTimestamp)}'),
          ),
        Divider(indent: 8, endIndent: 8),
      ],
    );
  }

  void _onDateBackPressed(BuildContext context) {

  }

  void _onDateForwardPressed(BuildContext context) {

  }

  void _onDateSelectPressed(BuildContext context) {

  }

  bool get _canGoBackwardInTime => day.isAfter(DateTime(2021, 06, 28));
  bool get _canGoForwardInTime => day.add(const Duration(days: 1)).isBefore(DateTime.now().subtract(const Duration(days: 1)));

}
