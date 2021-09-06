import 'package:elis_analytics_dashboard/component/floating_app_bar.dart';
import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:flutter/material.dart';

class RouteRealtimeSmartphone extends StatefulWidget {
  @override _RouteRealtimeSmartphoneState createState() => _RouteRealtimeSmartphoneState();
}

class _RouteRealtimeSmartphoneState extends State<RouteRealtimeSmartphone> {

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          ComponentFloatingAppBar(
            leading: const Icon(Icons.search),
            title: const Text('Cerca nella dashboard'),
            trailing: [
              const Icon(Icons.search)
            ],
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>?> _getWeatherData() async {

  }

}