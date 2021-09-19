import 'dart:math';

import 'package:elis_analytics_dashboard/model/enum/age.dart';
import 'package:elis_analytics_dashboard/model/enum/distance.dart';
import 'package:elis_analytics_dashboard/model/enum/gender.dart';
import 'package:elis_analytics_dashboard/model/enum/nationality.dart';
import 'package:elis_analytics_dashboard/model/enum/region.dart';

class VodafoneCluster implements Comparable<VodafoneCluster> {

  factory VodafoneCluster.test() {
    final random = Random();
    return VodafoneCluster(
      gender: Gender.values[random.nextInt(3)],
      age: Age.values[random.nextInt(7)],
      nationality: Nationality.values[random.nextInt(2)],
      country: 'ITALIA',
      region: Region.values[random.nextInt(21)],
      province: 'ROMA',
      municipality: ['ROMA', 'LATINA', 'FROSINONE', 'RIETI', 'VITERBO'][random.nextInt(5)],
      homeDistance: Distance.values[random.nextInt(7)],
      workDistance: Distance.values[random.nextInt(7)],
      visits: random.nextInt(50) + 400,
      visitors: random.nextInt(50) + 200,
      totalDwellTime: Duration(minutes: random.nextInt(55) + 5),
    );
  }

  factory VodafoneCluster.fromMap(final Map<String, dynamic> map) => VodafoneCluster(
    gender: Gender.fromTechnicalName(map['gender']),
    age: Age.fromTechnicalName(map['age']),
    nationality: Nationality.fromTechnicalName(map['nationality']),
    country: map['country'],
    region: Region.fromTechnicalName(map['region']),
    province: map['province'],
    municipality: map['municipality'],
    homeDistance: Distance.fromTechnicalName(map['homeDistance']),
    workDistance: Distance.fromTechnicalName(map['workDistance']),
    visits: map['visits'],
    visitors: map['visitors'],
    totalDwellTime: Duration(seconds: map['totalDwellTime']),
  );

  const VodafoneCluster({
    required this.gender,
    required this.age,
    required this.nationality,
    required this.country,
    required this.region,
    required this.province,
    required this.municipality,
    required this.homeDistance,
    required this.workDistance,
    required this.visits,
    required this.visitors,
    required this.totalDwellTime,
  });

  const VodafoneCluster.empty({
    this.gender = Gender.na,
    this.age = Age.na,
    this.nationality = Nationality.na,
    this.country = '',
    this.region = Region.na,
    this.province = '',
    this.municipality = '',
    this.homeDistance = Distance.na,
    this.workDistance = Distance.na,
    this.visits = 0,
    this.visitors = 0,
    this.totalDwellTime = const Duration(seconds: 0),
  });

  const VodafoneCluster.other({
    this.gender = Gender.other,
    this.age = Age.other,
    this.nationality = Nationality.other,
    this.country = 'Altro',
    this.region = Region.other,
    this.province = 'Altro',
    this.municipality = 'Altro',
    this.homeDistance = Distance.other,
    this.workDistance = Distance.other,
    this.visits = 0,
    this.visitors = 0,
    this.totalDwellTime = const Duration(seconds: 0),
  });

  final Gender gender;
  final Age age;
  final Nationality nationality;
  final String country;
  final Region region;
  final String province;
  final String municipality;
  final Distance homeDistance;
  final Distance workDistance;
  final int visits;
  final int visitors;
  final Duration totalDwellTime;

  VodafoneCluster operator +(VodafoneCluster other) => VodafoneCluster(
    gender: gender,
    age: age,
    nationality: nationality,
    country: country,
    region: region,
    province: province,
    municipality: municipality,
    homeDistance: homeDistance,
    workDistance: workDistance,
    visits: visits + other.visits,
    visitors: visitors + other.visitors,
    totalDwellTime: totalDwellTime + other.totalDwellTime
  );

  @override
  String toString() =>
    'VodafoneCluster('
    'gender: $gender, '
    'age: $age, '
    'nationality: $nationality, '
    'country: $country, '
    'region: $region, '
    'province: $province, '
    'municipality: $municipality, '
    'homeDistance: $homeDistance, '
    'workDistance: $workDistance, '
    'visits: $visits, '
    'visitors: $visitors, '
    'totalDwellTime: $totalDwellTime, '
    ')';

  @override
  bool operator ==(Object other) =>
    other is VodafoneCluster
      ? gender == other.gender &&
        age == other.age &&
        nationality == other.nationality &&
        country == other.country &&
        region == other.region &&
        province == other.province &&
        municipality == other.municipality &&
        homeDistance == other.homeDistance &&
        workDistance == other.workDistance &&
        visits == other.visits &&
        visitors == other.visitors &&
        totalDwellTime == other.totalDwellTime
      : false;

  @override int get hashCode =>
    gender.hashCode +
    age.hashCode +
    nationality.hashCode +
    country.hashCode +
    region.hashCode +
    province.hashCode +
    municipality.hashCode +
    homeDistance.hashCode +
    workDistance.hashCode +
    visits.hashCode +
    visitors.hashCode +
    totalDwellTime.hashCode;

  @override
  int compareTo(VodafoneCluster other) => other.visitors.compareTo(visitors);

}