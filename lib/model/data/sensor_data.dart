import 'package:elis_analytics_dashboard/model/data/room_data.dart';
import 'package:elis_analytics_dashboard/model/enum/room.dart';

class SensorData implements Comparable<SensorData> {

  factory SensorData.fromMap(final Map<String, dynamic> map) => SensorData(
    timestamp: DateTime.fromMillisecondsSinceEpoch(map['ts'], isUtc: true).toLocal(),
    roomsData: List.generate(
      Room.values.length,
      (index) => RoomData(
        room: Room.values[index],
        occupancy: map[Room.values[index].technicalName],
      ),
      growable: false
    ),
    returnRate: map['tasso_di_ritorno'] / 100,
    dwellTime: Duration(minutes: map['tempo_medio_permanenza']),
  );

  const SensorData({
    required this.timestamp,
    required this.roomsData,
    required this.returnRate,
    required this.dwellTime,
  });

  final DateTime timestamp;
  final List<RoomData> roomsData;
  final double returnRate;
  final Duration dwellTime;

  @override String toString() => 'SensorData(timestamp: $timestamp, roomsData: $roomsData), '
    'returnRate: $returnRate, dwellTime: $dwellTime)';
  @override bool operator ==(Object other) => other is SensorData ? timestamp.isAtSameMomentAs(other.timestamp) : false;
  @override int get hashCode => timestamp.hashCode;
  @override int compareTo(SensorData other) => timestamp.compareTo(other.timestamp);

}