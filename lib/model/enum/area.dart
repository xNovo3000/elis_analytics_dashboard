// enum
class Area {

  factory Area.fromTechnicalName(final String? technicalName) =>
    values.singleWhere((element) => technicalName == element.technicalName, orElse: () => na);

  const Area._({
    required this.name,
    required this.technicalName,
  });

  final String name;
  final String technicalName;

  @override String toString() => name;

  // instances
  static const Area campus = Area._(name: 'Campus', technicalName: 'INDOOR');
  static const Area neighborhood = Area._(name: 'Quartiere', technicalName: 'OUTDOOR');
  static const Area na = Area._(name: 'N/A', technicalName: '');

  // recursive enumeration
  static const List<Area> values = const <Area>[campus, neighborhood, na];

}