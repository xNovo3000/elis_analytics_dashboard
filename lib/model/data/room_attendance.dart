import 'package:elis_analytics_dashboard/model/enum/room_attendance.dart';
import 'package:flutter/material.dart';

class RoomAttendanceData implements Comparable<RoomAttendanceData> {

  const RoomAttendanceData.withPercentage({
    required this.room,
    required this.occupancy,
  });

  const RoomAttendanceData({
    required this.room,
    required this.occupancy,
  });

  final RoomAttendance room;
  final int? occupancy;

  double get percentage => (occupancy ?? 0) / room.capacity;

  Color get color {
    if (percentage >= 1) {
      return Colors.red[300]!;
    } else if (percentage >= 0.75) {
      return Colors.yellow[300]!;
    } else {
      return Colors.green[300]!;
    }
  }

  @override String toString() => 'RoomData(room: $room, occupancy: $occupancy)';
  @override bool operator ==(Object other) => other is RoomAttendanceData ? room == other.room : false;
  @override int get hashCode => room.hashCode;
  @override int compareTo(RoomAttendanceData other) => other.occupancy?.compareTo(occupancy ?? -1) ?? -1;

}