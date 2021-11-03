class KPI {

  factory KPI.fromTechnicalName(final String technicalName) =>
    values.singleWhere((kpi) => kpi.technicalName == technicalName);

  const KPI._({
    required this.displayName,
    required this.technicalName,
    required this.isComplex,
  });

  final String displayName;
  final String technicalName;
  final bool isComplex;

  @override String toString() => displayName;

  /* Vodafone KPI */
  static const campusGender = KPI._(displayName: 'Genere nel campus', technicalName: 'campus_gender', isComplex: true);
  static const neighborhoodGender = KPI._(displayName: 'Genere nel quartiere', technicalName: 'neighborhood_gender', isComplex: true);
  static const campusAge = KPI._(displayName: 'Età nel campus', technicalName: 'campus_age', isComplex: true);
  static const neighborhoodAge = KPI._(displayName: 'Età nel quartiere', technicalName: 'neighborhood_age', isComplex: true);
  static const campusAgeAverage = KPI._(displayName: 'Età media nel campus', technicalName: 'campus_age_average', isComplex: false);
  static const neighborhoodAgeAverage = KPI._(displayName: 'Età media nel quartiere', technicalName: 'neighborhood_age_average', isComplex: false);
  static const campusNationality = KPI._(displayName: 'Nazionalità nel campus', technicalName: 'campus_nationality', isComplex: true);
  static const neighborhoodNationality = KPI._(displayName: 'Nazionalità nel quartiere', technicalName: 'neighborhood_nationality', isComplex: true);
  static const campusForeigners = KPI._(displayName: 'Stranieri nel campus', technicalName: 'campus_foreigners', isComplex: false);
  static const neighborhoodForeigners = KPI._(displayName: 'Stranieri nel quartiere', technicalName: 'neighborhood_foreigners', isComplex: false);
  static const campusCountries = KPI._(displayName: 'Nazioni nel campus', technicalName: 'campus_countries', isComplex: true);
  static const neighborhoodCountries = KPI._(displayName: 'Nazioni nel quartiere', technicalName: 'neighborhood_countries', isComplex: true);
  static const campusRegion = KPI._(displayName: 'Regioni nel campus', technicalName: 'campus_regions', isComplex: true);
  static const neighborhoodRegion = KPI._(displayName: 'Regione nel quartiere', technicalName: 'neighborhood_regions', isComplex: true);
  static const campusProvince = KPI._(displayName: 'Province nel campus', technicalName: 'campus_province', isComplex: true);
  static const neighborhoodProvince = KPI._(displayName: 'Province nel quartiere', technicalName: 'neighborhood_province', isComplex: true);
  static const campusMunicipality = KPI._(displayName: 'Città nel campus', technicalName: 'campus_municipality', isComplex: true);
  static const neighborhoodMunicipality = KPI._(displayName: 'Città nel quartiere', technicalName: 'neighborhood_municipality', isComplex: true);
  static const campusHomeDistance = KPI._(displayName: 'Distanza da casa nel campus', technicalName: 'campus_home_distance', isComplex: true);
  static const neighborhoodHomeDistance = KPI._(displayName: 'Distanza da casa nel quartiere', technicalName: 'neighborhood_home_distance', isComplex: true);
  static const campusWorkDistance = KPI._(displayName: 'Distanza da lavoro nel campus', technicalName: 'campus_work_distance', isComplex: true);
  static const neighborhoodWorkDistance = KPI._(displayName: 'Distanza da lavoro nel quartiere', technicalName: 'neighborhood_work_distance', isComplex: true);
  static const campusHomeDistanceAverage = KPI._(displayName: 'Distanza da casa media nel campus', technicalName: 'campus_home_distance_average', isComplex: false);
  static const neighborhoodHomeDistanceAverage = KPI._(displayName: 'Distanza da casa media nel quartiere', technicalName: 'neighborhood_home_distance_average', isComplex: false);
  static const campusWorkDistanceAverage = KPI._(displayName: 'Distanza da lavoro media nel campus', technicalName: 'campus_work_distance_average', isComplex: false);
  static const neighborhoodWorkDistanceAverage = KPI._(displayName: 'Distanza da lavoro media nel quartiere', technicalName: 'neighborhood_work_distance_average', isComplex: false);

  /* G-move KPI */
  static const roomsAttendance = KPI._(displayName: 'Occupazione aule', technicalName: 'rooms_attendance', isComplex: true);
  static const roomsVisits = KPI._(displayName: 'Transito aule', technicalName: 'rooms_visits', isComplex: true);

  /* None */
  static const na = KPI._(displayName: 'N/A', technicalName: '', isComplex: false);

  static const values = <KPI>[
    /* Vodafone KPI */
    campusGender, neighborhoodGender, campusAge, neighborhoodAge, campusAgeAverage, neighborhoodAgeAverage,
    campusNationality, neighborhoodNationality, campusForeigners, neighborhoodForeigners,
    campusCountries, neighborhoodCountries, campusRegion, neighborhoodRegion,
    campusProvince, neighborhoodProvince, campusMunicipality, neighborhoodMunicipality,
    campusHomeDistance, neighborhoodHomeDistance, campusHomeDistanceAverage, neighborhoodHomeDistanceAverage,
    campusWorkDistance, neighborhoodWorkDistance, campusWorkDistanceAverage, neighborhoodWorkDistanceAverage,
    /* G-move KPI */
    roomsAttendance, roomsVisits,
  ];

  // Blacklist system
  static const blacklist = <KPI, List<KPI>>{

  };

}