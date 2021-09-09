import 'dart:async';

import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/component/responsive_layout.dart';
import 'package:elis_analytics_dashboard/model/inherited/realtime_data.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/foundation/fetcher.dart';
import 'package:flutter/material.dart';

class RouteRealtime extends StatefulWidget {

  final fetcher = Fetcher();

  @override
  _RouteRealtimeState createState() => _RouteRealtimeState();

}

class _RouteRealtimeState extends State<RouteRealtime> {

  late Timer timer;

  @override
  void initState() {
    super.initState();
    // Every 1 minute updates the data
    timer = Timer.periodic(const Duration(minutes: 1), (_) => setState(() => null));
  }

  @override
  void dispose() {
    // Delete the auto-update system
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Generate child using ResponsiveLayout
    final child = ResponsiveLayout(
      smartphoneWidget: Placeholder(),
    );
    // Return using the FutureBuilder
    return ComponentManagedFutureBuilder<Map<String, dynamic>>(
      future: _getRealtimeData(),
      onSuccess: (context, data) => ModelInheritedRealtimeData(
        weather: data['weather'],
        realtimeSensorData: data['realtime_sensor_data'],
        yesterdaySensorData: data['yesterday_sensor_data'],
        campusVodafoneData: data['campus_vodafone_data'],
        neighborhoodVodafoneData: data['neighborhood_vodafone_data'],
        child: child,
      ),
      onWait: (context) => child,
      onError: (context, error) => ModelInheritedError(
        error: '$error',
        child: child,
      ),
    );
  }

  Future<Map<String, dynamic>> _getRealtimeData() async =>
    throw Exception('Custom error test');

  // TODO: add all (async) sub-functions
  // Future<WeatherInstant> _getWeatherData() async
  // Etc...

}
