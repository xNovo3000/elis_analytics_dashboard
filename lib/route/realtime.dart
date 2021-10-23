import 'dart:async';
import 'dart:convert';

import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/component/responsive_layout.dart';
import 'package:elis_analytics_dashboard/foundation/utils.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_attendance.dart';
import 'package:elis_analytics_dashboard/model/data/sensor_visits.dart';
import 'package:elis_analytics_dashboard/model/data/weather_instant.dart';
import 'package:elis_analytics_dashboard/model/enum/area.dart';
import 'package:elis_analytics_dashboard/model/enum/thingsboard_device.dart';
import 'package:elis_analytics_dashboard/model/exception/invalid_token.dart';
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
        realtimeSensorAttendance: data['realtime_sensor_attendance'],
        realtimeSensorVisits: data['realtime_sensor_visits'],
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
  Future<Map<String, dynamic>> _getRealtimeData() async => {
    'weather': await _getWeatherInstant(),
    'realtime_sensor_attendance': await _getRealtimeSensorAttendance(),
    'realtime_sensor_visits': await _getRealtimeSensorVisits(),
    'campus_vodafone_data': await _getVodafoneList(ThingsboardDevice.vodafoneCampus, Area.campus),
    'neighborhood_vodafone_data': await _getVodafoneList(ThingsboardDevice.vodafoneNeighborhood, Area.neighborhood),
  };

  Future<WeatherInstant> _getWeatherInstant() async {
    final response = await widget.fetcher.get(Utils.realtimeWeatherUri);
    switch (response.statusCode) {
      case 200:
        return WeatherInstant.fromMapAndDuration(Utils.dispatchThingsboardResponse(json.decode(response.body)).single);
      case 401:
        throw InvalidTokenException('');
      default:
        throw response.statusCode;
    }
  }

  Future<SensorAttendance> _getRealtimeSensorAttendance() async {
    final response = await widget.fetcher.get(Utils.realtimeSensorAttendanceUri);
    switch (response.statusCode) {
      case 200:
        return SensorAttendance.fromMap(Utils.dispatchThingsboardResponse(json.decode(response.body)).single);
      case 401:
        throw InvalidTokenException('');
      default:
        throw response.statusCode;
    }
  }

  Future<SensorVisits> _getRealtimeSensorVisits() async {
    final response = await widget.fetcher.get(Utils.realtimeSensorVisitsUri);
    switch (response.statusCode) {
      case 200:
        return SensorVisits.fromMap(Utils.dispatchThingsboardResponse(json.decode(response.body)).single);
      case 401:
        throw InvalidTokenException('');
      default:
        throw response.statusCode;
    }
  }

  Future<VodafoneDailyList> _getVodafoneList(ThingsboardDevice device, Area area) async {
    final now = DateTime.now();
    final lastWeek = await _getVodafoneDaily(device, now.subtract(Duration(days: 7)), area);
    return VodafoneDailyList([
      if (lastWeek.length > 0) lastWeek,
      await _getVodafoneDaily(device, now.subtract(Duration(days: 14)), area),
      await _getVodafoneDaily(device, now.subtract(Duration(days: 21)), area),
      await _getVodafoneDaily(device, now.subtract(Duration(days: 28)), area),
    ]);
  }

  Future<VodafoneDaily> _getVodafoneDaily(ThingsboardDevice device, DateTime day, Area area) async {
    final begin = DateTime(day.year, day.month, day.day).toUtc();
    final end = begin.add(Duration(days: 1));
    final response = await widget.fetcher.get(Utils.getRealtimeVodafoneUriFromDay(device, begin, end));
    switch (response.statusCode) {
      case 200:
        return VodafoneDaily.fromList(
          list: Utils.dispatchThingsboardResponse(json.decode(response.body)),
          area: area,
          date: begin,
        );
      case 401:
        throw InvalidTokenException('');
      default:
        throw response.statusCode;
    }
  }

}
