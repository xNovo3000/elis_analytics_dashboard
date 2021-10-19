import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';

class KPI {

  factory KPI.fromTechnicalName(final String technicalName) =>
    values.singleWhere((kpi) => kpi.technicalName == technicalName);

  const KPI._({
    required this.displayName,
    required this.technicalName,
    required this.isComplex,
    required this.is100Percent,
  });

  final String displayName;
  final String technicalName;
  final bool isComplex;
  final bool is100Percent;

  @override String toString() => displayName;

  /* Vodafone KPI */
  static const campusGender = KPI._(displayName: 'Genere nel campus', technicalName: 'campus_gender', isComplex: true, is100Percent: false);
  static const neighborhoodGender = KPI._(displayName: 'Genere nel quartiere', technicalName: 'neighborhood_gender', isComplex: true, is100Percent: false);
  static const campusAge = KPI._(displayName: 'Età nel campus', technicalName: 'campus_age', isComplex: true, is100Percent: false);
  static const neighborhoodAge = KPI._(displayName: 'Età nel quartiere', technicalName: 'neighborhood_age', isComplex: true, is100Percent: false);
  static const campusAgeAverage = KPI._(displayName: 'Età media nel campus', technicalName: 'campus_age_average', isComplex: false, is100Percent: false);
  static const neighborhoodAgeAverage = KPI._(displayName: 'Età media nel quartiere', technicalName: 'neighborhood_age_average', isComplex: false, is100Percent: false);
  static const campusNationality = KPI._(displayName: 'Nazionalità nel campus', technicalName: 'campus_nationality', isComplex: true, is100Percent: false);
  static const neighborhoodNationality = KPI._(displayName: 'Nazionalità nel quartiere', technicalName: 'neighborhood_nationality', isComplex: true, is100Percent: false);
  static const campusForeigners = KPI._(displayName: 'Stranieri nel campus', technicalName: 'campus_foreigners', isComplex: false, is100Percent: false);
  static const neighborhoodForeigners = KPI._(displayName: 'Stranieri nel quartiere', technicalName: 'neighborhood_foreigners', isComplex: false, is100Percent: false);
  static const campusCountries = KPI._(displayName: 'Nazioni nel campus', technicalName: 'campus_countries', isComplex: true, is100Percent: false);
  static const neighborhoodCountries = KPI._(displayName: 'Nazioni nel quartiere', technicalName: 'neighborhood_countries', isComplex: true, is100Percent: false);
  static const campusRegion = KPI._(displayName: 'Regioni nel campus', technicalName: 'campus_regions', isComplex: true, is100Percent: false);
  static const neighborhoodRegion = KPI._(displayName: 'Regione nel quartiere', technicalName: 'neighborhood_regions', isComplex: true, is100Percent: false);
  static const campusProvince = KPI._(displayName: 'Province nel campus', technicalName: 'campus_province', isComplex: true, is100Percent: false);
  static const neighborhoodProvince = KPI._(displayName: 'Province nel quartiere', technicalName: 'neighborhood_province', isComplex: true, is100Percent: false);
  static const campusMunicipality = KPI._(displayName: 'Città nel campus', technicalName: 'campus_municipality', isComplex: true, is100Percent: false);
  static const neighborhoodMunicipality = KPI._(displayName: 'Città nel quartiere', technicalName: 'neighborhood_municipality', isComplex: true, is100Percent: false);
  static const campusHomeDistance = KPI._(displayName: 'Distanza da casa nel campus', technicalName: 'campus_home_distance', isComplex: true, is100Percent: false);
  static const neighborhoodHomeDistance = KPI._(displayName: 'Distanza da casa nel quartiere', technicalName: 'neighborhood_home_distance', isComplex: true, is100Percent: false);
  static const campusHomeDistanceAverage = KPI._(displayName: 'Distanza da casa media nel campus', technicalName: 'campus_home_distance_average', isComplex: false, is100Percent: false);
  static const neighborhoodHomeDistanceAverage = KPI._(displayName: 'Distanza da casa media nel quartiere', technicalName: 'neighborhood_home_distance_average', isComplex: false, is100Percent: false);
  static const campusWorkDistance = KPI._(displayName: 'Distanza da lavoro nel campus', technicalName: 'campus_work_distance', isComplex: true, is100Percent: false);
  static const neighborhoodWorkDistance = KPI._(displayName: 'Distanza da lavoro nel quartiere', technicalName: 'neighborhood_work_distance', isComplex: true, is100Percent: false);
  static const campusWorkDistanceAverage = KPI._(displayName: 'Distanza da lavoro media nel campus', technicalName: 'campus_work_distance_average', isComplex: false, is100Percent: false);
  static const neighborhoodWorkDistanceAverage = KPI._(displayName: 'Distanza da lavoro media nel quartiere', technicalName: 'neighborhood_work_distance_average', isComplex: false, is100Percent: false);

