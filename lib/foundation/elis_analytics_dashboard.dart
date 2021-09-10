import 'package:elis_analytics_dashboard/model/inherited/realtime_data.dart';
import 'package:elis_analytics_dashboard/route/login.dart';
import 'package:elis_analytics_dashboard/route/realtime.dart';
import 'package:elis_analytics_dashboard/route/weather_report.dart';
import 'package:elis_analytics_dashboard/view/realtime_smartphone/data.dart';
import 'package:elis_analytics_dashboard/view/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ELISAnalyticsDashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: load licenses (?)
    // Build the application
    return MaterialApp(
      title: 'ELIS Analytics Dashboard',
      initialRoute: '/test',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('it')
      ],
      routes: {
        '/': (context) => RouteRealtime(),
        '/login': (context) => RouteLogin(),
        '/weather_report': (context) => RouteWeatherReport(),
        // TEST: used only for testing purposes
        '/test': (context) => ModelInheritedRealtimeData.test(
          child: ViewTest(
            body: ViewRealtimeSmartphoneData(),
          ),
        ),
      },
      theme: _lightTheme,
      darkTheme: _lightTheme,  // TODO: create dark theme (?)
    );
  }

  static final ThemeData _lightTheme = ThemeData(
    fontFamily: 'Raleway',
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
    ),
  );

}
