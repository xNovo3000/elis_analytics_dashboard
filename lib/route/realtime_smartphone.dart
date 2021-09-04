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
        slivers: [],
      ),
    );
  }

}
