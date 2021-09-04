import 'package:elis_analytics_dashboard/foundation/fetcher.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnvironmentalVariables extends InheritedWidget {

  const EnvironmentalVariables({
    required Widget child,
    required this.sharedPreferences,
    required this.fetcher,
  }) : super(child: child);

  final SharedPreferences sharedPreferences;
  final Fetcher fetcher;

  static EnvironmentalVariables of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<EnvironmentalVariables>()!;

  @override
  bool updateShouldNotify(EnvironmentalVariables old) {
    return sharedPreferences != old.sharedPreferences;
  }

}
