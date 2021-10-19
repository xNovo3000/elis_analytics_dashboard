// enum
class ThingsboardDevice {

  const ThingsboardDevice._({
    required this.id,
  });

  final String id;

  @override String toString() => '$id';

  // instances
  static const ThingsboardDevice weatherStation = ThingsboardDevice._(id: 'ee55cb40-cf52-11eb-b683-ab203c34dc02');
  static const ThingsboardDevice vodafoneIndoor = ThingsboardDevice._(id: '752c2730-2a9e-11ec-abc5-0989dc5dd698');
  static const ThingsboardDevice vodafoneOutdoor = ThingsboardDevice._(id: '6f1fb0f0-2a9e-11ec-abc5-0989dc5dd698');
  static const ThingsboardDevice sensorsRealtime = ThingsboardDevice._(id: '349be090-d4fc-11eb-8a8d-ddcdb4d4646a');
  static const ThingsboardDevice sensorsDaily = ThingsboardDevice._(id: 'aabd2220-dcc2-11eb-804a-6b845e08a1a9');
  static const ThingsboardDevice sensorsWeekly = ThingsboardDevice._(id: '89c61940-dd77-11eb-804a-6b845e08a1a9');

  // recursive enumeration
  static const List<ThingsboardDevice> values = const <ThingsboardDevice>[
    weatherStation, vodafoneIndoor, vodafoneOutdoor,
    sensorsRealtime, sensorsDaily, sensorsWeekly
  ];

}