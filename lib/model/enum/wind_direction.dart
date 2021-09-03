// enum
class WindDirection {

  factory WindDirection.fromDegrees(double degrees) {
    // normalize degrees
    while (degrees > 360) degrees -= 360;
    while (degrees < 0) degrees += 360;
    // check direction
    switch ((degrees / 22.5).floor()) {
      case 0: case 15: return north;
      case 1: case 2: return northEast;
      case 3: case 4: return east;
      case 5: case 6: return southEast;
      case 7: case 8: return south;
      case 9: case 10: return southWest;
      case 11: case 12: return west;
      case 13: case 14: return northWest;
      default: return north;
    }
  }

  const WindDirection._({
    required this.name,
    required this.degrees,
  });

  final String name;
  final int degrees;

  @override String toString() => name;

  // instances
  static const WindDirection north = WindDirection._(name: 'N', degrees: 0);
  static const WindDirection south = WindDirection._(name: 'S', degrees: 180);
  static const WindDirection east = WindDirection._(name: 'E', degrees: 90);
  static const WindDirection west = WindDirection._(name: 'W', degrees: 270);
  static const WindDirection northEast = WindDirection._(name: 'NE', degrees: 45);
  static const WindDirection northWest = WindDirection._(name: 'NW', degrees: 315);
  static const WindDirection southEast = WindDirection._(name: 'SE', degrees: 135);
  static const WindDirection southWest = WindDirection._(name: 'SW', degrees: 225);

  // recursive enumeration
  static const List<WindDirection> values = const <WindDirection>[
    north, northEast, east, southEast, south, southWest, west, northWest
  ];

}