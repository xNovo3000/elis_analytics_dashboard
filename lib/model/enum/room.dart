// enum
class Room {

  // TODO: add N/A value for error catching
  factory Room.fromTechnicalName(final String? technicalName) =>
    values.singleWhere((element) => technicalName == element.technicalName);

  const Room._({
    required this.name,
    required this.technicalName,
    required this.capacity,
    required this.standing,
  });

  final String name;
  final String technicalName;
  final int capacity;
  final bool standing;

  @override String toString() => name;

  // instances
  static const Room hall = Room._(name: 'Hall', technicalName: 'visitatori_hall', capacity: 10, standing: false);
  static const Room openSpace = Room._(name: 'Open Space', technicalName: 'visitatori_openspace', capacity: 10, standing: false);
  static const Room pascal = Room._(name: 'Aula Pascal', technicalName: 'visitatori_pascal', capacity: 10, standing: true);
  static const Room lagrange = Room._(name: 'Aula Lagrange', technicalName: 'visitatori_lagrange', capacity: 10, standing: true);
  static const Room corridoio = Room._(name: 'Corridoio', technicalName: 'visitatori_corridoio', capacity: 10, standing: false);
  static const Room pinnhub = Room._(name: 'Innovation Hub', technicalName: 'visitatori_Pinnhub', capacity: 10, standing: false);
  static const Room tesla = Room._(name: 'Aula Tesla', technicalName: 'visitatori_tesla', capacity: 10, standing: false);

  /*
   * Piccolezze da ricordare:
   * - aula Tesla non esiste più, innovation hub adesso la ingloba
   * -
   */

  // recursive enumeration
  static const List<Room> values = const <Room>[
    hall, openSpace, pascal, lagrange, corridoio, pinnhub, tesla
  ];

}