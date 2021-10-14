import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FragmentDailyMunicipalityChart extends StatelessWidget {

  const FragmentDailyMunicipalityChart({
    this.legendPosition = LegendPosition.right,
    required this.campusVodafoneByMunicipality,
  });

  final LegendPosition legendPosition;
  final VodafoneDaily campusVodafoneByMunicipality;

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: Legend(
        isVisible: true,
        position: legendPosition,
      ),
      series: [
        PieSeries<VodafoneCluster, String>(
          dataSource: campusVodafoneByMunicipality,
          xValueMapper: (datum, index) => '${datum.municipality}',
          yValueMapper: (datum, index) => datum.visitors,
          animationDuration: 0,
        ),
      ],
    );
  }

}
