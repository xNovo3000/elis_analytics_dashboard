// Enum
class ThingsboardDevice {

  const ThingsboardDevice._({
    required this.id,
  });

  final String id;

  @override String toString() => '$id';

  // Instances
  static const ThingsboardDevice weatherStation = ThingsboardDevice._(id: 'ee55cb40-cf52-11eb-b683-ab203c34dc02');
  static const ThingsboardDevice vodafoneCampus = ThingsboardDevice._(id: '752c2730-2a9e-11ec-abc5-0989dc5dd698');
  static const ThingsboardDevice vodafoneNeighborhood = ThingsboardDevice._(id: '6f1fb0f0-2a9e-11ec-abc5-0989dc5dd698');
  static const ThingsboardDevice sensorsRealtimeAttendance = ThingsboardDevice._(id: 'a7e6a070-31af-11ec-8df4-b9d2de45366a');
  static const ThingsboardDevice sensorsRealtimeVisits = ThingsboardDevice._(id: 'b582aa80-31af-11ec-8df4-b9d2de45366a');

  /* Old unused endpoints */
  @deprecated
  static const ThingsboardDevice sensorsDaily = ThingsboardDevice._(id: 'aabd2220-dcc2-11eb-804a-6b845e08a1a9');
  @deprecated
  static const ThingsboardDevice sensorsWeekly = ThingsboardDevice._(id: '89c61940-dd77-11eb-804a-6b845e08a1a9');

  // Values
  static const List<ThingsboardDevice> values = const <ThingsboardDevice>[
    weatherStation, vodafoneCampus, vodafoneNeighborhood,
    sensorsRealtimeAttendance, sensorsRealtimeVisits,
  ];

}