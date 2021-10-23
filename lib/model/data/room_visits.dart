import 'package:elis_analytics_dashboard/model/enum/room_visits.dart';

class RoomVisitsData implements Comparable<RoomVisitsData> {

  const RoomVisitsData.withPercentage({
    required this.room,
    required this.occupancy,
  });

  const RoomVisitsData({
    required this.room,
    required this.occupancy,
  });

  final RoomVisits room;
  final int? occupancy;

  @override String toString() => 'RoomData(room: $room, occupancy: $occupancy)';
  @override bool operator ==(Object other) => other is RoomVisitsData ? room == other.room : false;
  @override int get hashCode => room.hashCode;
  @override int compareTo(RoomVisitsData other) => other.occupancy?.compareTo(occupancy ?? -1) ?? -1;

}