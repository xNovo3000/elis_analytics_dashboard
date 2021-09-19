import 'package:elis_analytics_dashboard/component/modal/fullscreen/error.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/wait.dart';
import 'package:elis_analytics_dashboard/component/modal/tile/info.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/enum/kpi.dart';
import 'package:elis_analytics_dashboard/model/enum/region.dart';
import 'package:elis_analytics_dashboard/model/enum/room.dart';
import 'package:elis_analytics_dashboard/model/inherited/daily_data.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
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
    final campusByMunicipality = dailyData.campusVodafone?.collapseFromKPI(KPI.municipality, 6);
    final neighborhoodByRegion = dailyData.neighborhoodVodafone?.collapseFromKPI(KPI.region, 6);
    final neighborhoodByRegionMap = dailyData.neighborhoodVodafone?.collapseFromKPI(KPI.region);
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
                onPressed: () => Navigator.of(context).popAndPushNamed(
                  '/daily',
                  arguments: {'day': day.subtract(_oneDay)}
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _onDateSelectPressed(context),
              ),
              if (_canGoForwardInTime) IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => Navigator.of(context).popAndPushNamed(
                  '/daily',
                  arguments: {'day': day.add(_oneDay)}
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
          child: _ViewDailySmartphoneChart(
            timed: dailyData.timedSensor,
            daily: dailyData.dailySensor,
          ),
        ),
        Divider(indent: 8, endIndent: 8),
        ListTile(
          title: Text(
            'PROVENIENZE PER CITTA NEL CAMPUS',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
        ),
        campusByMunicipality != null
          ? _ViewDailySmartphoneByKPI(
              data: campusByMunicipality,
              kpi: KPI.municipality,
            )
          : ComponentModalTileInfo(message: 'I dati non sono ancora disponibili'),
        SizedBox(height: 16),
        Divider(indent: 8, endIndent: 8),
        ListTile(
          title: Text(
            'PROVENIENZE PER REGIONE NEL QUARTIERE',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
          trailing: neighborhoodByRegionMap != null
            ? _ViewDailySmartphoneShowMap(vodafoneDaily: neighborhoodByRegionMap)
            : null,
        ),
        neighborhoodByRegion != null
          ? _ViewDailySmartphoneByKPI(
              data: neighborhoodByRegion,
              kpi: KPI.region,
            )
          : ComponentModalTileInfo(message: 'I dati non sono ancora disponibili'),
        SizedBox(height: 16),
        SizedBox(height: 88),  // 88dp padding at the end
      ],
    );
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

class _ViewDailySmartphoneChart extends StatelessWidget {

  static const _palette = <Color>[
    Color.fromRGBO(75, 135, 185, 1),
    Color.fromRGBO(192, 108, 132, 1),
    Color.fromRGBO(246, 114, 128, 1),
    Color.fromRGBO(248, 177, 149, 1),
    Color.fromRGBO(116, 180, 155, 1),
    Color.fromRGBO(0, 168, 181, 1),
    Color.fromRGBO(73, 76, 162, 1),
    Color.fromRGBO(255, 205, 96, 1),
    Color.fromRGBO(255, 240, 219, 1),
    Color.fromRGBO(238, 238, 238, 1)
  ];
  static final _chartTimeOfDayResolver = DateFormat('HH:mm');

  const _ViewDailySmartphoneChart({
    required this.timed,
    this.daily,
  });

  final List<SensorData> timed;
  final SensorData? daily;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      margin: EdgeInsets.all(8),
      primaryXAxis: CategoryAxis(),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.scroll,
        legendItemBuilder: _legendItemBuilder,
      ),
      series: [
        for (Room room in Room.values)
          StackedColumnSeries<SensorData, String>(
            dataSource: timed,
            xValueMapper: (datum, index) => _chartTimeOfDayResolver.format(datum.timestamp),
            yValueMapper: (datum, index) => datum.roomsData.singleWhere((roomData) => roomData.room == room).occupancy,
            legendItemText: '$room',
            animationDuration: 0,
          ),
      ],
    );
  }

  Widget _legendItemBuilder(String legendText, dynamic series, dynamic point, int seriesIndex) {
    series as StackedColumnSeries<SensorData, String>;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Container(
          width: 14, height: 14,
          color: _palette[seriesIndex % _palette.length],
        ),
        SizedBox(width: 4.0),
        Text(
            '${series.legendItemText!}: '
                '${daily?.roomsData.singleWhere((roomData) => roomData.room == Room.values[seriesIndex]).occupancy ?? 'N/A'}',
            textScaleFactor: 1
        ),
        SizedBox(width: 16.0),
      ],
    );
  }

}

class _ViewDailySmartphoneShowMap extends StatelessWidget {

  static final _mapNumberFormat = NumberFormat('###,###,##0');

  const _ViewDailySmartphoneShowMap({
    required this.vodafoneDaily,
  });

  final VodafoneDaily vodafoneDaily;

  @override
  Widget build(BuildContext context) {
    // Cache results
    final total = vodafoneDaily.visitors;
    // Build the button
    return OutlinedButton(
      child: Text('VEDI MAPPA'),
      onPressed: () => Navigator.of(context).pushNamed(
        '/daily/region_map',
        arguments: {
          'title': 'Mappa delle provenienze',
          'map_shape_source': MapShapeSource.asset(
            'assets/maps/italy.geojson',
            shapeDataField: 'reg_name',
            dataCount: 20,
            primaryValueMapper: (index) => Region.values[index].name,
            dataLabelMapper: (index) => _mapNumberFormat.format(
              vodafoneDaily.singleWhere(
                (cluster) => cluster.region == Region.values[index],
                orElse: () => VodafoneCluster.empty(),
              ).visitors
            ),
            shapeColorValueMapper: (index) => _getRegionColorByPercentage(
              visitors: vodafoneDaily.singleWhere(
                (cluster) => cluster.region == Region.values[index],
                orElse: () => VodafoneCluster.empty(),
              ).visitors,
              total: total,
            ),
          ),
        }
      ),
    );
  }

  Color? _getRegionColorByPercentage({
    required int visitors,
    required int total,
  }) {
    // Cache percentage
    final percentage = visitors / total;
    // Generate color
    if (percentage > 0.9) {
      return Colors.red;
    } else if (percentage > 0.75) {
      return Colors.yellow;
    } else if (percentage > 0.5) {
      return Colors.green;
    } else if (percentage > 0) {
      return Colors.blue;
    }
  }

}


class _ViewDailySmartphoneByKPI extends StatelessWidget {

  const _ViewDailySmartphoneByKPI({
    required this.data,
    required this.kpi,
  });

  final VodafoneDaily data;
  final KPI kpi;

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
                    Text('${_getClusterRequiredName(cluster)}: ${cluster.visitors}'),
                    Text('${(cluster.visitors / total * 100).toStringAsFixed(2)}%'),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  String _getClusterRequiredName(final VodafoneCluster cluster) {
    switch (kpi) {
      case KPI.region:
        return '${cluster.region}';
      case KPI.municipality:
        return cluster.municipality;
      default:
        throw UnimplementedError(
          '_ViewDailySmartphoneByMunicipality#_clusterRequiredName('
          'kpi: $kpi, cluster $cluster)'
        );
    }
  }

}
