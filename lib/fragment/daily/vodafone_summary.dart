import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/enum/nationality.dart';
import 'package:flutter/material.dart';

class FragmentDailyVodafoneSummary extends StatelessWidget {

  const FragmentDailyVodafoneSummary({
    this.gridView = false,
    required this.campusVodafone,
    required this.neighborhoodVodafone,
  });

  final bool gridView;
  final VodafoneDaily campusVodafone;
  final VodafoneDaily neighborhoodVodafone;

  @override
  Widget build(BuildContext context) {
    // Calculate visitors
    final campusVodafoneVisitors = campusVodafone.visitors;
    final neighborhoodVodafoneVisitors = neighborhoodVodafone.visitors;
    // Calculate data
    final ageAverage = _getAgeAverage(campusVodafone.collapse(VodafoneClusterAttribute.age), campusVodafoneVisitors);
    final captureRatio = campusVodafoneVisitors / neighborhoodVodafoneVisitors * 100;
    final foreignersPercentage = _generateForeignersPercentage(campusVodafone.collapse(VodafoneClusterAttribute.nationality), campusVodafoneVisitors);
    // Generate children for grid layout
    final rows = [
      [
        ListTile(
          leading: Icon(Icons.people),
          title: Text('Visitatori totali campus'),
          trailing: Text('$campusVodafoneVisitors'),
        ),
        ListTile(
          leading: Icon(Icons.people),
          title: Text('Visitatori totali quartiere'),
          trailing: Text('$neighborhoodVodafoneVisitors'),
        ),
      ],
      [
        ListTile(
          leading: Icon(Icons.people),
          title: Text('Tempo medio di permanenza'),
          trailing: Text('${campusVodafone.dwellTime.inMinutes} minuti'),
        ),
        ListTile(
          leading: Icon(Icons.label),
          title: Text('Età media nel campus'),
          trailing: Text('${ageAverage.round()} anni'),
        ),
      ],
      [
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Tasso di cattura'),
          trailing: Text('${captureRatio.toStringAsFixed(2)}%'),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Percentuale di stranieri nel campus'),
          trailing: Text('${foreignersPercentage.toStringAsFixed(2)}%'),
        ),
      ],
    ];
    // Build UI
    return Column(
      children: gridView ? [
        for (var row in rows)
          Row(
            children: [
              Expanded(
                child: row[0],
              ),
              SizedBox(width: 8),
              Expanded(
                child: row[1],
              ),
            ],
          ),
      ] : [
        for (var row in rows)
          ...row
      ],
    );
  }

  double _getAgeAverage(final VodafoneDaily vodafoneDaily, int visitors) {
    double age = 0;
    vodafoneDaily.forEach((cluster) => age += cluster.visitors * cluster.age.median);
    return age / visitors;
  }

  double _generateForeignersPercentage(VodafoneDaily vodafoneDaily, int visitors) {
    return vodafoneDaily.singleWhere(
      (element) => element.nationality == Nationality.foreigner,
      orElse: () => VodafoneCluster.empty(),
    ).visitors / visitors * 100;
  }

}
