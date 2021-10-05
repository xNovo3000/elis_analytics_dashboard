import 'package:elis_analytics_dashboard/component/no_transition_builder.dart';
import 'package:elis_analytics_dashboard/route/daily.dart';
import 'package:elis_analytics_dashboard/route/home.dart';
import 'package:elis_analytics_dashboard/route/login.dart';
import 'package:elis_analytics_dashboard/route/map_viewer.dart';
import 'package:elis_analytics_dashboard/route/realtime.dart';
import 'package:elis_analytics_dashboard/route/weather_report.dart';
import 'package:elis_analytics_dashboard/route/weekly.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ELISAnalyticsDashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Add licenses
    LicenseRegistry.addLicense(() async* {
      var license = await rootBundle.loadString('assets/licenses/OpenSans/LICENSE.txt');
      yield LicenseEntryWithLineBreaks(['Open Sans'], license);
      license = await rootBundle.loadString('assets/licenses/GDPR/LICENSE.txt');
      yield LicenseEntryWithLineBreaks(['GDPR'], license);
    });
    // Build the application
    return MaterialApp(
      title: 'ELIS Analytics Dashboard',
      initialRoute: '/',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('it')
      ],
      routes: {
        '/': (context) => RouteHome(),
        '/login': (context) => RouteLogin(),
        '/realtime': (context) => RouteRealtime(),
        '/realtime/weather_report': (context) => RouteWeatherReport(),
        '/daily': (context) => RouteDaily(),
        '/daily/weather_report': (context) => RouteWeatherReport(),
        '/daily/region_map': (context) => RouteMapViewer(),
        '/weekly': (context) => RouteWeekly(),
        '/weekly/region_map': (context) => RouteMapViewer(),
      },
      onUnknownRoute: (settings) {
        Navigator.pushNamedAndRemoveUntil(context, '/realtime', (route) => false);
      },
      theme: _lightTheme,
      darkTheme: _lightTheme,
    );
  }

  static final _lightTheme = ThemeData(
    fontFamily: 'OpenSans',
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
    ),
    visualDensity: VisualDensity.comfortable,
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: NoTransitionBuilder(),
        TargetPlatform.iOS: NoTransitionBuilder(),
        TargetPlatform.windows: NoTransitionBuilder(),
        TargetPlatform.linux: NoTransitionBuilder(),
        TargetPlatform.fuchsia: NoTransitionBuilder(),
        TargetPlatform.macOS: NoTransitionBuilder(),
      },
    ),
  );

}
