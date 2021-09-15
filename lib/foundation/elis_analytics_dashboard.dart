import 'package:elis_analytics_dashboard/route/daily.dart';
import 'package:elis_analytics_dashboard/route/login.dart';
import 'package:elis_analytics_dashboard/route/realtime.dart';
import 'package:elis_analytics_dashboard/route/weather_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ELISAnalyticsDashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: load licenses
    // Build the application
    return MaterialApp(
      title: 'ELIS Analytics Dashboard',
      initialRoute: '/realtime',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('it')
      ],
      routes: {
        '/login': (context) => RouteLogin(),
        '/realtime': (context) => RouteRealtime(),
        '/realtime/weather_report': (context) => RouteWeatherReport(),
        '/daily': (context) => RouteDaily(),
      },
      onUnknownRoute: (settings) {
        Navigator.pushNamedAndRemoveUntil(context, '/realtime', (route) => false);
      },
      theme: _lightTheme,
      darkTheme: _lightTheme,  // No dark theme for the moment
    );
  }

  static final _lightTheme = ThemeData(
    fontFamily: 'OpenSans',
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
    ),
  );

}
