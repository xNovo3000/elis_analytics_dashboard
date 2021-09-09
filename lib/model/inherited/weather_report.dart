import 'package:elis_analytics_dashboard/model/data/weather_instant.dart';
import 'package:flutter/material.dart';

class ModelInheritedWeatherReport extends InheritedWidget {

  factory ModelInheritedWeatherReport.test({
    required Widget child,
  }) => ModelInheritedWeatherReport(
    weather: WeatherInstant.test(),
    child: child,
  );

  ModelInheritedWeatherReport({
    required Widget child,
    required this.weather
  }) : super(key: ValueKey(weather), child: child);

  final WeatherInstant weather;

  static ModelInheritedWeatherReport of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedWeatherReport>()!;

  static ModelInheritedWeatherReport? maybeOf(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<ModelInheritedWeatherReport>();

  @override
  bool updateShouldNotify(ModelInheritedWeatherReport old) {
    return weather != old.weather;
  }

}