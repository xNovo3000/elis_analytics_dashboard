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
  static const pioneers = RoomAttendance._(displayName: 'Aula Pionieri', technicalName: 'presenze_tesla', capacity: 25);

  // Error catching
  static const na = RoomAttendance._(displayName: '', technicalName: '', capacity: 1);

  // Values
  static const values = <RoomAttendance>[
    lagrange, pioneers
  ];

  /*
   * Aula Tesla è stata rinominata in Aula Pionieri,
   * il vecchio "technical_name" rimane uguale poiché
   * è legato ai dati precedenti inviati da G-move
   */

}