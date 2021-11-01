import 'dart:collection';

import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_attendance.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_visits.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/enum/age.dart';
import 'package:elis_analytics_dashboard/model/enum/distance.dart';
import 'package:elis_analytics_dashboard/model/enum/gender.dart';
import 'package:elis_analytics_dashboard/model/enum/kpi.dart';
import 'package:elis_analytics_dashboard/model/enum/nationality.dart';
import 'package:elis_analytics_dashboard/model/enum/region.dart';
import 'package:elis_analytics_dashboard/model/enum/room_attendance.dart';
import 'package:elis_analytics_dashboard/model/enum/room_visits.dart';
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
        ..addAll(_getSeries(first, false, data))
        ..addAll(_getSeries(second, true, data)),
    );
  }

  // TODO: campusVodafone split
  static List<ChartSeries> _getSeries(KPI kpi, bool isSecond, ModelInheritedWeeklyData data) {
    switch (kpi) {
      case KPI.campusGender: case KPI.neighborhoodGender:
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
      case KPI.campusAge: case KPI.neighborhoodAge:
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
      case KPI.campusAgeAverage: case KPI.neighborhoodAgeAverage:
        return [
          if (!isSecond) StackedColumnSeries<VodafoneDaily, String>(
            dataSource: data.campusVodafone,
            xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
            yValueMapper: (datum, index) => datum.ageAverage,
            legendItemText: '$kpi',
            animationDuration: 0
          ),
          if (isSecond) LineSeries<VodafoneDaily, String>(
            dataSource: data.campusVodafone,
            xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
            yValueMapper: (datum, index) => datum.ageAverage,
            legendItemText: '$kpi',
            animationDuration: 0
          ),
        ];
      case KPI.campusNationality: case KPI.neighborhoodNationality:
        return [
          for (Nationality nationality in Nationality.values)
            StackedColumnSeries<VodafoneDaily, String>(
              dataSource: data.neighborhoodVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.collapse(VodafoneClusterAttribute.nationality)
                .whereCondition((cluster) => cluster.nationality == nationality).visitors,
              legendItemText: '$nationality',
              animationDuration: 0
            )
        ];
      case KPI.campusForeigners: case KPI.neighborhoodForeigners:
        return [
          if (!isSecond) StackedColumnSeries<VodafoneDaily, String>(
              dataSource: data.campusVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.foreignersRatio,
              legendItemText: '$kpi',
              animationDuration: 0
          ),
          if (isSecond) LineSeries<VodafoneDaily, String>(
              dataSource: data.campusVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.foreignersRatio,
              legendItemText: '$kpi',
              animationDuration: 0
          ),
        ];
      case KPI.campusCountries: case KPI.neighborhoodCountries:
        // Collapse before
        final collapsedDailyList = <VodafoneDaily>[];
        for (VodafoneDaily daily in data.campusVodafone) {
          collapsedDailyList.add(daily.collapse(VodafoneClusterAttribute.country));
        }
        // Then get all the countries
        final countries = HashSet<String>();
        collapsedDailyList.forEach((dl) => dl.forEach((e) => countries.add(e.country)));
        // Generate the result
        return [
          for (String country in countries)
            StackedColumnSeries<VodafoneDaily, String>(
              dataSource: data.neighborhoodVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.whereCondition((cluster) => cluster.country == country).visitors,
              legendItemText: country,
              animationDuration: 0
            )
        ];
      case KPI.campusRegion: case KPI.neighborhoodRegion:
        return [
          for (Region region in Region.values)
            StackedColumnSeries<VodafoneDaily, String>(
              dataSource: data.neighborhoodVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.collapse(VodafoneClusterAttribute.nationality)
                .whereCondition((cluster) => cluster.region == region).visitors,
              legendItemText: '$region',
              animationDuration: 0
            )
        ];
      case KPI.campusProvince: case KPI.neighborhoodProvince:
        // Collapse before
        final collapsedDailyList = <VodafoneDaily>[];
        for (VodafoneDaily daily in data.campusVodafone) {
          collapsedDailyList.add(daily.collapse(VodafoneClusterAttribute.province));
        }
        // Then get all the provinces
        final provinces = HashSet<String>();
        collapsedDailyList.forEach((dl) => dl.forEach((e) => provinces.add(e.province)));
        // Generate the result
        return [
          for (String province in provinces)
            StackedColumnSeries<VodafoneDaily, String>(
              dataSource: data.neighborhoodVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.whereCondition((cluster) => cluster.province == province).visitors,
              legendItemText: province,
              animationDuration: 0
            )
        ];
      case KPI.campusMunicipality: case KPI.neighborhoodMunicipality:
        // Collapse before
        final collapsedDailyList = <VodafoneDaily>[];
        for (VodafoneDaily daily in data.campusVodafone) {
          collapsedDailyList.add(daily.collapse(VodafoneClusterAttribute.municipality));
        }
        // Then get all the municipalities
        final municipalities = HashSet<String>();
        collapsedDailyList.forEach((dl) => dl.forEach((e) => municipalities.add(e.municipality)));
        // Generate the result
        return [
          for (String municipality in municipalities)
            StackedColumnSeries<VodafoneDaily, String>(
              dataSource: data.neighborhoodVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.whereCondition((cluster) => cluster.municipality == municipality).visitors,
              legendItemText: municipality,
              animationDuration: 0
            )
        ];
      case KPI.campusHomeDistance: case KPI.neighborhoodHomeDistance:
        return [
          for (Distance distance in Distance.values)
            StackedColumnSeries<VodafoneDaily, String>(
              dataSource: data.neighborhoodVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.collapse(VodafoneClusterAttribute.homeDistance)
                .whereCondition((cluster) => cluster.homeDistance == distance).visitors,
              legendItemText: '$distance',
              animationDuration: 0
            )
        ];
      case KPI.campusWorkDistance: case KPI.neighborhoodWorkDistance:
        return [
          for (Distance distance in Distance.values)
            StackedColumnSeries<VodafoneDaily, String>(
              dataSource: data.neighborhoodVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.collapse(VodafoneClusterAttribute.workDistance)
                .whereCondition((cluster) => cluster.workDistance == distance).visitors,
              legendItemText: '$distance',
              animationDuration: 0
            )
        ];
      case KPI.campusHomeDistanceAverage: case KPI.neighborhoodHomeDistanceAverage:
        return [
          if (!isSecond) StackedColumnSeries<VodafoneDaily, String>(
              dataSource: data.campusVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.homeDistanceAverage,
              legendItemText: '$kpi',
              animationDuration: 0
          ),
          if (isSecond) LineSeries<VodafoneDaily, String>(
              dataSource: data.campusVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.homeDistanceAverage,
              legendItemText: '$kpi',
              animationDuration: 0
          ),
        ];
      case KPI.campusWorkDistanceAverage: case KPI.neighborhoodWorkDistanceAverage:
        return [
          if (!isSecond) StackedColumnSeries<VodafoneDaily, String>(
              dataSource: data.campusVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.workDistanceAverage,
              legendItemText: '$kpi',
              animationDuration: 0
          ),
          if (isSecond) LineSeries<VodafoneDaily, String>(
              dataSource: data.campusVodafone,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
              yValueMapper: (datum, index) => datum.workDistanceAverage,
              legendItemText: '$kpi',
              animationDuration: 0
          ),
        ];
      case KPI.roomsAttendance:
        return [
          for (RoomAttendance room in RoomAttendance.values)
            StackedColumnSeries<SensorAttendance, String>(
              dataSource: data.attendance,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.timestamp),
              yValueMapper: (datum, index) => datum.roomsData.singleWhere((roomData) => roomData.room == room).occupancy,
              legendItemText: '$room',
              animationDuration: 0
            )
        ];
      case KPI.roomsAttendance:
        return [
          for (RoomVisits room in RoomVisits.values)
            StackedColumnSeries<SensorVisits, String>(
              dataSource: data.visits,
              xValueMapper: (datum, index) => _chartDateResolver.format(datum.timestamp),
              yValueMapper: (datum, index) => datum.roomsData.singleWhere((roomData) => roomData.room == room).occupancy,
              legendItemText: '$room',
              animationDuration: 0
            )
        ];
      default:
        throw UnimplementedError('FragmentWeeklyKpiComparatorVisualizer@_getSeries($kpi, $isSecond, ...)');
    }
  }

}
