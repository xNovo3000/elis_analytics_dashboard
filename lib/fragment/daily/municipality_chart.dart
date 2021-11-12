import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FragmentDailyMunicipalityChart extends StatelessWidget {

  const FragmentDailyMunicipalityChart({
    this.legendPosition = LegendPosition.bottom,
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
        overflowMode: LegendItemOverflowMode.scroll,
      ),
      series: [
        PieSeries<VodafoneCluster, String>(
          dataSource: campusVodafoneByMunicipality,
          xValueMapper: (datum, index) => datum.municipality,
          yValueMapper: (datum, index) => datum.visitors,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          dataLabelMapper: (datum, index) => '${datum.visits}',
          animationDuration: 0,
        ),
      ],
    );
  }

}
