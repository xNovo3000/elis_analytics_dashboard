import 'dart:async';
import 'dart:convert';

import 'package:elis_analytics_dashboard/component/floating_app_bar.dart';
import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/foundation/fetcher.dart';
import 'package:elis_analytics_dashboard/foundation/utils.dart';
import 'package:elis_analytics_dashboard/model/data/weather_instant.dart';
import 'package:elis_analytics_dashboard/model/enum/thingsboard_device.dart';
import 'package:elis_analytics_dashboard/model/exception/no_session.dart';
import 'package:flutter/material.dart';

class RouteRealtimeSmartphone extends StatefulWidget {

  final scrollController = ScrollController();
  final fetcher = Fetcher();

  @override
  _RouteRealtimeSmartphoneState createState() => _RouteRealtimeSmartphoneState();

}

class _RouteRealtimeSmartphoneState extends State<RouteRealtimeSmartphone> {

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(minutes: 1), _onTimerTick);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: widget.scrollController,
        slivers: [
          ComponentFloatingAppBar(
            leading: const Icon(Icons.search),
            title: const Text('Cerca nella dashboard'),
            trailing: [
              const Icon(Icons.search)
            ],
          ),
          ComponentManagedFutureBuilder<WeatherInstant>(
            future: _getWeatherData(),
            onSuccess: (context, data) => Placeholder(),
            onError: (context, error) => Placeholder(),
            onWait: (context) => Placeholder(),
          ),
        ],
      ),
    );
  }

  // Every 1 minute updates the data
  void _onTimerTick(Timer timer) {
    setState(() => null);
  }

  Future<WeatherInstant> _getWeatherData() async {
    try {
      return WeatherInstant.fromMapAndDuration(
        Utils.dispatchThingsboardResponse(
          json.decode(
            (await widget.fetcher.get(
              'plugins/telemetry/DEVICE/${ThingsboardDevice.weatherStation}/values/timeseries'
            )).body
          )
        ).single
      );
    } on NoSessionException catch (_) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      throw NoSessionException();
    }
  }

}