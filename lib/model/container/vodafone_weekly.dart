import 'dart:collection';

import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/enum/area.dart';

// TODO: maybe this class is useless
class VodafoneWeekly extends ListBase<VodafoneDaily> {

  VodafoneWeekly(this._list);

  final List<VodafoneDaily> _list;

  @override int get length => _list.length;
  @override set length(int newLength) => _list.length = newLength;
  @override VodafoneDaily operator [](int index) => _list[index];
  @override void operator []=(int index, VodafoneDaily value) => _list[index] = value;

  Area get area => _list.isNotEmpty ? _list.first.area : Area.na;

}