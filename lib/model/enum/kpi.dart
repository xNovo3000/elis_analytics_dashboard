import 'dart:collection';

import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:elis_analytics_dashboard/model/enum/age.dart';
import 'package:elis_analytics_dashboard/model/enum/distance.dart';
import 'package:elis_analytics_dashboard/model/enum/gender.dart';
import 'package:elis_analytics_dashboard/model/enum/nationality.dart';
import 'package:elis_analytics_dashboard/model/enum/region.dart';
import 'package:elis_analytics_dashboard/model/enum/room.dart';
import 'package:elis_analytics_dashboard/model/exception/incompatible_series.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

enum KpiAssignation {
  weather, sensor, crowdCell, cell, na
}

class KPI {

  factory KPI.fromTechnicalName(final String technicalName) =>
    values.singleWhere((kpi) => kpi.technicalName == technicalName);

  const KPI._({
    required this.displayName,
    required this.technicalName,
    required this.complex,
    required this.assignation,
    required this.series,
  });

  final String displayName;
  final String technicalName;
  final bool complex;
  final KpiAssignation assignation;
  final List<ChartSeries> Function(List data, {bool simple, bool to100Percent}) series;

  @override String toString() => displayName;

  static const gender = KPI._(displayName: 'Genere', technicalName: 'gender', complex: true, assignation: KpiAssignation.crowdCell, series: _genderSeries);
  static const age = KPI._(displayName: 'Età', technicalName: 'age', complex: true, assignation: KpiAssignation.crowdCell, series: _ageSeries);
  static const nationality = KPI._(displayName: 'Nazionalità', technicalName: 'nationality', complex: true, assignation: KpiAssignation.crowdCell, series: _nationalitySeries);
  static const country = KPI._(displayName: 'Nazione', technicalName: 'country', complex: true, assignation: KpiAssignation.crowdCell, series: _countrySeries);
  static const region = KPI._(displayName: 'Regione', technicalName: 'region', complex: true, assignation: KpiAssignation.crowdCell, series: _regionSeries);
  static const province = KPI._(displayName: 'Provincia', technicalName: 'province', complex: true, assignation: KpiAssignation.crowdCell, series: _provinceSeries);
  static const municipality = KPI._(displayName: 'Città', technicalName: 'municipality', complex: true, assignation: KpiAssignation.crowdCell, series: _municipalitySeries);
  static const homeDistance = KPI._(displayName: 'Distanza da casa', technicalName: 'home_distance', complex: true, assignation: KpiAssignation.crowdCell, series: _homeDistanceSeries);
  static const workDistance = KPI._(displayName: 'Distanza da lavoro', technicalName: 'work_distance', complex: true, assignation: KpiAssignation.crowdCell, series: _workDistanceSeries);
  static const roomsOccupancy = KPI._(displayName: 'Occupazione aule', technicalName: 'rooms_occupancy', complex: true, assignation: KpiAssignation.sensor, series: _roomsOccupancySeries);

  static const na = KPI._(displayName: 'N/A', technicalName: '', complex: false, assignation: KpiAssignation.na, series: _naSeries);

  static const values = <KPI>[
    gender, nationality, country, region, province,
    municipality, homeDistance, workDistance, roomsOccupancy
  ];

  /* Series functions definitions */

  static final _chartDateResolver = DateFormat('d/M');

