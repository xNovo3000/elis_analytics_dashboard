import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:elis_analytics_dashboard/model/enum/room.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FragmentDailyRoomsOccupation extends StatelessWidget {

  static final _chartTimeOfDayResolver = DateFormat('HH:mm');

  const FragmentDailyRoomsOccupation({
    required this.sensors,
    required this.condition,
  });

  final List<SensorData> sensors;
  final bool Function(Room) condition;

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
        for (Room room in Room.values.where(condition))
          StackedColumnSeries<SensorData, String>(
            dataSource: sensors,
            xValueMapper: (datum, index) => _chartTimeOfDayResolver.format(datum.timestamp),
            yValueMapper: (datum, index) => datum.roomsData.singleWhere((roomData) => roomData.room == room).occupancy,
            legendItemText: '$room',
            animationDuration: 0,
          ),
      ],
    );
  }

}
