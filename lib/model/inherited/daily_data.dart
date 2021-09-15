import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/container/weather_instant_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:flutter/material.dart';

class ModelInheritedDailyData extends InheritedWidget {

  const ModelInheritedDailyData({
    required Widget child,
    required this.weathers,
    required this.dailySensor,
    required this.timedSensor,
    this.campusVodafone,
    this.neighborhoodVodafone,
  }) : super(child: child);

  final WeatherInstantList weathers;
  final SensorData dailySensor;
  final List<SensorData> timedSensor;
  final VodafoneDaily? campusVodafone;
  final VodafoneDaily? neighborhoodVodafone;

  static ModelInheritedDailyData of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedDailyData>()!;

  static ModelInheritedDailyData? maybeOf(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedDailyData>();

  @override
  bool updateShouldNotify(ModelInheritedDailyData old) {
    return weathers != old.weathers ||
           dailySensor != old.dailySensor ||
           timedSensor != old.timedSensor ||
           campusVodafone != old.campusVodafone ||
           neighborhoodVodafone != old.neighborhoodVodafone;
  }

}
