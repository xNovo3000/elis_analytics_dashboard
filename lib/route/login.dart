import 'package:elis_analytics_dashboard/foundation/fetcher.dart';
import 'package:elis_analytics_dashboard/view/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check if already logged in (async)
    _checkIfAlreadyLoggedIn(context);
    // Build UI
    return ViewLogin();
  }

  Future<void> _checkIfAlreadyLoggedIn(final BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('Email') && preferences.containsKey('Password')) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } else {
      Fetcher().clearCache();
    }
  }

}
