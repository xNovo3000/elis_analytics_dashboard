import 'package:elis_analytics_dashboard/model/data/sensor_visits.dart';
import 'package:flutter/material.dart';

class FragmentRealtimeSensorDwellTime extends StatelessWidget {

  const FragmentRealtimeSensorDwellTime({
    required this.sensorData,
  });

  final SensorVisits sensorData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.schedule),
      title: Text('${sensorData.dwellTime.inMinutes} minuti'),
      subtitle: Text('Tempo medio di permanenza'),
    );
  }

}