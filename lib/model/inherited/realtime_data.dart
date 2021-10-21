import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_attendance.dart';
import 'package:elis_analytics_dashboard/model/data/weather_instant.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_visits.dart';
import 'package:elis_analytics_dashboard/model/enum/area.dart';
import 'package:flutter/material.dart';

class ModelInheritedRealtimeData extends InheritedWidget {

  // TEST: used only for testing purposes
  factory ModelInheritedRealtimeData.test({
    required Widget child,
  }) => ModelInheritedRealtimeData(
    child: child,
    weather: WeatherInstant.test(),
    realtimeSensorAttendance: SensorAttendance.test(),
    realtimeSensorVisits: SensorVisits.test(),
    campusVodafoneData: VodafoneDailyList.test(startingDate: DateTime.now(), area: Area.campus),
    neighborhoodVodafoneData: VodafoneDailyList.test(startingDate: DateTime.now(), area: Area.neighborhood),
  );

  ModelInheritedRealtimeData({
    required Widget child,
    required this.weather,
    required this.realtimeSensorAttendance,
    required this.realtimeSensorVisits,
    required this.campusVodafoneData,
    required this.neighborhoodVodafoneData,
  }) : super(key: ValueKey(weather), child: child);

  final WeatherInstant weather;
  final SensorAttendance realtimeSensorAttendance;
  final SensorVisits realtimeSensorVisits;
  final VodafoneDailyList campusVodafoneData;
  final VodafoneDailyList neighborhoodVodafoneData;

  static ModelInheritedRealtimeData of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedRealtimeData>()!;

  static ModelInheritedRealtimeData? maybeOf(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedRealtimeData>();

  @override
  bool updateShouldNotify(ModelInheritedRealtimeData old) =>
    weather != old.weather ||
    realtimeSensorAttendance != old.realtimeSensorAttendance ||
    realtimeSensorVisits != old.realtimeSensorVisits ||
    campusVodafoneData != old.campusVodafoneData ||
    neighborhoodVodafoneData != old.neighborhoodVodafoneData;

}