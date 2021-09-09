import 'package:elis_analytics_dashboard/model/inherited/realtime_data.dart';
import 'package:flutter/material.dart';

class ViewRealtimeSmartphoneData extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Obtain data (always exists)
    final realtimeData = ModelInheritedRealtimeData.of(context);
    // Build the view
    return ListView(
      children: [
        ListTile(

        ),
      ],
    );
  }

}
