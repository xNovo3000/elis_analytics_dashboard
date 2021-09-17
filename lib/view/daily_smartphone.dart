import 'package:elis_analytics_dashboard/component/modal/fullscreen/error.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/wait.dart';
import 'package:elis_analytics_dashboard/component/modal/tile/info.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:elis_analytics_dashboard/model/enum/kpi.dart';
import 'package:elis_analytics_dashboard/model/enum/room.dart';
import 'package:elis_analytics_dashboard/model/inherited/daily_data.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
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

  static const _oneDay = Duration(days: 1);
  static final _dateResolver = DateFormat('EEEE d MMMM y', 'it');
  static final _hourResolver = DateFormat('HH');
  static final _chartTimeOfDayResolver = DateFormat('HH:mm');
  static final _minimumDate = DateTime(2021, 6, 28);

  const _ViewDailySmartphoneData({
    required this.day,
  });

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    // Extract data
    final dailyData = ModelInheritedDailyData.of(context);
    // Generate custom data
    final campusByRegion = dailyData.campusVodafone?.collapseFromKPI(KPI.region, 6);
    final neighborhoodByRegion = dailyData.neighborhoodVodafone?.collapseFromKPI(KPI.region, 6);
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
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _onDateSelectPressed(context),
              ),
              if (_canGoForwardInTime) IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => _onDateForwardPressed(context),
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
            onTap: () => Navigator.of(context).pushNamed('/daily/weather_report', arguments: {'weather_report': weather}),
          ),
        Divider(indent: 8, endIndent: 8),
        ListTile(
          title: Text(
            'OCCUPAZIONE GIORNALIERA',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
        ),
        SizedBox(
          width: double.infinity, height: MediaQuery.of(context).size.height / 2,
          child: SfCartesianChart(
            margin: EdgeInsets.all(8),
            primaryXAxis: CategoryAxis(),
            zoomPanBehavior: ZoomPanBehavior(
              enablePinching: true,
            ),
            legend: Legend(
              isVisible: true,
              position: LegendPosition.bottom,
              overflowMode: LegendItemOverflowMode.scroll,
            ),
            series: [
              for (Room room in Room.values)
                StackedColumnSeries<SensorData, String>(
                  dataSource: dailyData.timedSensor,
                  xValueMapper: (datum, index) => _chartTimeOfDayResolver.format(datum.timestamp),
                  yValueMapper: (datum, index) => datum.roomsData.singleWhere((roomData) => roomData.room == room).occupancy,
                  legendItemText: '$room',
                  animationDuration: 0,
                ),
            ],
          ),
        ),
        Divider(indent: 8, endIndent: 8),
        ListTile(
          title: Text(
            'PROVENIENZE PER REGIONE NEL CAMPUS',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
        ),
        campusByRegion != null
          ? _ViewDailySmartphoneByRegion(data: campusByRegion)
          : ComponentModalTileInfo(message: 'I dati non sono ancora disponibili'),
        Divider(indent: 8, endIndent: 8),
        ListTile(
          title: Text(
            'PROVENIENZE PER CITTA NEL CAMPUS',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
        ),
        Divider(indent: 8, endIndent: 8),
        ListTile(
          title: Text(
            'PROVENIENZE PER REGIONE NEL QUARTIERE',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
        ),
        Divider(indent: 8, endIndent: 8),
        ListTile(
          title: Text(
            'PROVENIENZE PER CITTA NEL QUARTIERE',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
        ),
        SizedBox(height: 88),  // 88dp padding at the end
      ],
    );
  }

  void _onDateBackPressed(BuildContext context) {
    Navigator.of(context).popAndPushNamed('/daily', arguments: {'day': day.subtract(_oneDay)});
  }

  void _onDateForwardPressed(BuildContext context) {
    Navigator.of(context).popAndPushNamed('/daily', arguments: {'day': day.add(_oneDay)});
  }

  Future<void> _onDateSelectPressed(BuildContext context) async {
    // Generate lastDate
    final now = DateTime.now();
    final lastDate = DateTime(now.year, now.month, now.day).subtract(_oneDay);
    // Show DatePicker
    DateTime? chosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2021, 6, 28),
      initialDate: day,
      lastDate: lastDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    // Go to specific date if present
    if (chosenDate != null) {
      Navigator.popAndPushNamed(context, '/daily', arguments: {'day': chosenDate});
    }
  }

  bool get _canGoBackwardInTime => day.isAfter(_minimumDate);
  bool get _canGoForwardInTime => day.add(_oneDay).isBefore(DateTime.now().subtract(_oneDay));

}

class _ViewDailySmartphoneByRegion extends StatelessWidget {

  const _ViewDailySmartphoneByRegion({
    required this.data,
  });

  final VodafoneDaily data;

  @override
  Widget build(BuildContext context) {
    // Cache total
    final total = data.visitors;
    // Build UI
    return Column(
      children: [
        for (var cluster in data)
          Padding(
            padding: EdgeInsets.only(
              left: 16, right: 16, top: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LinearProgressIndicator(
                  value: cluster.visitors / total,
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  minHeight: 10,
                ),
                SizedBox(height: 2),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Text('${cluster.region}: ${cluster.visitors}', textScaleFactor: 1.2),
                    Text('${(cluster.visitors / total * 100).toStringAsFixed(2)}%', textScaleFactor: 1.2),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

}

