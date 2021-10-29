import 'dart:math';

import 'package:elis_analytics_dashboard/model/data/sensor_attendance.dart';
import 'package:elis_analytics_dashboard/model/enum/room_attendance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FragmentDailyRoomsOccupationAttendance extends StatelessWidget {

  static final _chartTimeOfDayResolver = DateFormat('HH:mm');

  const FragmentDailyRoomsOccupationAttendance({
    required this.sensors,
  });

  final List<SensorAttendance> sensors;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      margin: EdgeInsets.all(8),
      primaryXAxis: CategoryAxis(),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.scroll,
      ),
      series: [
        for (RoomAttendance room in RoomAttendance.values)
          StackedColumnSeries<SensorAttendance, String>(
            dataSource: sensors,
            xValueMapper: (datum, index) => _chartTimeOfDayResolver.format(datum.timestamp),
            yValueMapper: (datum, index) => _yValueMapper(datum, index, room),
            legendItemText: '$room',
            animationDuration: 0,
          ),
      ],
    );
  }

  num? _yValueMapper(SensorAttendance datum, int index, RoomAttendance room) {
    try {
      return max(datum.roomsData.singleWhere((roomData) => roomData.room == room).occupancy ?? 0, 0);
    } catch (e) {
      return 0;
    }
  }

}
