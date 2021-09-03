// enum
class Gender {

  factory Gender.fromTechnicalName(final String? technicalName) =>
    values.singleWhere((element) => technicalName == element.technicalName, orElse: () => na);

  const Gender._({
    required this.singular,
    required this.plural,
    required this.technicalName,
  });

  final String singular;
  final String plural;
  final String technicalName;

  @override String toString() => singular;

  // instances
  static const Gender male = Gender._(singular: 'Maschio', plural: 'Maschi', technicalName: 'M');
  static const Gender female = Gender._(singular: 'Femmina', plural: 'Femmine', technicalName: 'F');
  static const Gender na = Gender._(singular: 'N/A', plural: 'N/A', technicalName: '');

  // recursive enumeration
  static const List<Gender> values = const <Gender>[male, female, na];

}