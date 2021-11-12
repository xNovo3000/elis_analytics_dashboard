import 'package:flutter/widgets.dart';

// enum
class Gender {

  factory Gender.fromTechnicalName(final String? technicalName) =>
    values.singleWhere((element) => technicalName == element.technicalName, orElse: () => na);

  const Gender._({
    required this.singular,
    required this.plural,
    required this.technicalName,
    required this.color,
  });

  final String singular;
  final String plural;
  final String technicalName;
  final Color color;

  @override String toString() => singular;

  // instances
  static const male = Gender._(singular: 'Uomo', plural: 'Uomini', technicalName: 'M', color: Color(0xFF90CAF9));
  static const female = Gender._(singular: 'Donna', plural: 'Donne', technicalName: 'F', color: Color(0xFFF48FB1));

  // special instance for clusters (also not included in enumeration)
  static const na = Gender._(singular: 'N/A', plural: 'N/A', technicalName: '', color: Color(0xFFD6D6D6));
  static const other = Gender._(singular: 'Altro', plural: 'Altri', technicalName: '', color: Color(0xFF7F7F7F));

  // recursive enumeration
  static const values = const <Gender>[male, female];

}