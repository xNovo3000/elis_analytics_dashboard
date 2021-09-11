import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/data/weather_instant.dart';
import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:elis_analytics_dashboard/model/enum/area.dart';
import 'package:flutter/material.dart';

class ModelInheritedRealtimeData extends InheritedWidget {

  // TEST: used only for testing purposes
  factory ModelInheritedRealtimeData.test({
    required Widget child,
  }) => ModelInheritedRealtimeData(
    child: child,
    weather: WeatherInstant.test(),
    yesterdaySensorData: SensorData.test(),
    realtimeSensorData: SensorData.test(),
    campusVodafoneData: VodafoneDailyList.test(startingDate: DateTime.now(), area: Area.campus),
    neighborhoodVodafoneData: VodafoneDailyList.test(startingDate: DateTime.now(), area: Area.neighborhood),
  );

  ModelInheritedRealtimeData({
    required Widget child,
    required this.weather,
    required this.yesterdaySensorData,
    required this.realtimeSensorData,
    required this.campusVodafoneData,
    required this.neighborhoodVodafoneData,
  }) : super(key: ValueKey(weather), child: child);

  final WeatherInstant weather;
  final SensorData yesterdaySensorData;
  final SensorData realtimeSensorData;
  final VodafoneDailyList campusVodafoneData;
  final VodafoneDailyList neighborhoodVodafoneData;

  static ModelInheritedRealtimeData of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedRealtimeData>()!;

  static ModelInheritedRealtimeData? maybeOf(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedRealtimeData>();

  @override
  bool updateShouldNotify(ModelInheritedRealtimeData old) {
    return weather != old.weather &&
           yesterdaySensorData != old.yesterdaySensorData &&
           realtimeSensorData != old.realtimeSensorData &&
           campusVodafoneData != old.campusVodafoneData &&
           neighborhoodVodafoneData != old.neighborhoodVodafoneData;
  }

}