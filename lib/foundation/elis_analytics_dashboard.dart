import 'package:elis_analytics_dashboard/component/responsive_layout.dart';
import 'package:elis_analytics_dashboard/route/login.dart';
import 'package:elis_analytics_dashboard/route/realtime_smartphone.dart';
import 'package:flutter/material.dart';

class ELISAnalyticsDashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: load licenses (?)
    // Build the application
    return MaterialApp(
      title: 'ELIS Analytics Dashboard',
      initialRoute: '/',
      routes: {
        '/login': (context) => ResponsiveLayout(
          smartphoneWidget: RouteLogin(),
        ),
        '/': (context) => ResponsiveLayout(
          smartphoneWidget: RouteRealtimeSmartphone(),
        ),
      },
      theme: _lightTheme,
      darkTheme: _lightTheme,  // TODO: create dark theme (?)
    );
  }

  static final ThemeData _lightTheme = ThemeData(

  );

}
