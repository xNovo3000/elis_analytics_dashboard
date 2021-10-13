import 'dart:async';

import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/component/responsive_layout.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:elis_analytics_dashboard/model/data/weather_instant.dart';
import 'package:elis_analytics_dashboard/model/enum/area.dart';
import 'package:elis_analytics_dashboard/model/inherited/realtime_data.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/foundation/fetcher.dart';
import 'package:elis_analytics_dashboard/view/realtime_smartphone.dart';
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
    // Auto-update system
    timer = Timer.periodic(const Duration(minutes: 1), _onTimerTick);
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
      smartphoneWidget: ViewRealtimeSmartphone(),
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

  // Every 1 minute updates the data
  void _onTimerTick(final Timer timer) {
    if (mounted) {
      setState(() => null);
    }
  }

  // TEST: just for testing
  Future<Map<String, dynamic>> _getRealtimeData() =>
    Future.delayed(const Duration(seconds: 2), () => {
      'weather': WeatherInstant.test(),
      'realtime_sensor_data': SensorData.test(),
      'yesterday_sensor_data': SensorData.test(),
      'campus_vodafone_data': VodafoneDailyList.test(startingDate: DateTime.now(), area: Area.campus),
      'neighborhood_vodafone_data': VodafoneDailyList.test(startingDate: DateTime.now(), area: Area.neighborhood),
    });

  // TODO: add all (async) sub-functions
  // Future<WeatherInstant> _getWeatherData() async
  // Etc...

}
