import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/component/responsive_layout.dart';
import 'package:elis_analytics_dashboard/foundation/fetcher.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/home_data.dart';
import 'package:elis_analytics_dashboard/view/home_smartphone.dart';
import 'package:flutter/material.dart';

class RouteHome extends StatelessWidget {

  final fetcher = Fetcher();

  @override
  Widget build(BuildContext context) {
    // TODO: Go to login if not logged in
    // if (!fetcher.hasSession) {
    //   Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    // }
    // Initialize child
    final child = ResponsiveLayout(
      smartphoneWidget: ViewHomeSmartphone(),
    );
    // Build UI
    return ComponentManagedFutureBuilder<Map<String, dynamic>>(
      future: _getLastWeekRange(),
      onSuccess: (context, data) => ModelInheritedHomeData(
        child: child,
        lastWeekRange: data['last_week_range'],
      ),
      onError: (context, error) => ModelInheritedError(
        child: child,
        error: '$error',
      ),
      onWait: (context) => child,
    );
  }

  Future<Map<String, dynamic>> _getLastWeekRange() async =>
    Future.delayed(Duration(seconds: 1), () => throw 1);

}