  /* G-move KPI */
  static const roomsOccupancy = KPI._(displayName: 'Occupazione aule', technicalName: 'rooms_occupancy', isComplex: true, is100Percent: false);

  /* None */
  static const na = KPI._(displayName: 'N/A', technicalName: '', isComplex: false, is100Percent: false);

  static const values = <KPI>[
    /* Vodafone KPI */
    campusGender, neighborhoodGender, campusAge, neighborhoodAge, campusAgeAverage, neighborhoodAgeAverage,
    campusNationality, neighborhoodNationality, campusForeigners, neighborhoodForeigners,
    campusCountries, neighborhoodCountries, campusRegion, neighborhoodRegion,
    campusProvince, neighborhoodProvince, campusMunicipality, neighborhoodMunicipality,
    campusHomeDistance, neighborhoodHomeDistance, campusHomeDistanceAverage, neighborhoodHomeDistanceAverage,
    campusWorkDistance, neighborhoodWorkDistance, campusWorkDistanceAverage, neighborhoodWorkDistanceAverage,
    /* G-move KPI */
    roomsOccupancy,
  ];


  /*
  static final _chartDateResolver = DateFormat('d/M');

  static List<ChartSeries> _genderSeries(List data, {bool simple = false, bool to100Percent = false}) =>
    [
      if (simple) throw IncompatibleSeriesException('GenderSeries is not simple'),
      for (Gender gender in Gender.values)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.gender)
              .whereCondition((cluster) => cluster.gender == gender).visitors,
          legendItemText: '$gender',
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.gender)
              .whereCondition((cluster) => cluster.gender == gender).visitors,
          legendItemText: '$gender',
          animationDuration: 0
        ),
    ];

  static List<ChartSeries> _ageSeries(List data, {bool simple = false, bool to100Percent = false}) =>
    [
      if (simple) throw IncompatibleSeriesException('Age is not simple'),
      for (Age age in Age.values)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.age)
              .whereCondition((cluster) => cluster.age == age).visitors,
          legendItemText: '$age',
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.age)
              .whereCondition((cluster) => cluster.age == age).visitors,
          legendItemText: '$age',
          animationDuration: 0
        ),
    ];

  static List<ChartSeries> _nationalitySeries(List data, {bool simple = false, bool to100Percent = false}) =>
    [
      if (simple) throw IncompatibleSeriesException('Nationality is not simple'),
      for (Nationality nationality in Nationality.values)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.nationality)
              .whereCondition((cluster) => cluster.nationality == nationality).visitors,
          legendItemText: '$nationality',
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.nationality)
              .whereCondition((cluster) => cluster.nationality == nationality).visitors,
          legendItemText: '$nationality',
          animationDuration: 0
        ),
    ];

  static List<ChartSeries> _countrySeries(List data, {bool simple = false, bool to100Percent = false}) {
    // Check
    if (simple) throw IncompatibleSeriesException('Country is not simple');
    // Useful for debug
    data as VodafoneDailyList;
    final countryList = HashSet<String>();
    data.forEach((daily) => daily.forEach((cluster) => countryList.add(cluster.country)));
    return [
      for (String country in countryList)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.country)
              .whereCondition((cluster) => cluster.country == country).visitors,
          legendItemText: country,
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.country)
              .whereCondition((cluster) => cluster.country == country).visitors,
          legendItemText: country,
          animationDuration: 0
        ),
    ];
  }

  static List<ChartSeries> _regionSeries(List data, {bool simple = false, bool to100Percent = false}) =>
    [
      if (simple) throw IncompatibleSeriesException('Region is not simple'),
      for (Region region in Region.values)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.region)
              .whereCondition((cluster) => cluster.region == region).visitors,
          legendItemText: '$region',
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.region)
              .whereCondition((cluster) => cluster.region == region).visitors,
          legendItemText: '$region',
          animationDuration: 0
        ),
    ];

  static List<ChartSeries> _provinceSeries(List data, {bool simple = false, bool to100Percent = false}) {
    // Check
    if (simple) throw IncompatibleSeriesException('Province is not simple');
    // Useful for debug
    data as VodafoneDailyList;
    final provinceList = HashSet<String>();
    data.forEach((daily) => daily.forEach((cluster) => provinceList.add(cluster.province)));
    return [
      for (String province in provinceList)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.province)
              .whereCondition((cluster) => cluster.province == province).visitors,
          legendItemText: province,
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.province)
              .whereCondition((cluster) => cluster.province == province).visitors,
          legendItemText: province,
          animationDuration: 0
        ),
    ];
  }

  static List<ChartSeries> _municipalitySeries(List data, {bool simple = false, bool to100Percent = false}) {
    // Check
    if (simple) throw IncompatibleSeriesException('Municipality is not simple');
    // Useful for debug
    data as VodafoneDailyList;
    final municipalityList = HashSet<String>();
    data.forEach((daily) => daily.forEach((cluster) => municipalityList.add(cluster.municipality)));
    return [
      for (String municipality in municipalityList)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.municipality)
              .whereCondition((cluster) => cluster.municipality == municipality).visitors,
          legendItemText: municipality,
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.municipality)
              .whereCondition((cluster) => cluster.municipality == municipality).visitors,
          legendItemText: municipality,
          animationDuration: 0
        ),
    ];
  }

  static List<ChartSeries> _homeDistanceSeries(List data, {bool simple = false, bool to100Percent = false}) =>
    [
      if (simple) throw IncompatibleSeriesException('Home distance is not simple'),
      for (Distance distance in Distance.values)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.homeDistance)
              .whereCondition((cluster) => cluster.homeDistance == distance).visitors,
          legendItemText: '$distance',
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.homeDistance)
              .whereCondition((cluster) => cluster.homeDistance == distance).visitors,
          legendItemText: '$distance',
          animationDuration: 0
        ),
    ];

  static List<ChartSeries> _workDistanceSeries(List data, {bool simple = false, bool to100Percent = false}) =>
    [
      if (simple) throw IncompatibleSeriesException('Work distance is not simple'),
      for (Distance distance in Distance.values)
        to100Percent ? StackedColumn100Series<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.workDistance)
              .whereCondition((cluster) => cluster.workDistance == distance).visitors,
          legendItemText: '$distance',
          animationDuration: 0
        ) : StackedColumnSeries<VodafoneDaily, String>(
          dataSource: data as VodafoneDailyList,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.date),
          yValueMapper: (datum, index) =>
            datum.collapseFromKPI(KPI.workDistance)
              .whereCondition((cluster) => cluster.workDistance == distance).visitors,
          legendItemText: '$distance',
          animationDuration: 0
        ),
    ];

  static List<ChartSeries> _roomsOccupancySeries(List data, {bool simple = false, bool to100Percent = false}) =>
    [
      if (simple) throw IncompatibleSeriesException('Rooms occupancy is not simple'),
      for (Room room in Room.values)
        to100Percent ? StackedColumn100Series<SensorData, String>(
          dataSource: data as List<SensorData>,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.timestamp),
          yValueMapper: (datum, index) =>
            datum.roomsData.singleWhere((roomData) => roomData.room == room).occupancy,
          legendItemText: '$room',
          animationDuration: 0
        ) : StackedColumnSeries<SensorData, String>(
          dataSource: data as List<SensorData>,
          xValueMapper: (datum, index) => _chartDateResolver.format(datum.timestamp),
          yValueMapper: (datum, index) =>
            datum.roomsData.singleWhere((roomData) => roomData.room == room).occupancy,
          legendItemText: '$room',
          animationDuration: 0
        ),
    ];

  static List<ChartSeries> _naSeries(List data, {bool simple = false, bool to100Percent = false}) => [];
  */

  /* TODO: Blacklist system */

}