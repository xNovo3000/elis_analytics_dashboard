import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FragmentDailyGenderChart extends StatelessWidget {

  const FragmentDailyGenderChart({
    required this.campusVodafoneByGender,
  });

  final VodafoneDaily campusVodafoneByGender;

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: Legend(
        isVisible: true,
        position: LegendPosition.right,
      ),
      series: [
        PieSeries<VodafoneCluster, String>(
          dataSource: campusVodafoneByGender,
          xValueMapper: (datum, index) => '${datum.gender}',
          yValueMapper: (datum, index) => datum.visitors,
          pointColorMapper: (datum, index) => datum.gender.color,
          animationDuration: 0,
        ),
      ],
    );
  }

}
