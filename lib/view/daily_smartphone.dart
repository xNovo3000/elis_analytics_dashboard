import 'package:elis_analytics_dashboard/component/colored_app_bar.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/error.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/wait.dart';
import 'package:elis_analytics_dashboard/component/modal/tile/info.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/container/weather_instant_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/enum/kpi.dart';
import 'package:elis_analytics_dashboard/model/enum/nationality.dart';
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

  static final _dateResolver = DateFormat('EEEE d MMMM y', 'it');
  static const _oneDay = Duration(days: 1);
  static final _minimumDate = DateTime(2021, 6, 28);

  @override
  Widget build(BuildContext context) {
    // Get day
    final day = (ModalRoute.of(context)!.settings.arguments as Map)['day'];
    // Check data
    final error = ModelInheritedError.maybeOf(context);
    final data = ModelInheritedDailyData.maybeOf(context);
    // Build UI
    return Scaffold(
      appBar: ColoredAppBar(
        title: const Text('Visualizzazione giornaliera'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: ListTile(
            title: Text(_dateResolver.format(day)),
            trailing: Wrap(
              children: [
                if (_canGoBackwardInTime(day)) IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).popAndPushNamed(
                    '/daily',
                    arguments: {'day': day.subtract(_oneDay)}
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _onDateSelectPressed(context, day),
                ),
                if (_canGoForwardInTime(day)) IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => Navigator.of(context).popAndPushNamed(
                    '/daily',
                    arguments: {'day': day.add(_oneDay)}
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: data != null
        ? _ViewDailySmartphoneData(day: day)
        : error != null
          ? ComponentModalFullscreenError(error: error.error)
          : ComponentModalFullscreenWait(),
    );
  }

  Future<void> _onDateSelectPressed(BuildContext context, DateTime day) async {
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

  bool _canGoBackwardInTime(DateTime day) => day.isAfter(_minimumDate);
  bool _canGoForwardInTime(DateTime day) => day.add(_oneDay).isBefore(DateTime.now().subtract(_oneDay));

}

class _ViewDailySmartphoneData extends StatelessWidget {

  const _ViewDailySmartphoneData({
    required this.day
  });

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    // Check data
    final data = ModelInheritedDailyData.of(context);
    // Build UI
    return CustomScrollView(
      key: PageStorageKey('_ViewDailySmartphoneDataCustomScrollView'),
      slivers: [
        SliverToBoxAdapter(
          child: _ComponentWeatherReport(
            weathers: data.weathers,
          ),
        ),
        SliverToBoxAdapter(
          child: Divider(indent: 8, endIndent: 8),
        ),
        SliverToBoxAdapter(
          child: _ComponentStaticRoomsOccupation(
            sensors: data.timedSensor,
          ),
        ),
        SliverToBoxAdapter(
          child: _ComponentDynamicRoomsOccupation(
            sensors: data.timedSensor,
          ),
        ),
        SliverToBoxAdapter(
          child: data.hasVodafone ? _ComponentVodafoneDataExists(
            campusVodafoneData: data.campusVodafone!,
            neighborhoodVodafoneData: data.neighborhoodVodafone!,
          ) : ComponentModalTileInfo(
            message: 'Alcuni dati non sono al momento disponibili',
          ),
        ),
      ],
    );
  }

}

class _ComponentWeatherReport extends StatelessWidget {

  static final _hourResolver = DateFormat('HH:mm');

  const _ComponentWeatherReport({
    required this.weathers,
  });

  final WeatherInstantList weathers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'RAPPORTO METEO',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
        ),
        for (var weather in weathers)
          ListTile(
            leading: BoxedIcon(weather.icon),
            title: Text('${weather.ambientTemperature.floor()}°C'),
            subtitle: Text('Umidità: ${weather.humidity.floor()}% · Vento: ${weather.windSpeed.floor()} km/h ${weather.windDirection}'),
            trailing: Text('${_hourResolver.format(weather.beginTimestamp)}-${_hourResolver.format(weather.endTimestamp)}'),
            onTap: () => Navigator.of(context).pushNamed('/daily/weather_report', arguments: {'weather_report': weather}),
          ),
      ],
    );
  }

}

class _ComponentStaticRoomsOccupation extends StatelessWidget {

  static final _chartTimeOfDayResolver = DateFormat('HH:mm');

  const _ComponentStaticRoomsOccupation({
    required this.sensors
  });

  final List<SensorData> sensors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'OCCUPAZIONE AULE',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
        ),
        SfCartesianChart(
          margin: EdgeInsets.all(8),
          primaryXAxis: CategoryAxis(),
          legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            overflowMode: LegendItemOverflowMode.scroll,
          ),
          series: [
            for (Room room in Room.values.where((room) => room.standing))
              StackedColumnSeries<SensorData, String>(
                dataSource: sensors,
                xValueMapper: (datum, index) => _chartTimeOfDayResolver.format(datum.timestamp),
                yValueMapper: (datum, index) => datum.roomsData.singleWhere((roomData) => roomData.room == room).occupancy,
                legendItemText: '$room',
                animationDuration: 0,
              ),
          ],
        )
      ],
    );
  }

}

class _ComponentDynamicRoomsOccupation extends StatelessWidget {

  static final _chartTimeOfDayResolver = DateFormat('HH:mm');

  const _ComponentDynamicRoomsOccupation({
    required this.sensors
  });

