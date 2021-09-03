// enum
class DistanceType {

  const DistanceType._({
    required this.name,
    required this.technicalName,
  });

  final String name;
  final String technicalName;

  @override String toString() => name;

  // instances
  static const DistanceType home = DistanceType._(name: 'Casa', technicalName: 'casa');
  static const DistanceType work = DistanceType._(name: 'Lavoro', technicalName: 'lavoro');

  // recursive enumeration
  static const List<DistanceType> values = const <DistanceType>[home, work];

}