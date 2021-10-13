import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/enum/nationality.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FragmentRealtimeExpectations extends StatelessWidget {

  static final _dateResolver = DateFormat('EEEE', 'it');

  const FragmentRealtimeExpectations({
    required this.campusVodafoneData,
    required this.neighborhoodVodafoneData,
    this.forceExpand = false,
  });

  final VodafoneDailyList campusVodafoneData;
  final VodafoneDailyList neighborhoodVodafoneData;
  final bool forceExpand;

  @override
  Widget build(BuildContext context) {
    // Cache visitors and capture ratio
    final campusVisitors = campusVodafoneData.visitors;
    final neighborhoodVisitors = neighborhoodVodafoneData.visitors;
    final captureRatio = campusVisitors / neighborhoodVisitors * 100;
    // Generate collapsed data
    final campusCollapsedByAge = campusVodafoneData.collapse(VodafoneClusterAttribute.age);
    final campusCollapsedByNationality = campusVodafoneData.collapse(VodafoneClusterAttribute.nationality);
    final campusCollapsedByGender = campusVodafoneData.collapse(VodafoneClusterAttribute.gender);
    // Generate final data
    final ageAverage = _generateAgeAverage(campusCollapsedByAge, campusVisitors);
    final foreignersPercentage = _generateForeignersPercentage(campusCollapsedByNationality, campusVisitors);
    // Build Pie widget
    final pieWidget = SfCircularChart(
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
    );
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
        forceExpand ? Expanded(
          child: pieWidget,
        ) : SizedBox(
          width: double.infinity, height: MediaQuery.of(context).size.height / 3,
          child: pieWidget,
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

  int _generateAgeAverage(VodafoneDaily collapsedCampus, int visitors) {
    double age = 0;
    for (var cluster in collapsedCampus) {
      age += cluster.visitors * cluster.age.median;
    }
    age /= visitors;
    return age.round();
  }

  double _generateForeignersPercentage(VodafoneDaily campusNationality, int visitors) {
    return campusNationality.singleWhere(
      (element) => element.nationality == Nationality.foreigner,
      orElse: () => VodafoneCluster.empty(),
    ).visitors / visitors * 100;
  }

}