  final List<SensorData> sensors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'OCCUPAZIONE ZONE DI TRANSITO',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
        ),
        SfCartesianChart(
          margin: EdgeInsets.all(8),
          primaryXAxis: CategoryAxis(),
          legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            overflowMode: LegendItemOverflowMode.scroll,
          ),
          series: [
            for (Room room in Room.values.where((room) => !room.standing))
              StackedColumnSeries<SensorData, String>(
                dataSource: sensors,
                xValueMapper: (datum, index) => _chartTimeOfDayResolver.format(datum.timestamp),
                yValueMapper: (datum, index) => datum.roomsData.singleWhere((roomData) => roomData.room == room).occupancy,
                legendItemText: '$room',
                animationDuration: 0,
              ),
          ],
        )
      ],
    );
  }

}

class _ComponentVodafoneDataExists extends StatelessWidget {

  static final _mapNumberFormat = NumberFormat('###,###,##0');

  const _ComponentVodafoneDataExists({
    required this.campusVodafoneData,
    required this.neighborhoodVodafoneData,
  });

  final VodafoneDaily campusVodafoneData;
  final VodafoneDaily neighborhoodVodafoneData;

  @override
  Widget build(BuildContext context) {
    // Cache
    final campusCollapsedByMunicipality = campusVodafoneData.collapseFromKPI(KPI.municipality, 7);
    final neighborhoodCollapsedByRegion = neighborhoodVodafoneData.collapseFromKPI(KPI.region);
    final campusVodafoneVisitors = campusVodafoneData.visitors;
    final neighborhoodVodafoneVisitors = neighborhoodVodafoneData.visitors;
    // Generate collapsed data
    final campusCollapsedByAge = campusVodafoneData.collapseFromKPI(KPI.age);
    final campusCollapsedByNationality = campusVodafoneData.collapseFromKPI(KPI.nationality);
    final campusCollapsedByGender = campusVodafoneData.collapseFromKPI(KPI.gender);
    // Cache
    final captureRatio = campusVodafoneVisitors / neighborhoodVodafoneVisitors * 100;
    final ageAverage = _generateAgeAverage(campusCollapsedByAge);
    final foreignersPercentage = _generateForeignersPercentage(campusCollapsedByNationality);
    // Build UI
    return Column(
      children: [
        ListTile(
          title: Text(
            'REGIONI DI PROVENIENZA NEL QUARTIERE',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
          // TODO: aggiungete vedi altro a /daily/regions
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward),
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
                    neighborhoodCollapsedByRegion.singleWhere(
                      (cluster) => cluster.region == Region.values[index],
                      orElse: () => VodafoneCluster.empty(),
                    ).visitors
                  ),
                  shapeColorValueMapper: (index) => _getRegionColorByPercentage(
                    visitors: neighborhoodCollapsedByRegion.singleWhere(
                      (cluster) => cluster.region == Region.values[index],
                      orElse: () => VodafoneCluster.empty(),
                    ).visitors,
                    total: neighborhoodVodafoneVisitors,
                  ),
                ),
              }
            ),
          ),
        ),
        _ComponentHorizontalBarVisualizer(
          data: neighborhoodCollapsedByRegion.collapseFromKPI(KPI.region, 5),
          kpi: KPI.region,
        ),
        ListTile(
          title: Text(
            'CITTÀ DI PROVENIENZA NEL CAMPUS',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
        ),
        SizedBox(
          width: double.infinity, height: MediaQuery.of(context).size.height / 3,
          child: SfCircularChart(
            legend: Legend(
              isVisible: true,
              position: LegendPosition.right,
            ),
            series: [
              PieSeries<VodafoneCluster, String>(
                dataSource: campusCollapsedByMunicipality,
                xValueMapper: (datum, index) => '${datum.municipality}',
                yValueMapper: (datum, index) => datum.visitors,
                animationDuration: 0,
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.people),
          title: Text('Visitatori totali'),
          trailing: Text('$campusVodafoneVisitors'),
        ),
        ListTile(
          leading: Icon(Icons.people),
          title: Text('Tempo medio di permanenza'),
          trailing: Text('${campusVodafoneData.dwellTime.inMinutes} minuti'),
        ),
        ListTile(
          leading: Icon(Icons.label),
          title: Text('Età media'),
          trailing: Text('${ageAverage.round()} anni'),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Tasso di cattura'),
          trailing: Text('${captureRatio.toStringAsFixed(2)}%'),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Percentuale di stranieri'),
          trailing: Text('${foreignersPercentage.toStringAsFixed(2)}%'),
        ),
        SizedBox(
          width: double.infinity, height: MediaQuery.of(context).size.height / 3,
          child: SfCircularChart(
            legend: Legend(
              isVisible: true,
              position: LegendPosition.right,
            ),
            series: [
              PieSeries<VodafoneCluster, String>(
                dataSource: campusCollapsedByGender,
                xValueMapper: (datum, index) => '${datum.gender}',
                yValueMapper: (datum, index) => datum.visitors,
                pointColorMapper: (datum, index) => datum.gender.color,
                animationDuration: 0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  int _generateAgeAverage(VodafoneDaily collapsedCampus) {
    double age = 0;
    for (var cluster in collapsedCampus) {
      age += cluster.visitors * cluster.age.median;
    }
    age /= collapsedCampus.visitors;
    return age.round();
  }

  double _generateForeignersPercentage(VodafoneDaily campusNationality) {
    return campusNationality.singleWhere(
      (element) => element.nationality == Nationality.foreigner,
      orElse: () => VodafoneCluster.empty(),
    ).visitors / campusNationality.visitors * 100;
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

class _ComponentHorizontalBarVisualizer extends StatelessWidget {

  const _ComponentHorizontalBarVisualizer({
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
