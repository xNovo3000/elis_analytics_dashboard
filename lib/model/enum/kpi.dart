import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/enum/age.dart';
import 'package:elis_analytics_dashboard/model/enum/gender.dart';
import 'package:elis_analytics_dashboard/model/enum/nationality.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class KPI {

  factory KPI.fromTechnicalName(final String technicalName) =>
    values.singleWhere((kpi) => kpi.technicalName == technicalName);

  const KPI._({
    required this.displayName,
    required this.technicalName,
    this.series = _unimplementedSeries,
  });

  final String displayName;
  final String technicalName;
  final List Function(List) series;

  @override String toString() => displayName;

  static const gender = KPI._(displayName: 'Genere', technicalName: 'gender', series: _genderSeries);
  static const age = KPI._(displayName: 'Età', technicalName: 'age', series: _ageSeries);
  static const nationality = KPI._(displayName: 'Nazionalità', technicalName: 'nationality', series: _nationalitySeries);
  static const country = KPI._(displayName: 'Nazione', technicalName: 'country');
  static const region = KPI._(displayName: 'Regione', technicalName: 'region');
  static const province = KPI._(displayName: 'Provincia', technicalName: 'province');
  static const municipality = KPI._(displayName: 'Città', technicalName: 'municipality');
  static const homeDistance = KPI._(displayName: 'Distanza da casa', technicalName: 'home_distance');
  static const workDistance = KPI._(displayName: 'Distanza da lavoro', technicalName: 'work_distance');
  static const roomsOccupancy = KPI._(displayName: 'Occupazione aule', technicalName: 'rooms_occupancy');

  static const values = const <KPI>[
    gender, nationality, country, region, province,
    municipality, homeDistance, workDistance, roomsOccupancy
  ];

  /* Series functions definitions */

  static final _chartDateResolver = DateFormat('d/M');

  static List _unimplementedSeries(List data) =>
    throw UnimplementedError("KPI#_ not implemented");

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
    // TODO: generate new VodafoneDailyList with collapsed data
    for (VodafoneDaily vodafoneDaily in data as VodafoneDailyList) {

    }
    return [];
  }

}