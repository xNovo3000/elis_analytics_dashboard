// Enum
class RoomVisits {

  factory RoomVisits.fromTechnicalName(final String? technicalName) =>
    values.singleWhere(
      (element) => technicalName == element.technicalName,
      orElse: () => na
    );

  const RoomVisits._({
    required this.name,
    required this.technicalName,
  });

  final String name;
  final String technicalName;

  @override String toString() => name;

  // Instances
  static const hall = RoomVisits._(name: 'Hall', technicalName: 'visitatori_hall');
  static const openSpace = RoomVisits._(name: 'Open Space', technicalName: 'visitatori_openspace');
  static const pascal = RoomVisits._(name: 'Aula Pascal', technicalName: 'visitatori_pascal');
  static const corridoio = RoomVisits._(name: 'Corridoio', technicalName: 'visitatori_corridoio');
  static const pinnhub = RoomVisits._(name: 'Innovation Hub', technicalName: 'visitatori_Pinnhub');
  // static const OpenItalyLagrange = Room._(name: 'OpenItaly aula Lagrange', technicalName: 'ELIS1941239439293_OpenItalyLagrange', capacity: 10);
  // static const OpenItalyTesla = Room._(name: 'OpenItaly aula Tesla', technicalName: 'ELIS1941239439293_OpenItalyLagrange', capacity: 10);

  // Error catching
  static const na = RoomVisits._(name: '', technicalName: '');

  // Values
  static const values = const <RoomVisits>[
    hall,/* openSpace, */ pascal, corridoio, pinnhub
  ];

}