// Enum
class RoomAttendance {

  factory RoomAttendance.fromTechnicalName(final String? technicalName) =>
    values.singleWhere(
      (element) => technicalName == element.technicalName,
      orElse: () => na
    );

  const RoomAttendance._({
    required this.displayName,
    required this.technicalName,
    required this.capacity,
  });

  final String displayName;
  final String technicalName;
  final int capacity;

  @override String toString() => displayName;

  // Instances
  static const lagrange = RoomAttendance._(displayName: 'Aula Lagrange', technicalName: 'presenze_lagrange', capacity: 40);
  static const tesla = RoomAttendance._(displayName: 'Aula Tesla', technicalName: 'presenze_tesla', capacity: 30);

  // Error catching
  static const na = RoomAttendance._(displayName: '', technicalName: '', capacity: 1);

  // Values
  static const values = <RoomAttendance>[
    lagrange, tesla
  ];

}