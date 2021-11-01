import 'dart:collection';

import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/enum/age.dart';
import 'package:elis_analytics_dashboard/model/enum/area.dart';
import 'package:elis_analytics_dashboard/model/enum/distance.dart';
import 'package:elis_analytics_dashboard/model/enum/gender.dart';
import 'package:elis_analytics_dashboard/model/enum/nationality.dart';
import 'package:elis_analytics_dashboard/model/enum/region.dart';

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

  Duration get dwellTime {
    var total = Duration();
    forEach((cluster) => total += cluster.totalDwellTime);
    return Duration(seconds: (total.inSeconds / visitors).round());
  }

  double get ageAverage {
    var total = 0.0;
    forEach((cluster) => total += cluster.age.median);
    return total / visitors;
  }

  double get foreignersRatio {
    var total = 0.0;
    forEach((cluster) => cluster.nationality == Nationality.foreigner ? total += cluster.visitors : null);
    return total / visitors;
  }

  double get homeDistanceAverage {
    var total = 0.0;
    forEach((cluster) => total += cluster.homeDistance.average);
    return total / visitors;
  }

  double get workDistanceAverage {
    var total = 0.0;
    forEach((cluster) => total += cluster.workDistance.average);
    return total / visitors;
  }

  VodafoneDaily whereCondition(bool Function(VodafoneCluster element) test) => VodafoneDaily(
    List.of(super.where(test)),
    date: date,
    area: area
  );

  VodafoneDaily collapse(final VodafoneClusterAttribute attribute, {
    int maxClusters = 0xFFFFFFFF,
    bool collapseNa = false,
  }) {
    final result = <VodafoneCluster>[];
    for (VodafoneCluster cluster in this) {
      try {
        var cx;
        switch (attribute) {
          case VodafoneClusterAttribute.gender:
            cx = result.singleWhere((resultCluster) => cluster.gender == resultCluster.gender);
            break;
          case VodafoneClusterAttribute.age:
            cx = result.singleWhere((resultCluster) => cluster.age == resultCluster.age);
            break;
          case VodafoneClusterAttribute.nationality:
            cx = result.singleWhere((resultCluster) => cluster.nationality == resultCluster.nationality);
            break;
          case VodafoneClusterAttribute.country:
            cx = result.singleWhere((resultCluster) => cluster.country == resultCluster.country);
            break;
          case VodafoneClusterAttribute.region:
            cx = result.singleWhere((resultCluster) => cluster.region == resultCluster.region);
            break;
          case VodafoneClusterAttribute.province:
            cx = result.singleWhere((resultCluster) => cluster.province == resultCluster.province);
            break;
          case VodafoneClusterAttribute.municipality:
            cx = result.singleWhere((resultCluster) => cluster.municipality == resultCluster.municipality);
            break;
          case VodafoneClusterAttribute.homeDistance:
            cx = result.singleWhere((resultCluster) => cluster.homeDistance == resultCluster.homeDistance);
            break;
          case VodafoneClusterAttribute.workDistance:
            cx = result.singleWhere((resultCluster) => cluster.workDistance == resultCluster.workDistance);
            break;
        }
        var cy = cx + cluster;
        result.remove(cx);
        result.add(cy);
      } on StateError catch (_) {
        result.add(VodafoneCluster.empty(
          gender: attribute == VodafoneClusterAttribute.gender ? cluster.gender : Gender.na,
          age: attribute == VodafoneClusterAttribute.age ? cluster.age : Age.na,
          nationality: attribute == VodafoneClusterAttribute.nationality ? cluster.nationality : Nationality.na,
          country: attribute == VodafoneClusterAttribute.country ? cluster.country : 'null',
          region: attribute == VodafoneClusterAttribute.region ? cluster.region : Region.na,
          province: attribute == VodafoneClusterAttribute.province ? cluster.province : 'null',
          municipality: attribute == VodafoneClusterAttribute.municipality ? cluster.municipality : 'null',
          homeDistance: attribute == VodafoneClusterAttribute.homeDistance ? cluster.homeDistance : Distance.na,
          workDistance: attribute == VodafoneClusterAttribute.workDistance ? cluster.workDistance : Distance.na,
          visitors: cluster.visitors,
          visits: cluster.visits,
          totalDwellTime: cluster.totalDwellTime,
        ));
      }
    }
    // Sort data first
    result.sort();
    // Collapse NA if needed
    if (collapseNa) {
      final found = result.where(
        (cluster) =>
          (attribute == VodafoneClusterAttribute.gender ? cluster.gender == Gender.na : true) &&
          (attribute == VodafoneClusterAttribute.age ? cluster.age == Age.na : true) &&
          (attribute == VodafoneClusterAttribute.nationality ? cluster.nationality == Nationality.na : true) &&
          (attribute == VodafoneClusterAttribute.country ? cluster.country == 'null' : true) &&
          (attribute == VodafoneClusterAttribute.region ? cluster.region == Region.na : true) &&
          (attribute == VodafoneClusterAttribute.province ? cluster.province == 'null' : true) &&
          (attribute == VodafoneClusterAttribute.municipality ? cluster.municipality == 'null' : true) &&
          (attribute == VodafoneClusterAttribute.homeDistance ? cluster.homeDistance == Distance.na : true) &&
          (attribute == VodafoneClusterAttribute.workDistance ? cluster.workDistance == Distance.na : true)
      );
      if (found.length == 1) {
        final na = found.single;
        result.remove(na);
        final splitNa = VodafoneCluster.empty(
          visitors: (na.visitors / result.length).ceil(),
          visits: (na.visits / result.length).ceil(),
          totalDwellTime: Duration(microseconds: (na.totalDwellTime.inMicroseconds / result.length).ceil())
        );
        // Copy the result
        final resultCopy = List.of(result);
        for (var cluster in resultCopy) {
          result.remove(cluster);
          result.add(cluster + splitNa);
        }
      }
    }
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