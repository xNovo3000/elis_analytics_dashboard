import 'dart:collection';

import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/enum/area.dart';
import 'package:elis_analytics_dashboard/model/enum/kpi.dart';

class VodafoneDaily extends ListBase<VodafoneCluster> implements Comparable<VodafoneDaily> {

  factory VodafoneDaily.test({
    required DateTime date,
    required Area area,
  }) => VodafoneDaily(
    List.generate(
      15,
      (index) => VodafoneCluster.test(),
      growable: false
    ),
    date: date,
    area: area
  );

  factory VodafoneDaily.fromList({
    required List<Map<String, dynamic>> list,
    required DateTime date,
    required Area area,
  }) => VodafoneDaily(
    List.generate(
      list.length,
      (index) => VodafoneCluster.fromMap(list[index]),
      growable: false,
    ),
    date: date,
    area: area
  );

  VodafoneDaily(this._list, {
    required this.date,
    required this.area,
  });

  final List<VodafoneCluster> _list;
  final DateTime date;
  final Area area;

  @override int get length => _list.length;
  @override set length(int newLength) => _list.length = newLength;
  @override VodafoneCluster operator [](int index) => _list[index];
  @override void operator []=(int index, VodafoneCluster value) => _list[index] = value;

  int get visitors {
    int total = 0;
    forEach((cluster) => total += cluster.visitors);
    return total;
  }

  VodafoneDaily whereCondition(bool Function(VodafoneCluster element) test) => VodafoneDaily(
    List.of(super.where(test)),
    date: date,
    area: area
  );

  VodafoneDaily collapseFromKPI(final KPI kpi, [int maxClusters = 0xFFFFFFFF]) {
    final result = <VodafoneCluster>[];
    for (VodafoneCluster cluster in this) {
      try {
        var cx;
        switch (kpi) {
          case KPI.gender:
            cx = result.singleWhere((resultCluster) => cluster.gender == resultCluster.gender);
            break;
          case KPI.age:
            cx = result.singleWhere((resultCluster) => cluster.age == resultCluster.age);
            break;
          case KPI.nationality:
            cx = result.singleWhere((resultCluster) => cluster.nationality == resultCluster.nationality);
            break;
          case KPI.country:
            cx = result.singleWhere((resultCluster) => cluster.country == resultCluster.country);
            break;
          case KPI.region:
            cx = result.singleWhere((resultCluster) => cluster.region == resultCluster.region);
            break;
          case KPI.province:
            cx = result.singleWhere((resultCluster) => cluster.province == resultCluster.province);
            break;
          case KPI.municipality:
            cx = result.singleWhere((resultCluster) => cluster.municipality == resultCluster.municipality);
            break;
          case KPI.homeDistance:
            cx = result.singleWhere((resultCluster) => cluster.homeDistance == resultCluster.homeDistance);
            break;
          case KPI.workDistance:
            cx = result.singleWhere((resultCluster) => cluster.workDistance == resultCluster.workDistance);
            break;
          default:
            throw UnimplementedError("VodafoneDaily#collapseFromKPI(kpi: $kpi)");
        }
        var cy = cx + cluster;
        result.remove(cx);
        result.add(cy);
      } on StateError catch (_) {
        switch (kpi) {
          case KPI.gender:
            result.add(VodafoneCluster.empty(
              gender: cluster.gender,
              visitors: cluster.visitors,
              visits: cluster.visits,
              totalDwellTime: cluster.totalDwellTime,
            ));
            break;
          case KPI.age:
            result.add(VodafoneCluster.empty(
              age: cluster.age,
              visitors: cluster.visitors,
              visits: cluster.visits,
              totalDwellTime: cluster.totalDwellTime,
            ));
            break;
          case KPI.nationality:
            result.add(VodafoneCluster.empty(
              nationality: cluster.nationality,
              visitors: cluster.visitors,
              visits: cluster.visits,
              totalDwellTime: cluster.totalDwellTime,
            ));
            break;
          case KPI.country:
            result.add(VodafoneCluster.empty(
              country: cluster.country,
              visitors: cluster.visitors,
              visits: cluster.visits,
              totalDwellTime: cluster.totalDwellTime,
            ));
            break;
          case KPI.region:
            result.add(VodafoneCluster.empty(
              region: cluster.region,
              visitors: cluster.visitors,
              visits: cluster.visits,
              totalDwellTime: cluster.totalDwellTime,
            ));
            break;
          case KPI.province:
            result.add(VodafoneCluster.empty(
              province: cluster.province,
              visitors: cluster.visitors,
              visits: cluster.visits,
              totalDwellTime: cluster.totalDwellTime,
            ));
            break;
          case KPI.municipality:
            result.add(VodafoneCluster.empty(
              municipality: cluster.municipality,
              visitors: cluster.visitors,
              visits: cluster.visits,
              totalDwellTime: cluster.totalDwellTime,
            ));
            break;
          case KPI.homeDistance:
            result.add(VodafoneCluster.empty(
              homeDistance: cluster.homeDistance,
              visitors: cluster.visitors,
              visits: cluster.visits,
              totalDwellTime: cluster.totalDwellTime,
            ));
            break;
          case KPI.workDistance:
            result.add(VodafoneCluster.empty(
              workDistance: cluster.workDistance,
              visitors: cluster.visitors,
              visits: cluster.visits,
              totalDwellTime: cluster.totalDwellTime,
            ));
            break;
          default:
            throw UnimplementedError("VodafoneDaily#collapseFromKPI(kpi: $kpi)");
        }
      }
    }
    // Sort data first
    result.sort();
    // Collapse clusters if needed
    if (result.length > maxClusters) {
      final toRemove = <VodafoneCluster>[];
      VodafoneCluster other = VodafoneCluster.other();
      for (int i = maxClusters; i < result.length; i++) {
        other += result[i];
        toRemove.add(result[i]);
      }
      result.add(other);
      toRemove.forEach((rm) => result.remove(rm));
    }
    return VodafoneDaily(result, date: date, area: area);
  }

  @override int compareTo(VodafoneDaily other) => date.compareTo(other.date);

}