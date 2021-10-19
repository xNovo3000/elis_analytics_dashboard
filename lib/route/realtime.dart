import 'dart:async';
import 'dart:convert';

import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/component/responsive_layout.dart';
import 'package:elis_analytics_dashboard/foundation/utils.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor.dart';
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

  // Static Uri cache
  static final _weatherUri = Uri.parse('plugins/telemetry/DEVICE/${ThingsboardDevice.weatherStation}/values/timeseries');
  static final _realtimeSensorsUri = Uri.parse('plugins/telemetry/DEVICE/${ThingsboardDevice.sensorsRealtime}/values/timeseries');
  static final _dailySensorsUri = Uri.parse('plugins/telemetry/DEVICE/${ThingsboardDevice.sensorsDaily}/values/timeseries');
  static Uri _getVodafoneUriFromDay(ThingsboardDevice device, DateTime begin, DateTime end) =>
    Uri.parse('plugins/telemetry/DEVICE/$device/values/timeseries')
      .replace(queryParameters: {
        'startTs': '${begin.toUtc().millisecondsSinceEpoch}',
        'endTs': '${end.toUtc().millisecondsSinceEpoch}',
        'keys': 'age,country,gender,homeDistance,workDistance,nationality,region,province,municipality,totalDwellTime,visitors,visits'
      });

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
  Future<Map<String, dynamic>> _getRealtimeData() async => {
    'weather': await _getWeatherInstant(),
    'realtime_sensor_data': await _getRealtimeSensor(),
    'yesterday_sensor_data': SensorData.test(),  // TODO: now it's useless. Remove
    'campus_vodafone_data': await _getVodafoneList(ThingsboardDevice.vodafoneIndoor, Area.campus),
    'neighborhood_vodafone_data': await _getVodafoneList(ThingsboardDevice.vodafoneOutdoor, Area.neighborhood),
  };

  Future<WeatherInstant> _getWeatherInstant() async {
    final response = await widget.fetcher.get(_weatherUri);
    switch (response.statusCode) {
      case 200:
        return WeatherInstant.fromMapAndDuration(Utils.dispatchThingsboardResponse(json.decode(response.body)).single);
      case 401:
        throw InvalidTokenException('');
      default:
        throw response.statusCode;
    }
  }

  Future<SensorData> _getRealtimeSensor() async {
    final response = await widget.fetcher.get(_realtimeSensorsUri);
    switch (response.statusCode) {
      case 200:
        return SensorData.fromMap(Utils.dispatchThingsboardResponse(json.decode(response.body)).single);
      case 401:
        throw InvalidTokenException('');
      default:
        throw response.statusCode;
    }
  }

  Future<SensorData> _getDailySensor() async {
    final response = await widget.fetcher.get(_dailySensorsUri);
    switch (response.statusCode) {
      case 200:
        return SensorData.fromMap(Utils.dispatchThingsboardResponse(json.decode(response.body)).single);
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
    final response = await widget.fetcher.get(_getVodafoneUriFromDay(device, begin, end));
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
