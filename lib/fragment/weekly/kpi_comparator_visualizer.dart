import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/enum/age.dart';
import 'package:elis_analytics_dashboard/model/enum/gender.dart';
import 'package:elis_analytics_dashboard/model/enum/kpi.dart';
import 'package:elis_analytics_dashboard/model/inherited/weekly_data.dart';
import 'package:elis_analytics_dashboard/view/error.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FragmentWeeklyKpiComparatorVisualizer extends StatelessWidget {

  static final _chartDateResolver = DateFormat('d/M', 'it');

  const FragmentWeeklyKpiComparatorVisualizer({
    required this.first,
    required this.second,
  });

  final KPI first;
  final KPI second;

  @override
  Widget build(BuildContext context) {
    // Get weekly data (required)
    final data = ModelInheritedWeeklyData.of(context);
    // Check if second is not complex
    if (second.isComplex) {
      return ViewError(
        error: 'Si è verificato un errore sconosciuto',
      );
    }
    // Build UI
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(),
      axes: [
        NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          opposedPosition: true,
        ),
      ],
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
      ),
      series: <ChartSeries>[]
        ..addAll(_getSeries(first, data))
        ..addAll(_getSeries(second, data)),
    );
  }

  // TODO: finire sto schifo
  static List<ChartSeries> _getSeries(KPI kpi, ModelInheritedWeeklyData data) {
    switch (kpi) {
      case KPI.campusGender:
        return [
          for (Gender gender in Gender.values)
            StackedColumnSeries<VodafoneDaily, String>(
              dataSource: data.campusVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.collapse(VodafoneClusterAttribute.gender)
                .whereCondition((cluster) => cluster.gender == gender).visitors,
              legendItemText: '$gender',
              animationDuration: 0
            )
        ];
      case KPI.neighborhoodGender:
        return [
          for (Gender gender in Gender.values)
            StackedColumnSeries<VodafoneDaily, String>(
              dataSource: data.neighborhoodVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.collapse(VodafoneClusterAttribute.gender)
                .whereCondition((cluster) => cluster.gender == gender).visitors,
              legendItemText: '$gender',
              animationDuration: 0
            )
        ];
      case KPI.campusAge:
        return [
          for (Age age in Age.values)
            StackedColumnSeries<VodafoneDaily, String>(
              dataSource: data.campusVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.collapse(VodafoneClusterAttribute.age)
                .whereCondition((cluster) => cluster.age == age).visitors,
              legendItemText: '$age',
              animationDuration: 0
            )
        ];
      case KPI.neighborhoodAge:
        return [
          for (Age age in Age.values)
            StackedColumnSeries<VodafoneDaily, String>(
              dataSource: data.neighborhoodVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.collapse(VodafoneClusterAttribute.age)
                .whereCondition((cluster) => cluster.age == age).visitors,
              legendItemText: '$age',
              animationDuration: 0
            )
        ];
      case KPI.campusAgeAverage:
        return [
          for (Age age in Age.values)
            StackedColumnSeries<VodafoneDaily, String>(
              dataSource: data.campusVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.collapse(VodafoneClusterAttribute.age)
                .whereCondition((cluster) => cluster.age == age).visitors,
              legendItemText: '$age',
              animationDuration: 0
            )
        ];
      default:
        return [];
    }
  }

}
