// enum
class Age {

  factory Age.fromTechnicalName(final String? technicalName) =>
    values.singleWhere((element) => technicalName == element.technicalName, orElse: () => na);

  const Age._({
    required this.name,
    required this.technicalName,
  });

  final String name;
  final String technicalName;

  @override String toString() => name;

  // instances
  static const Age from15to25 = Age._(name: '15-25', technicalName: '[15-25]');
  static const Age from25to35 = Age._(name: '25-35', technicalName: '(25-35]');
  static const Age from35to45 = Age._(name: '35-45', technicalName: '(35-45]');
  static const Age from45to55 = Age._(name: '45-55', technicalName: '(45-55]');
  static const Age from55to65 = Age._(name: '55-65', technicalName: '(55-65]');
  static const Age from65plus = Age._(name: '65+', technicalName: '>65');
  static const Age na = Age._(name: 'N/A', technicalName: '');

  // recursive enumeration
  static const List<Age> values = const <Age>[
    from15to25, from25to35, from35to45, from45to55,
    from55to65, from65plus, na
  ];

}