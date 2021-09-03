// enum
class OccupancyDuration {

  factory OccupancyDuration.fromTechnicalName(final String? technicalName) =>
    values.singleWhere((element) => technicalName == element.technicalName, orElse: () => na);

  const OccupancyDuration._({
    required this.duration,
    required this.technicalName,
  });

  final Duration duration;
  final String technicalName;

  @override String toString() => duration.toString();

  // instances
  static const OccupancyDuration o10min = OccupancyDuration._(duration: Duration(minutes: 10), technicalName: '10min');
  static const OccupancyDuration o1day = OccupancyDuration._(duration: Duration(days: 1), technicalName: '1day');
  static const OccupancyDuration o1week = OccupancyDuration._(duration: Duration(days: 7), technicalName: '1week');
  static const OccupancyDuration na = OccupancyDuration._(duration: Duration(days: 0), technicalName: '');

  // recursive enumeration
  static const List<OccupancyDuration> values = const <OccupancyDuration>[
    o10min, o1day, o1week, na
  ];

}