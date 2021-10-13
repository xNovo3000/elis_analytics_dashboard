import 'package:elis_analytics_dashboard/model/enum/room.dart';
import 'package:flutter/material.dart';

class RoomData implements Comparable<RoomData> {

  const RoomData.withPercentage({
    required this.room,
    required this.occupancy,
  });

  const RoomData({
    required this.room,
    required this.occupancy,
  });

  final Room room;
  final int occupancy;

  double get percentage => occupancy / room.capacity;

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
  @override bool operator ==(Object other) => other is RoomData ? room == other.room : false;
  @override int get hashCode => room.hashCode;
  @override int compareTo(RoomData other) => other.occupancy.compareTo(occupancy);

}