import 'dart:math';

import 'package:elis_analytics_dashboard/foundation/utils.dart';
import 'package:elis_analytics_dashboard/model/data/room_visits.dart';
import 'package:elis_analytics_dashboard/model/enum/room_visits.dart';

class SensorVisits implements Comparable<SensorVisits> {

  factory SensorVisits.fromMap(final Map<String, dynamic> map) => SensorVisits(
    timestamp: DateTime.fromMillisecondsSinceEpoch(map['ts'], isUtc: true).toLocal(),
    roomsData: List.generate(
      RoomVisits.values.length,
      (index) => RoomVisitsData(
        room: RoomVisits.values[index],
        occupancy: Utils.getOccupancy(map[RoomVisits.values[index].technicalName]),
      ),
      growable: false
    ),
    returnRate: map['tasso_di_ritorno'],
    dwellTime: Duration(minutes: map['tempo_medio_permanenza']),
  );

  // TEST: used only for testing purposes
  factory SensorVisits.test([int index = 0]) {
    final random = Random();
    return SensorVisits(
      timestamp: DateTime.now().add(Duration(minutes: index * 30)),
      roomsData: List.generate(
        RoomVisits.values.length,
          (index) => RoomVisitsData(
            room: RoomVisits.values[index],
            occupancy: random.nextInt(20),
          ),
        growable: false
      ),
      returnRate: random.nextDouble() * 100,
      dwellTime: Duration(minutes: random.nextInt(20)),
    );
  }

  const SensorVisits({
    required this.timestamp,
    required this.roomsData,
    required this.returnRate,
    required this.dwellTime,
  });

  final DateTime timestamp;
  final List<RoomVisitsData> roomsData;
  final double returnRate;
  final Duration dwellTime;

  int get total {
    int result = 0;
    roomsData.forEach((room) => result += room.occupancy ?? 0);
    return result;
  }

  @override String toString() =>
    'SensorVisits(timestamp: $timestamp, roomsData: $roomsData), '
    'returnRate: $returnRate, dwellTime: $dwellTime)';
  @override bool operator ==(Object other) => other is SensorVisits ? timestamp.isAtSameMomentAs(other.timestamp) : false;
  @override int get hashCode => timestamp.hashCode;
  @override int compareTo(SensorVisits other) => timestamp.compareTo(other.timestamp);

}