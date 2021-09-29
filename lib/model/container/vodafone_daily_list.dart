import 'dart:collection';

import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/enum/area.dart';
import 'package:elis_analytics_dashboard/model/enum/kpi.dart';

class VodafoneDailyList extends ListBase<VodafoneDaily> {

  factory VodafoneDailyList.test({
    required DateTime startingDate,
    required Area area,
  }) => VodafoneDailyList(
    List.generate(
      7,
      (index) => VodafoneDaily.test(
        date: startingDate.add(Duration(days: index)),
        area: area,
      ),
      growable: false
    )
  );

  VodafoneDailyList(this._list);

  final List<VodafoneDaily> _list;

  @override int get length => _list.length;
  @override set length(int newLength) => _list.length = newLength;
  @override VodafoneDaily operator [](int index) => _list[index];
  @override void operator []=(int index, VodafoneDaily value) => _list[index] = value;

  Area get area => _list.isNotEmpty ? _list.first.area : Area.na;

  int get visitors {
    int total = 0;
    forEach((element) => total += element.visitors);
    return total;
  }
  
  VodafoneDaily collapseFromKPI(final KPI kpi, [int maxClusters = 0xFFFFFFFF]) {
    final result = <VodafoneCluster>[];
    for (VodafoneDaily daily in this) {
      result.addAll(daily);
    }
    final daily = VodafoneDaily(result, date: DateTime(1970), area: area);
    return daily.collapseFromKPI(kpi, maxClusters);
  }

  VodafoneDailyList whereCondition(bool Function(VodafoneCluster element) test) {
    return VodafoneDailyList(
      List.generate(
        length,
        (index) => this[index].whereCondition(test),
        growable: false,
      )
    );
  }

}