import 'package:elis_analytics_dashboard/foundation/elis_analytics_dashboard.dart';
import 'package:elis_analytics_dashboard/foundation/environmental_variables.dart';
import 'package:elis_analytics_dashboard/foundation/fetcher.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async => runApp(EnvironmentalVariables(
  child: ELISAnalyticsDashboard(),
  sharedPreferences: await SharedPreferences.getInstance(),
  fetcher: Fetcher(),
));