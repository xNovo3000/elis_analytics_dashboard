// enum
class Room {

  // N/A value impossible
  factory Room.fromTechnicalName(final String? technicalName) =>
    values.singleWhere((element) => technicalName == element.technicalName);

  const Room._({
    required this.name,
    required this.technicalName,
    required this.capacity,
  });

  final String name;
  final String technicalName;
  final int capacity;

  @override String toString() => name;

  // instances
  static const Room hall = Room._(name: 'Hall', technicalName: 'hall', capacity: 10);
  static const Room openSpace = Room._(name: 'Open Space', technicalName: 'openspace', capacity: 10);
  static const Room pascal = Room._(name: 'Aula Pascal', technicalName: 'pascal', capacity: 10);
  static const Room lagrange = Room._(name: 'Aula Lagrange', technicalName: 'lagrange', capacity: 10);
  static const Room corridoio = Room._(name: 'Corridoio', technicalName: 'corridoio', capacity: 10);
  static const Room pinnhub = Room._(name: 'Innovation Hub', technicalName: 'Pinnhub', capacity: 10);
  static const Room tesla = Room._(name: 'Aula Tesla', technicalName: 'tesla', capacity: 10);

  // recursive enumeration
  static const List<Room> values = const <Room>[
    hall, openSpace, pascal, lagrange, corridoio, pinnhub, tesla
  ];

}