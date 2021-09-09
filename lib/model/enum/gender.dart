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
  static const Gender male = Gender._(singular: 'Maschio', plural: 'Maschi', technicalName: 'M', color: const Color(0xFF2196F3));
  static const Gender female = Gender._(singular: 'Femmina', plural: 'Femmine', technicalName: 'F', color: const Color(0xFFE91E63));
  static const Gender na = Gender._(singular: 'N/A', plural: 'N/A', technicalName: '', color: const Color(0xFFD6D6D6));

  // recursive enumeration
  static const List<Gender> values = const <Gender>[male, female, na];

}