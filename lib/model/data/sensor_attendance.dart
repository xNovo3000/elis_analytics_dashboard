import 'dart:math';

import 'package:elis_analytics_dashboard/model/data/room.dart';
import 'package:elis_analytics_dashboard/model/enum/room.dart';

class SensorAttendance implements Comparable<SensorAttendance> {

  factory SensorAttendance.fromMap(final Map<String, dynamic> map) => SensorAttendance(
    timestamp: DateTime.fromMillisecondsSinceEpoch(map['ts'], isUtc: true).toLocal(),
    roomsData: List.generate(
      Room.attendanceValues.length,
      (index) => RoomData(
        room: Room.attendanceValues[index],
        occupancy: _getOccupancy(map[Room.attendanceValues[index].technicalName]),
      ),
      growable: false
    ),
  );

  // TEST: used only for testing purposes
  factory SensorAttendance.test([int index = 0]) {
    final random = Random();
    return SensorAttendance(
      timestamp: DateTime.now().add(Duration(minutes: index * 30)),
      roomsData: List.generate(
        Room.attendanceValues.length,
        (index) => RoomData(
          room: Room.attendanceValues[index],
          occupancy: random.nextInt(20),
        ),
        growable: false
      ),
    );
  }

  const SensorAttendance({
    required this.timestamp,
    required this.roomsData,
  });

  final DateTime timestamp;
  final List<RoomData> roomsData;

  int get total {
    int result = 0;
    roomsData.forEach((room) => result += room.occupancy ?? 0);
    return result;
  }

  @override String toString() => 'SensorAttendance(timestamp: $timestamp, roomsData: $roomsData)';
  @override bool operator ==(Object other) => other is SensorAttendance ? timestamp.isAtSameMomentAs(other.timestamp) : false;
  @override int get hashCode => timestamp.hashCode;
  @override int compareTo(SensorAttendance other) => timestamp.compareTo(other.timestamp);

  // Get occupancy checking if integer or String
  static int? _getOccupancy(dynamic data) {
    if (data is double) {
      return data.round();
    } else if (data is int) {
      return data;
    } else {
      return null;
    }
  }

}