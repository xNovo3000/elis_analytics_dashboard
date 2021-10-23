// enum
import 'package:elis_analytics_dashboard/model/enum/thingsboard_device.dart';

class Area {

  factory Area.fromTechnicalName(final String? technicalName) =>
    values.singleWhere(
      (element) => technicalName == element.technicalName,
      orElse: () => na
    );

  const Area._({
    required this.name,
    required this.technicalName,
    required this.device,
  });

  final String name;
  final String technicalName;
  final ThingsboardDevice device;

  @override String toString() => name;

  // instances
  static const Area campus = Area._(name: 'Campus', technicalName: 'INDOOR', device: ThingsboardDevice.vodafoneCampus);
  static const Area neighborhood = Area._(name: 'Quartiere', technicalName: 'OUTDOOR', device: ThingsboardDevice.vodafoneNeighborhood);
  static const Area na = Area._(name: 'N/A', technicalName: '', device: ThingsboardDevice.na);

  // recursive enumeration
  static const List<Area> values = const <Area>[campus, neighborhood, na];

}