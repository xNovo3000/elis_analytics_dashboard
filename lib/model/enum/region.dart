// enum
class Region {

  factory Region.fromTechnicalName(final String? technicalName) =>
    values.singleWhere((element) => technicalName == element.technicalName, orElse: () => na);

  const Region._({
    required this.name,
    required this.technicalName
  });

  final String name;
  final String technicalName;

  @override String toString() => name;

  // instances
  static const Region abruzzo = Region._(name: 'Abruzzo', technicalName: 'ABRUZZO');
  static const Region basilicata = Region._(name: 'Basilicata', technicalName: 'BASILICATA');
  static const Region calabria = Region._(name: 'Calabria', technicalName: 'CALABRIA');
  static const Region campania = Region._(name: 'Campania', technicalName: 'CAMPANIA');
  static const Region emiliaRomagna = Region._(name: 'Emilia-Romagna', technicalName: 'EMILIA-ROMAGNA');
  static const Region friuliVeneziaGiulia = Region._(name: 'Friuli-Venezia Giulia', technicalName: 'FRIULI-VENEZIA GIULIA');
  static const Region lazio = Region._(name: 'Lazio', technicalName: 'LAZIO');
  static const Region liguria = Region._(name: 'Liguria', technicalName: 'LIGURIA');
  static const Region lombardia = Region._(name: 'Lombardia', technicalName: 'LOMBARDIA');
  static const Region marche = Region._(name: 'Marche', technicalName: 'MARCHE');
  static const Region molise = Region._(name: 'Molise', technicalName: 'MOLISE');
  static const Region piemonte = Region._(name: 'Piemonte', technicalName: 'PIEMONTE');
  static const Region puglia = Region._(name: 'Puglia', technicalName: 'PUGLIA');
  static const Region sardegna = Region._(name: 'Sardegna', technicalName: 'SARDEGNA');
  static const Region sicilia = Region._(name: 'Sicilia', technicalName: 'SICILIA');
  static const Region toscana = Region._(name: 'Toscana', technicalName: 'TOSCANA');
  static const Region trentinoAltoAdige = Region._(name: 'Trentino-Alto Adige', technicalName: 'TRENTINO-ALTO ADIGE/SUDTIROL');
  static const Region umbria = Region._(name: 'Umbria', technicalName: 'UMBRIA');
  static const Region valleAosta = Region._(name: 'Valle d\'Aosta', technicalName: 'VALLE D\'AOSTA/VALLE\'E D\'AOSTE');
  static const Region veneto = Region._(name: 'Veneto', technicalName: 'VENETO');
  static const Region na = Region._(name: 'N/A', technicalName: '');

  // recursive enumeration
  static const List<Region> values = const <Region>[
    abruzzo, basilicata, calabria, campania, emiliaRomagna, friuliVeneziaGiulia,
    lazio, liguria, lombardia, marche, molise, piemonte, puglia, sardegna,
    sicilia, toscana, trentinoAltoAdige, umbria, valleAosta, veneto, na
  ];

}