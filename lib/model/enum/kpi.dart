class KPI {

  factory KPI.fromTechnicalName(final String technicalName) =>
    values.singleWhere((kpi) => kpi.technicalName == technicalName);

  const KPI._({
    required this.displayName,
    required this.technicalName,
  });

  final String displayName;
  final String technicalName;

  @override String toString() => displayName;

  static const gender = KPI._(displayName: 'Genere', technicalName: 'gender');
  static const age = KPI._(displayName: 'Età', technicalName: 'age');
  static const nationality = KPI._(displayName: 'Nazionalità', technicalName: 'nationality');
  static const country = KPI._(displayName: 'Nazione', technicalName: 'country');
  static const region = KPI._(displayName: 'Regione', technicalName: 'region');
  static const province = KPI._(displayName: 'Provincia', technicalName: 'province');
  static const municipality = KPI._(displayName: 'Città', technicalName: 'municipality');
  static const homeDistance = KPI._(displayName: 'Distanza da casa', technicalName: 'home_distance');
  static const workDistance = KPI._(displayName: 'Distanza da lavoro', technicalName: 'work_distance');

  static const values = const <KPI>[
    gender, nationality, country, region,
    province, municipality, homeDistance, workDistance
  ];

}