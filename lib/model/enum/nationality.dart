// enum
class Nationality {

  factory Nationality.fromTechnicalName(final String? technicalName) =>
    values.singleWhere((element) => technicalName == element.technicalName, orElse: () => na);

  const Nationality._({
    required this.singular,
    required this.plural,
    required this.technicalName,
  });

  final String singular;
  final String plural;
  final String technicalName;

  @override String toString() => singular;

  // instances
  static const Nationality italian = Nationality._(singular: 'Italiano', plural: 'Italiani', technicalName: 'ITALIANS');
  static const Nationality foreigner = Nationality._(singular: 'Straniero', plural: 'Stranieri', technicalName: 'FOREIGNERS');

  // special instance for clusters (also not included in enumeration)
  static const Nationality na = Nationality._(singular: 'N/A', plural: 'N/A', technicalName: '');
  static const Nationality other = Nationality._(singular: 'Altro', plural: 'Altri', technicalName: '');

  // recursive enumeration
  static const List<Nationality> values = const <Nationality>[italian, foreigner];

}