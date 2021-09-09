import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/realtime_data.dart';
import 'package:elis_analytics_dashboard/view/error.dart';
import 'package:elis_analytics_dashboard/view/realtime_smartphone/data.dart';
import 'package:elis_analytics_dashboard/view/wait.dart';
import 'package:flutter/material.dart';

class ViewRealtimeSmartphone extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check data
    final realtimeData = ModelInheritedRealtimeData.maybeOf(context);
    final error = ModelInheritedError.maybeOf(context);
    // Build the view
    return Scaffold(
      appBar: AppBar(
        title: const Text('ELIS Analytics Dashboard'),
      ),
      body: realtimeData != null
        ? ViewRealtimeSmartphoneData()
        : error != null
          ? ViewError(error: error.error)
          : ViewWait(),
    );
  }

}
