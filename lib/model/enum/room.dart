// Enum
class Room {

  // Added N/A value for error catching
  factory Room.fromTechnicalName(final String? technicalName) =>
    values.singleWhere(
      (element) => technicalName == element.technicalName,
      orElse: () => na
    );

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
  static const attendanceLagrange = Room._(name: 'Aula Lagrange', technicalName: 'presenze_lagrange', capacity: 10);
  static const attendanceTesla = Room._(name: 'Aula Tesla', technicalName: 'presenze_tesla', capacity: 10);
  static const visitorsHall = Room._(name: 'Hall', technicalName: 'visitatori_hall', capacity: 10);
  static const visitorsOpenSpace = Room._(name: 'Open Space', technicalName: 'visitatori_openspace', capacity: 10);
  static const visitorsPascal = Room._(name: 'Aula Pascal', technicalName: 'visitatori_pascal', capacity: 10);
  static const visitorsLagrange = Room._(name: 'Aula Lagrange', technicalName: 'visitatori_lagrange', capacity: 10);
  static const visitorsCorridoio = Room._(name: 'Corridoio', technicalName: 'visitatori_corridoio', capacity: 10);
  static const visitorsPinnhub = Room._(name: 'Innovation Hub', technicalName: 'visitatori_Pinnhub', capacity: 10);
  static const visitorsTesla = Room._(name: 'Aula Tesla', technicalName: 'visitatori_tesla', capacity: 10);
  static const visitorsOpenItalyLagrange = Room._(name: 'OpenItaly aula Lagrange', technicalName: 'ELIS1941239439293_OpenItalyLagrange', capacity: 10);
  static const visitorsOpenItalyTesla = Room._(name: 'OpenItaly aula Tesla', technicalName: 'ELIS1941239439293_OpenItalyLagrange', capacity: 10);

  // Error catching
  static const na = Room._(name: '', technicalName: '', capacity: 0);

  // Attendance values
  static const attendanceValues = const <Room>[
    attendanceLagrange, attendanceTesla
  ];
  
  // Recursive enumeration
  static const values = const <Room>[
    visitorsHall, visitorsOpenSpace, visitorsPascal, visitorsLagrange, visitorsCorridoio,
    visitorsPinnhub, visitorsTesla, visitorsOpenItalyLagrange, visitorsOpenItalyTesla
  ];

}