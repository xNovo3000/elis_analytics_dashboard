import 'package:elis_analytics_dashboard/model/data/sensor_attendance.dart';
import 'package:elis_analytics_dashboard/model/enum/room_attendance.dart';
import 'package:flutter/material.dart';

class FragmentRealtimeRoomsAttendance extends StatelessWidget {

  const FragmentRealtimeRoomsAttendance({
    required this.sensorData,
    this.direction = Axis.vertical,
  });

  final SensorAttendance sensorData;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    // TODO: not important: make this Widget expandable
    // Get rooms data
    final roomLagrangeData = sensorData.roomsData.singleWhere((roomData) => roomData.room == RoomAttendance.lagrange);
    final roomPascalData = sensorData.roomsData.singleWhere((roomData) => roomData.room == RoomAttendance.pioneers);
    // Build children
    final children = [
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
              Image(
                image: AssetImage('asset/image/${roomLagrangeData.room.technicalName}.jpeg'),
                errorBuilder: (context, _, __) => Container(
                  color: Colors.white,
                ),
                filterQuality: FilterQuality.medium,
                fit: BoxFit.fitWidth,
              ),
              Container(
                padding: EdgeInsets.all(4),
                child: roomLagrangeData.occupancy != null ? Text(
                  '${roomLagrangeData.occupancy! >= roomLagrangeData.room.capacity ? 'ALT' : 'OK'}: '
                  '${roomLagrangeData.occupancy?.clamp(0, double.infinity)}/${roomLagrangeData.room.capacity}'
                ) : Text('N/A'),
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
              Image(
                image: AssetImage('asset/image/${roomPascalData.room.technicalName}.jpeg'),
                errorBuilder: (context, _, __) => Container(
                  color: Colors.white,
                ),
                filterQuality: FilterQuality.medium,
                fit: BoxFit.fitWidth,
              ),
              Container(
                padding: EdgeInsets.all(4),
                child: roomPascalData.occupancy != null ? Text(
                  '${roomPascalData.occupancy! >= roomPascalData.room.capacity ? 'ALT' : 'OK'}: '
                  '${roomPascalData.occupancy?.clamp(0, double.infinity)}/${roomPascalData.room.capacity}'
                ) : Text('N/A'),
                decoration: BoxDecoration(
                  color: roomPascalData.color,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
    // Build UI
    return direction == Axis.horizontal
      ? Row(children: children)
      : Column(children: children);
  }

}
