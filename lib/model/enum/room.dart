// enum
class Room {

  // N/A value impossible
  factory Room.fromTechnicalName(final String? technicalName) =>
    values.singleWhere((element) => technicalName == element.technicalName);

  const Room._({
    required this.name,
    required this.technicalName,
  });

  final String name;
  final String technicalName;

  @override String toString() => name;

  // instances
  static const Room hall = Room._(name: 'Hall', technicalName: 'hall');
  static const Room openSpace = Room._(name: 'Open Space', technicalName: 'openspace');
  static const Room pascal = Room._(name: 'Aula Pascal', technicalName: 'pascal');
  static const Room lagrange = Room._(name: 'Aula Lagrange', technicalName: 'lagrange');
  static const Room corridoio = Room._(name: 'Corridoio', technicalName: 'corridoio');
  static const Room pinnhub = Room._(name: 'Innovation Hub', technicalName: 'Pinnhub');
  static const Room tesla = Room._(name: 'Aula Tesla', technicalName: 'tesla');

  // recursive enumeration
  static const List<Room> values = const <Room>[
    hall, openSpace, pascal, lagrange, corridoio, pinnhub, tesla
  ];

}