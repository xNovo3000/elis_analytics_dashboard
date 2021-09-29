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
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class KPI {

  factory KPI.fromTechnicalName(final String technicalName) =>
    values.singleWhere((kpi) => kpi.technicalName == technicalName);

  const KPI._({
    required this.displayName,
    required this.technicalName,
    required this.series,
  });

  final String displayName;
  final String technicalName;
  final List Function(List) series;

  @override String toString() => displayName;

  static const gender = KPI._(displayName: 'Genere', technicalName: 'gender', series: _genderSeries);
  static const age = KPI._(displayName: 'Età', technicalName: 'age', series: _ageSeries);
  static const nationality = KPI._(displayName: 'Nazionalità', technicalName: 'nationality', series: _nationalitySeries);
  static const country = KPI._(displayName: 'Nazione', technicalName: 'country', series: _countrySeries);
  static const region = KPI._(displayName: 'Regione', technicalName: 'region', series: _regionSeries);
  static const province = KPI._(displayName: 'Provincia', technicalName: 'province', series: _provinceSeries);
  static const municipality = KPI._(displayName: 'Città', technicalName: 'municipality', series: _municipalitySeries);
  static const homeDistance = KPI._(displayName: 'Distanza da casa', technicalName: 'home_distance', series: _homeDistanceSeries);
  static const workDistance = KPI._(displayName: 'Distanza da lavoro', technicalName: 'work_distance', series: _workDistanceSeries);
  static const roomsOccupancy = KPI._(displayName: 'Occupazione aule', technicalName: 'rooms_occupancy', series: _roomsOccupancySeries);

  static const values = const <KPI>[
    gender, nationality, country, region, province,
    municipality, homeDistance, workDistance, roomsOccupancy
  ];

  /* Series functions definitions */

  static final _chartDateResolver = DateFormat('d/M');

  // Used only in certain situations
  // static List _unimplementedSeries(List data) =>
  //   throw UnimplementedError("KPI#_ not implemented");

  static List _genderSeries(List data) =>
    [
      for (Gender gender in Gender.values)
        StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.gender)
              .whereCondition((cluster) => cluster.gender == gender).visitors,
          legendItemText: '$gender',
          animationDuration: 0
        ),
    ];

  static List _ageSeries(List data) =>
    [
      for (Age age in Age.values)
        StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.age)
              .whereCondition((cluster) => cluster.age == age).visitors,
          legendItemText: '$age',
          animationDuration: 0
        ),
    ];

  static List _nationalitySeries(List data) =>
    [
      for (Nationality nationality in Nationality.values)
        StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.nationality)
              .whereCondition((cluster) => cluster.nationality == nationality).visitors,
          legendItemText: '$nationality',
          animationDuration: 0
        ),
    ];

  static List _countrySeries(List data) {
    // Useful for debug
    data as VodafoneDailyList;
    final countryList = HashSet<String>();
    data.forEach((daily) => daily.forEach((cluster) => countryList.add(cluster.country)));
    return [
      for (String country in countryList)
        StackedColumnSeries<VodafoneDaily, String>(
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

  static List _regionSeries(List data) =>
    [
      for (Region region in Region.values)
        StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.nationality)
              .whereCondition((cluster) => cluster.region == region).visitors,
          legendItemText: '$region',
          animationDuration: 0
        ),
    ];

  static List _provinceSeries(List data) {
    // Useful for debug
    data as VodafoneDailyList;
    final provinceList = HashSet<String>();
    data.forEach((daily) => daily.forEach((cluster) => provinceList.add(cluster.province)));
    return [
      for (String province in provinceList)
        StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
          datum.collapseFromKPI(KPI.country)
              .whereCondition((cluster) => cluster.province == province).visitors,
          legendItemText: province,
          animationDuration: 0
        ),
    ];
  }

  static List _municipalitySeries(List data) {
    // Useful for debug
    data as VodafoneDailyList;
    final municipalityList = HashSet<String>();
    data.forEach((daily) => daily.forEach((cluster) => municipalityList.add(cluster.municipality)));
    return [
      for (String municipality in municipalityList)
        StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
          datum.collapseFromKPI(KPI.country)
              .whereCondition((cluster) => cluster.municipality == municipality).visitors,
          legendItemText: municipality,
          animationDuration: 0
        ),
    ];
  }

  static List _homeDistanceSeries(List data) =>
    [
      for (Distance distance in Distance.values)
        StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.nationality)
              .whereCondition((cluster) => cluster.homeDistance == distance).visitors,
          legendItemText: '$distance',
          animationDuration: 0
        ),
    ];

  static List _workDistanceSeries(List data) =>
    [
      for (Distance distance in Distance.values)
        StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.nationality)
              .whereCondition((cluster) => cluster.workDistance == distance).visitors,
          legendItemText: '$distance',
          animationDuration: 0
        ),
    ];

  static List _roomsOccupancySeries(List data) =>
    [
      for (Room room in Room.values)
        StackedColumnSeries<SensorData, String>(
          dataSource: data as List<SensorData>,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.timestamp),
          yValueMapper: (datum, index) =>
            datum.roomsData.singleWhere((roomData) => roomData.room == room).occupancy,
          legendItemText: '$room',
          animationDuration: 0
        ),
    ];

}