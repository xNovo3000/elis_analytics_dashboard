import 'package:elis_analytics_dashboard/model/enum/room.dart';

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

  @override String toString() => 'RoomData(room: $room, occupancy: $occupancy)';
  @override bool operator ==(Object other) => other is RoomData ? room == other.room : false;
  @override int get hashCode => room.hashCode;
  @override int compareTo(RoomData other) => other.occupancy.compareTo(occupancy);

}