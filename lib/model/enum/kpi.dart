class KPI {

  factory KPI.fromTechnicalName(final String technicalName) =>
    values.singleWhere((kpi) => kpi.technicalName == technicalName);

  const KPI._({
    required this.displayName,
    required this.technicalName,
    required this.complex,
  });

  final String displayName;
  final String technicalName;
  final bool complex;

  @override String toString() => displayName;

  /* Vodafone KPI */
  static const campusGender = KPI._(displayName: 'Genere nel campus', technicalName: 'campus_gender', complex: true);
  static const neighborhoodGender = KPI._(displayName: 'Genere nel quartiere', technicalName: 'neighborhood_gender', complex: true);
  static const campusAge = KPI._(displayName: 'Età', technicalName: 'campus_age', complex: true);
  static const neighborhoodAge = KPI._(displayName: 'Età', technicalName: 'neighborhood_age', complex: true);
  static const campusAgeAverage = KPI._(displayName: 'Età', technicalName: 'campus_age_average', complex: false);
  static const neighborhoodAgeAverage = KPI._(displayName: 'Età', technicalName: 'neighborhood_age_average', complex: false);
  static const campusNationality = KPI._(displayName: 'Nazionalità nel campus', technicalName: 'campus_nationality', complex: true);
  static const neighborhoodNationality = KPI._(displayName: 'Nazionalità nel quartiere', technicalName: 'neighborhood_nationality', complex: true);
  static const campusForeigners = KPI._(displayName: 'Stranieri nel campus', technicalName: 'campus_foreigners', complex: false);
  static const neighborhoodForeigners = KPI._(displayName: 'Stranieri nel quartiere', technicalName: 'neighborhood_foreigners', complex: false);

  static const country = KPI._(displayName: 'Nazione', technicalName: 'country', complex: true);
  static const region = KPI._(displayName: 'Regione', technicalName: 'region', complex: true);
  static const province = KPI._(displayName: 'Provincia', technicalName: 'province', complex: true);
  static const municipality = KPI._(displayName: 'Città', technicalName: 'municipality', complex: true);
  static const homeDistance = KPI._(displayName: 'Distanza da casa', technicalName: 'home_distance', complex: true);
  static const workDistance = KPI._(displayName: 'Distanza da lavoro', technicalName: 'work_distance', complex: true);
  static const roomsOccupancy = KPI._(displayName: 'Occupazione aule', technicalName: 'rooms_occupancy', complex: true);

  static const na = KPI._(displayName: 'N/A', technicalName: '', complex: false);

  static const values = <KPI>[
    /* gender, nationality, */ country, region, province,
    municipality, homeDistance, workDistance, roomsOccupancy
  ];

  /* Series functions definitions */

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