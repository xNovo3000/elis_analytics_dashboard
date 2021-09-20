import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:elis_analytics_dashboard/model/data/weather_daily.dart';
import 'package:flutter/widgets.dart';

class ModelInheritedWeeklyData extends InheritedWidget {

  const ModelInheritedWeeklyData({
    required Widget child,
    required this.weathers,
    required this.sensors,
    required this.campusVodafone,
    required this.neighborhoodVodafone,
  }) : super(child: child);

  final List<WeatherDaily> weathers;
  final List<SensorData> sensors;
  final VodafoneDailyList campusVodafone;
  final VodafoneDailyList neighborhoodVodafone;

  static ModelInheritedWeeklyData of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedWeeklyData>()!;

  static ModelInheritedWeeklyData? maybeOf(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedWeeklyData>();

  @override
  bool updateShouldNotify(ModelInheritedWeeklyData old) {
    return
      weathers != old.weathers ||
      sensors != old.sensors ||
      campusVodafone != old.campusVodafone ||
      neighborhoodVodafone != old.neighborhoodVodafone;
  }

}