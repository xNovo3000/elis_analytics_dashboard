import 'package:elis_analytics_dashboard/component/colored_app_bar.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/error.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/wait.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/data/weather_instant.dart';
import 'package:elis_analytics_dashboard/model/enum/kpi.dart';
import 'package:elis_analytics_dashboard/model/enum/nationality.dart';
import 'package:elis_analytics_dashboard/model/enum/room.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/realtime_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_icons/weather_icons.dart';

class ViewRealtimeSmartphone extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check data
    final data = ModelInheritedRealtimeData.maybeOf(context);
    final error = ModelInheritedError.maybeOf(context);
    // Build UI
    return Scaffold(
      appBar: ColoredAppBar(
        title: Text('Visualizzazione in tempo reale'),
      ),
      body: data != null
        ? _ViewRealtimeSmartphoneData()
        : error != null
          ? ComponentModalFullscreenError(error: error.error)
          : ComponentModalFullscreenWait(),
    );
  }

}

class _ViewRealtimeSmartphoneData extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Get data
    final data = ModelInheritedRealtimeData.of(context);
    // Build UI
    return CustomScrollView(
      key: PageStorageKey('_ViewRealtimeSmartphoneDataCustomScrollView'),
      slivers: [
        SliverToBoxAdapter(
          child: _ComponentStaticRoomsOccupancy(
            sensorData: data.realtimeSensorData,
          ),
        ),
        SliverToBoxAdapter(
          child: _ComponentDynamicRoomsOccupancy(
            sensorData: data.realtimeSensorData,
          ),
        ),
        SliverToBoxAdapter(
          child: _ComponentDwellTime(
            sensorData: data.realtimeSensorData,
          ),
        ),
        SliverToBoxAdapter(
          child: Divider(indent: 8, endIndent: 8),
        ),
        SliverToBoxAdapter(
          child: _ComponentWeatherReport(
            weatherInstant: data.weather,
          ),
        ),
        SliverToBoxAdapter(
          child: Divider(indent: 8, endIndent: 8),
        ),
        SliverToBoxAdapter(
          child: _ComponentPredictions(
            campusVodafoneData: data.campusVodafoneData,
            neighborhoodVodafoneData: data.neighborhoodVodafoneData,
          ),
        ),
      ],
    );
  }

}

class _ComponentStaticRoomsOccupancy extends StatelessWidget {

  const _ComponentStaticRoomsOccupancy({
    required this.sensorData,
  });

  final SensorData sensorData;

