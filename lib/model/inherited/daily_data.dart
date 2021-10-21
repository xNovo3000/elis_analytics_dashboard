import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/container/weather_instant_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_attendance.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_visits.dart';
import 'package:flutter/material.dart';

class ModelInheritedDailyData extends InheritedWidget {

  factory ModelInheritedDailyData.test({
    required Widget child,
  }) => ModelInheritedDailyData(
    child: child,
    weathers: WeatherInstantList.test(length: 4),
    attendance: List.generate(48, (index) => SensorAttendance.test(index), growable: false),
    visits: List.generate(48, (index) => SensorVisits.test(index), growable: false),
  );

  const ModelInheritedDailyData({
    required Widget child,
    required this.weathers,
    required this.attendance,
    required this.visits,
    this.campusVodafone,
    this.neighborhoodVodafone,
  }) : super(child: child);

  final WeatherInstantList weathers;
  final List<SensorAttendance> attendance;
  final List<SensorVisits> visits;
  final VodafoneDaily? campusVodafone;
  final VodafoneDaily? neighborhoodVodafone;

  static ModelInheritedDailyData of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedDailyData>()!;

  static ModelInheritedDailyData? maybeOf(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedDailyData>();

  @override
  bool updateShouldNotify(ModelInheritedDailyData old) =>
    weathers != old.weathers ||
    attendance != old.attendance ||
    visits != old.visits ||
    campusVodafone != old.campusVodafone ||
    neighborhoodVodafone != old.neighborhoodVodafone;

  bool get hasVodafone => campusVodafone != null && neighborhoodVodafone != null;

}
