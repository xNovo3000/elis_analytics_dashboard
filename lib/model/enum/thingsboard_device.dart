// enum
class ThingsboardDevice {

  const ThingsboardDevice._({
    required this.uri,
  });

  final String uri;

  @override String toString() => uri;

  // instances
  static const ThingsboardDevice weatherStation = ThingsboardDevice._(uri: 'ee55cb40-cf52-11eb-b683-ab203c34dc02');

  // recursive enumeration
  static const List<ThingsboardDevice> values = const <ThingsboardDevice>[
    weatherStation
  ];

}