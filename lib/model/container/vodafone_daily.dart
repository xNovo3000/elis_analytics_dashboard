import 'dart:collection';

import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/enum/area.dart';

class VodafoneDaily extends ListBase<VodafoneCluster> implements Comparable<VodafoneDaily> {

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

  @override int compareTo(VodafoneDaily other) => date.compareTo(other.date);

}