  static List<ChartSeries> _genderSeries(List data, {bool simple = false, bool to100Percent = false}) =>
    [
      if (simple) throw IncompatibleSeriesException('GenderSeries is not simple'),
      for (Gender gender in Gender.values)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.gender)
              .whereCondition((cluster) => cluster.gender == gender).visitors,
          legendItemText: '$gender',
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.gender)
              .whereCondition((cluster) => cluster.gender == gender).visitors,
          legendItemText: '$gender',
          animationDuration: 0
        ),
    ];

  static List<ChartSeries> _ageSeries(List data, {bool simple = false, bool to100Percent = false}) =>
    [
      if (simple) throw IncompatibleSeriesException('Age is not simple'),
      for (Age age in Age.values)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.age)
              .whereCondition((cluster) => cluster.age == age).visitors,
          legendItemText: '$age',
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.age)
              .whereCondition((cluster) => cluster.age == age).visitors,
          legendItemText: '$age',
          animationDuration: 0
        ),
    ];

  static List<ChartSeries> _nationalitySeries(List data, {bool simple = false, bool to100Percent = false}) =>
    [
      if (simple) throw IncompatibleSeriesException('Nationality is not simple'),
      for (Nationality nationality in Nationality.values)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.nationality)
              .whereCondition((cluster) => cluster.nationality == nationality).visitors,
          legendItemText: '$nationality',
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.nationality)
              .whereCondition((cluster) => cluster.nationality == nationality).visitors,
          legendItemText: '$nationality',
          animationDuration: 0
        ),
    ];

  static List<ChartSeries> _countrySeries(List data, {bool simple = false, bool to100Percent = false}) {
    // Check
    if (simple) throw IncompatibleSeriesException('Country is not simple');
    // Useful for debug
    data as VodafoneDailyList;
    final countryList = HashSet<String>();
    data.forEach((daily) => daily.forEach((cluster) => countryList.add(cluster.country)));
    return [
      for (String country in countryList)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.country)
              .whereCondition((cluster) => cluster.country == country).visitors,
          legendItemText: country,
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.country)
              .whereCondition((cluster) => cluster.country == country).visitors,
          legendItemText: country,
          animationDuration: 0
        ),
    ];
  }

  static List<ChartSeries> _regionSeries(List data, {bool simple = false, bool to100Percent = false}) =>
    [
      if (simple) throw IncompatibleSeriesException('Region is not simple'),
      for (Region region in Region.values)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.region)
              .whereCondition((cluster) => cluster.region == region).visitors,
          legendItemText: '$region',
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.region)
              .whereCondition((cluster) => cluster.region == region).visitors,
          legendItemText: '$region',
          animationDuration: 0
        ),
    ];

  static List<ChartSeries> _provinceSeries(List data, {bool simple = false, bool to100Percent = false}) {
    // Check
    if (simple) throw IncompatibleSeriesException('Province is not simple');
    // Useful for debug
    data as VodafoneDailyList;
    final provinceList = HashSet<String>();
    data.forEach((daily) => daily.forEach((cluster) => provinceList.add(cluster.province)));
    return [
      for (String province in provinceList)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.province)
              .whereCondition((cluster) => cluster.province == province).visitors,
          legendItemText: province,
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.province)
              .whereCondition((cluster) => cluster.province == province).visitors,
          legendItemText: province,
          animationDuration: 0
        ),
    ];
  }

  static List<ChartSeries> _municipalitySeries(List data, {bool simple = false, bool to100Percent = false}) {
    // Check
    if (simple) throw IncompatibleSeriesException('Municipality is not simple');
    // Useful for debug
    data as VodafoneDailyList;
    final municipalityList = HashSet<String>();
    data.forEach((daily) => daily.forEach((cluster) => municipalityList.add(cluster.municipality)));
    return [
      for (String municipality in municipalityList)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.municipality)
              .whereCondition((cluster) => cluster.municipality == municipality).visitors,
          legendItemText: municipality,
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.municipality)
              .whereCondition((cluster) => cluster.municipality == municipality).visitors,
          legendItemText: municipality,
          animationDuration: 0
        ),
    ];
  }

  static List<ChartSeries> _homeDistanceSeries(List data, {bool simple = false, bool to100Percent = false}) =>
    [
      if (simple) throw IncompatibleSeriesException('Home distance is not simple'),
      for (Distance distance in Distance.values)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.homeDistance)
              .whereCondition((cluster) => cluster.homeDistance == distance).visitors,
          legendItemText: '$distance',
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.homeDistance)
              .whereCondition((cluster) => cluster.homeDistance == distance).visitors,
          legendItemText: '$distance',
          animationDuration: 0
        ),
    ];

  static List<ChartSeries> _workDistanceSeries(List data, {bool simple = false, bool to100Percent = false}) =>
    [
      if (simple) throw IncompatibleSeriesException('Work distance is not simple'),
      for (Distance distance in Distance.values)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.workDistance)
              .whereCondition((cluster) => cluster.workDistance == distance).visitors,
          legendItemText: '$distance',
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.workDistance)
              .whereCondition((cluster) => cluster.workDistance == distance).visitors,
          legendItemText: '$distance',
          animationDuration: 0
        ),
    ];

  static List<ChartSeries> _roomsOccupancySeries(List data, {bool simple = false, bool to100Percent = false}) =>
    [
      if (simple) throw IncompatibleSeriesException('Rooms occupancy is not simple'),
      for (Room room in Room.values)
        to100Percent ? StackedColumn100Series<SensorData, String>(
          dataSource: data as List<SensorData>,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.timestamp),
          yValueMapper: (datum, index) =>
            datum.roomsData.singleWhere((roomData) => roomData.room == room).occupancy,
          legendItemText: '$room',
          animationDuration: 0
        ) : StackedColumnSeries<SensorData, String>(
          dataSource: data as List<SensorData>,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.timestamp),
          yValueMapper: (datum, index) =>
            datum.roomsData.singleWhere((roomData) => roomData.room == room).occupancy,
          legendItemText: '$room',
          animationDuration: 0
        ),
    ];

  static List<ChartSeries> _naSeries(List data, {bool simple = false, bool to100Percent = false}) => [];

  /* TODO: Blacklist system */

}