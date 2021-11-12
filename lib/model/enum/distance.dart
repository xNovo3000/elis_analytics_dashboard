// enum
class Distance {

  factory Distance.fromTechnicalName(final String? technicalName) =>
    values.singleWhere((element) => technicalName == element.technicalName, orElse: () => na);

  const Distance._({
    required this.name,
    required this.technicalName,
    required this.average,
  });

  final String name;
  final String technicalName;
  final int average;

  @override String toString() => name;

  // instances
  static const Distance from0to10 = Distance._(name: '0-10', technicalName: '000-010', average: 5);
  static const Distance from10to20 = Distance._(name: '10-20', technicalName: '010-020', average: 15);
  static const Distance from20to30 = Distance._(name: '20-30', technicalName: '020-030', average: 25);
  static const Distance from30to40 = Distance._(name: '30-40', technicalName: '030-040', average: 35);
  static const Distance from40to50 = Distance._(name: '40-50', technicalName: '040-050', average: 45);
  static const Distance from50plus = Distance._(name: '50+', technicalName: '50+', average: 55);

  // special instance for clusters (also not included in enumeration)
  static const Distance na = Distance._(name: 'N/A', technicalName: '', average: 65);
  static const Distance other = Distance._(name: 'Altro', technicalName: '', average: 0);

  // recursive enumeration
  static const List<Distance> values = const <Distance>[
    from0to10, from10to20, from20to30, from30to40, from40to50, from50plus
  ];

}