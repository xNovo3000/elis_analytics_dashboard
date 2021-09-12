import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/component/responsive_layout.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:flutter/material.dart';

class RouteDaily extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Build the child widget
    // TODO: create the 2 views
    final child = ResponsiveLayout(
      smartphoneWidget: Placeholder(),
    );
    // Get specific day
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || !(args is Map<String, dynamic>) || !args.containsKey('weather_report')) {
      return ModelInheritedError(
        child: child,
        error: 'Si è verificato un errore sconosciuto',
      );
    }
    // TODO: create the inherited widget for realtime data
    // Build UI
    return ComponentManagedFutureBuilder<Map<String, dynamic>>(
      future: _getDailyData(),
      onSuccess: (context, data) => Placeholder(),
      onError: (context, error) => ModelInheritedError(
        child: child,
        error: '$error',
      ),
      onWait: (context) => child,
    );
  }

  Future<Map<String, dynamic>> _getDailyData() async =>
    Future.delayed(const Duration(seconds: 1), () => throw Exception());

}
