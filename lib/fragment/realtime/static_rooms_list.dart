import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:elis_analytics_dashboard/model/enum/room.dart';
import 'package:flutter/material.dart';

class FragmentRealtimeStaticRoomsList extends StatelessWidget {

  const FragmentRealtimeStaticRoomsList({
    required this.sensorData,
    this.direction = Axis.vertical,
  });

  final SensorData sensorData;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    // Get rooms data
    final roomLagrangeData = sensorData.roomsData.singleWhere((roomData) => roomData.room == Room.lagrange);
    final roomPascalData = sensorData.roomsData.singleWhere((roomData) => roomData.room == Room.pascal);
    // Build UI
    return Wrap(
      direction: direction,
      children: [
        Expanded(
          child: Card( // Height is 62 + image
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Text('${roomLagrangeData.room}'),
                ),
                // TODO: add image here
                SizedBox(
                  width: direction == Axis.horizontal ? double.infinity : 96,
                  height: direction == Axis.vertical ? double.infinity : 96,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    '${roomLagrangeData.occupancy >= roomLagrangeData.room.capacity ? 'ALT' : 'OK'}: '
                    '${roomLagrangeData.occupancy}/${roomLagrangeData.room.capacity}'
                  ),
                  decoration: BoxDecoration(
                    color: roomLagrangeData.color,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Text('${roomPascalData.room}'),
                ),
                // TODO: add image here
                SizedBox(
                  width: double.infinity, height: 96,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    '${roomPascalData.occupancy >= roomPascalData.room.capacity ? 'ALT' : 'OK'}: '
                    '${roomPascalData.occupancy}/${roomPascalData.room.capacity}'
                  ),
                  decoration: BoxDecoration(
                    color: roomPascalData.color,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
