// enum
class Distance {

  factory Distance.fromTechnicalName(final String? technicalName) =>
    values.singleWhere((element) => technicalName == element.technicalName, orElse: () => na);

  const Distance._({
    required this.name,
    required this.technicalName,
  });

  final String name;
  final String technicalName;

  @override String toString() => name;

  // instances
  static const Distance from0to10 = Distance._(name: '0-10', technicalName: '000-010');
  static const Distance from10to20 = Distance._(name: '10-20', technicalName: '010-020');
  static const Distance from20to30 = Distance._(name: '20-30', technicalName: '020-030');
  static const Distance from30to40 = Distance._(name: '30-40', technicalName: '030-040');
  static const Distance from40to50 = Distance._(name: '40-50', technicalName: '040-050');
  static const Distance from50plus = Distance._(name: '50+', technicalName: '50+');
  static const Distance na = Distance._(name: 'N/A', technicalName: '');

  // recursive enumeration
  static const List<Distance> values = const <Distance>[
    from0to10, from10to20, from20to30, from30to40,
    from40to50, from50plus, na
  ];

}