  @override
  Widget build(BuildContext context) {
    // Get rooms data
    final roomLagrangeData = sensorData.roomsData.singleWhere((roomData) => roomData.room == Room.lagrange);
    final roomPascalData = sensorData.roomsData.singleWhere((roomData) => roomData.room == Room.pascal);
    // Build UI
    return Column(
      children: [
        ListTile(
          title: Text('MONITORAGGIO OCCUPAZIONE ANTIASSEMBRAMENTO', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Card( // Height is 62 + image
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Text('${roomLagrangeData.room}'),
                      ),
                      // TODO: add image here
                      SizedBox(
                        width: double.infinity, height: 96,
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          '${roomLagrangeData.occupancy >= roomLagrangeData.room.capacity ? 'ALT' : 'OK'}: '
                          '${roomLagrangeData.occupancy}/${roomLagrangeData.room.capacity}'
                        ),
                        decoration: BoxDecoration(
                          color: roomLagrangeData.color,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Text('${roomPascalData.room}'),
                      ),
                      // TODO: add image here
                      SizedBox(
                        width: double.infinity, height: 96,
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          '${roomPascalData.occupancy >= roomPascalData.room.capacity ? 'ALT' : 'OK'}: '
                          '${roomPascalData.occupancy}/${roomPascalData.room.capacity}'
                        ),
                        decoration: BoxDecoration(
                          color: roomPascalData.color,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}

class _ComponentDynamicRoomsOccupancy extends StatelessWidget {

  const _ComponentDynamicRoomsOccupancy({
    required this.sensorData,
  });

  final SensorData sensorData;

  @override
  Widget build(BuildContext context) {
    // Get rooms data
    final roomsData = sensorData.roomsData.where((roomData) => !roomData.room.standing);
    // Build UI
    return Column(
      children: [
        ListTile(
          title: Text('MONITORAGGIO FLUSSO PASSANTI IN 10 MINUTI', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
        SizedBox(
          width: double.infinity, height: 158,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: roomsData.length,
            itemBuilder: (context, index) => SizedBox(
              width: 120, height: double.infinity,
              child: Card( // Height is 62 + image
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Text('${roomsData.elementAt(index).room}'),
                    ),
                    // TODO: add image here
                    SizedBox(
                      width: double.infinity, height: 96,
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        '${roomsData.elementAt(index).occupancy}/${roomsData.elementAt(index).room.capacity}'
                      ),
                      decoration: BoxDecoration(
                        // color: roomsData.elementAt(index).color,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}

class _ComponentDwellTime extends StatelessWidget {

  const _ComponentDwellTime({
    required this.sensorData,
  });

  final SensorData sensorData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${sensorData.dwellTime.inMinutes} minuti'),
      subtitle: Text('Tempo medio di permanenza'),
    );
  }

}

class _ComponentWeatherReport extends StatelessWidget {

  const _ComponentWeatherReport({
    required this.weatherInstant,
  });

  final WeatherInstant weatherInstant;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('RAPPORTO METEO', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
        ListTile(
          leading: BoxedIcon(weatherInstant.icon, color: weatherInstant.iconColor),
          title: Text('Temperatura: ${weatherInstant.ambientTemperature.round()}°C'),
          subtitle: Text(
            'Vento: ${weatherInstant.windSpeed.round()} km/h ${weatherInstant.windDirection} · '
            'Umidità: ${weatherInstant.humidity.round()}%'
          ),
          // isThreeLine: true,
        ),
      ],
    );
  }

}

class _ComponentPredictions extends StatelessWidget {

  static final _dateResolver = DateFormat('EEEE', 'it');

  const _ComponentPredictions({
    required this.campusVodafoneData,
    required this.neighborhoodVodafoneData,
  });

  final VodafoneDailyList campusVodafoneData;
  final VodafoneDailyList neighborhoodVodafoneData;

  @override
  Widget build(BuildContext context) {
    // Cache visitors and capture ratio
    final campusVodafoneVisitors = campusVodafoneData.visitors;
    final neighborhoodVodafoneVisitors = neighborhoodVodafoneData.visitors;
    final captureRatio = campusVodafoneVisitors / neighborhoodVodafoneVisitors * 100;
    // Generate collapsed data
    final campusCollapsedByAge = campusVodafoneData.collapseFromKPI(KPI.age);
    final campusCollapsedByNationality = campusVodafoneData.collapseFromKPI(KPI.nationality);
    final campusCollapsedByGender = campusVodafoneData.collapseFromKPI(KPI.gender);
    // Generate final data
    final ageAverage = _generateAgeAverage(campusCollapsedByAge);
    final foreignersPercentage = _generateForeignersPercentage(campusCollapsedByNationality);
    // Build UI
    return Column(
      children: [
        ListTile(
          title: Text('PREVISIONI PER OGGI', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          subtitle: Text('Rispetto $_dateString precedenti'),
        ),
        ListTile(
          leading: Icon(Icons.people),
          title: Text('Visitatori attesi'),
          trailing: Text('${(campusVodafoneData.visitors / campusVodafoneData.length).round()}'),
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

  String get _dateString {
    final now = DateTime.now();
    if (now.weekday == 7) {
      return 'alle ${_dateResolver.format(now)}';
    } else {
      return 'ai ${_dateResolver.format(now)}';
    }
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

}
