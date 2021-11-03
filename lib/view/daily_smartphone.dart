import 'package:elis_analytics_dashboard/component/colored_app_bar.dart';
import 'package:elis_analytics_dashboard/foundation/utils.dart';
import 'package:elis_analytics_dashboard/fragment/daily/appbar_bottom_date.dart';
import 'package:elis_analytics_dashboard/fragment/daily/gender_chart.dart';
import 'package:elis_analytics_dashboard/fragment/daily/municipality_chart.dart';
import 'package:elis_analytics_dashboard/fragment/daily/region_chart_smartphone.dart';
import 'package:elis_analytics_dashboard/fragment/daily/rooms_occupation_attendance.dart';
import 'package:elis_analytics_dashboard/fragment/daily/rooms_occupation_visits.dart';
import 'package:elis_analytics_dashboard/fragment/daily/vodafone_summary.dart';
import 'package:elis_analytics_dashboard/fragment/daily/weather_report_smartphone.dart';
import 'package:elis_analytics_dashboard/fragment/info.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:elis_analytics_dashboard/model/data/vodafone_cluster.dart';
import 'package:elis_analytics_dashboard/model/enum/region.dart';
import 'package:elis_analytics_dashboard/model/inherited/daily_data.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/view/error.dart';
import 'package:elis_analytics_dashboard/view/wait.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class ViewDailySmartphone extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check if has error
    final error = ModelInheritedError.maybeOf(context);
    if (error != null) {
      return _ViewDailySmartphoneError(
        error: error.error,
      );
    }
    // Get day
    final day = (ModalRoute.of(context)!.settings.arguments as Map)['day'];
    // Check if has data
    final data = ModelInheritedDailyData.maybeOf(context);
    // Build UI
    return Scaffold(
      appBar: ColoredAppBar(
        title: Text('Visualizzazione giornaliera'),
        bottom: FragmentDailyAppbarBottomDate(
          day: day,
        ),
      ),
      body: data != null
        ? _ViewDailySmartphoneData()
        : ViewWait(),
    );
  }

}

class _ViewDailySmartphoneError extends StatelessWidget {

  const _ViewDailySmartphoneError({
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ColoredAppBar(
        title: Text('Visualizzazione giornaliera'),
      ),
      body: ViewError(
        error: error,
      ),
    );
  }

}

class _ViewDailySmartphoneData extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check data
    final data = ModelInheritedDailyData.of(context);
    // Build UI
    return CustomScrollView(
      key: PageStorageKey('_ViewDailySmartphoneDataCustomScrollView'),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              ListTile(
                title: Text('RAPPORTO METEO', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              ),
              FragmentDailyWeatherReportSmartphone(
                weathers: data.weathers,
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Divider(indent: 8, endIndent: 8, height: 1, thickness: 1),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              ListTile(
                title: Text('OCCUPAZIONE AULE', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              ),
              FragmentDailyRoomsOccupationAttendance(
                sensors: data.attendance,
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              ListTile(
                title: Text('OCCUPAZIONE ZONE DI TRANSITO', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              ),
              FragmentDailyRoomsOccupationVisits(
                sensors: data.visits,
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Divider(indent: 8, endIndent: 8, height: 1, thickness: 1),
        ),
        SliverToBoxAdapter(
          child: data.hasVodafone ? _ComponentVodafoneDataExists(
            campusVodafone: data.campusVodafone!,
            neighborhoodVodafone: data.neighborhoodVodafone!,
          ) : FragmentInfo(
            message: 'Alcuni dati devono ancora essere elaborati',
          ),
        ),
      ],
    );
  }

}

class _ComponentVodafoneDataExists extends StatelessWidget {

  const _ComponentVodafoneDataExists({
    required this.campusVodafone,
    required this.neighborhoodVodafone,
  });

  final VodafoneDaily campusVodafone;
  final VodafoneDaily neighborhoodVodafone;

  @override
  Widget build(BuildContext context) {
    // Cache
    final neighborhoodVodafoneByRegion = neighborhoodVodafone.collapse(VodafoneClusterAttribute.region, collapseNa: true);
    final campusVodafoneByMunicipality = campusVodafone.collapse(VodafoneClusterAttribute.municipality, collapseNa: true);
    // Build UI
    return Column(
      children: [
        ListTile(
          title: Text('REGIONI DI PROVENIENZA NEL QUARTIERE', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () => Utils.onRegionOriginMapClick(context, neighborhoodVodafoneByRegion),
          ),
        ),
        FragmentDailyRegionChartSmartphone(
          neighborhoodVodafoneByRegion: neighborhoodVodafoneByRegion.collapse(VodafoneClusterAttribute.region, maxClusters: 5),
        ),
        ListTile(
          title: Text('CITTÀ DI PROVENIENZA NEL CAMPUS', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
        FragmentDailyMunicipalityChart(
            campusVodafoneByMunicipality: campusVodafoneByMunicipality.collapse(VodafoneClusterAttribute.municipality, maxClusters: 7),
        ),
        ListTile(
          title: Text('RIASSUNTO GIORNALIERO', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
        FragmentDailyVodafoneSummary(
          campusVodafone: campusVodafone,
          neighborhoodVodafone: neighborhoodVodafone
        ),
        ListTile(
          title: Text('SUDDIVISIONE PER GENERE', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ),
        FragmentDailyGenderChart(
          campusVodafoneByGender: campusVodafone.collapse(VodafoneClusterAttribute.gender, collapseNa: true),
        ),
      ],
    );
  }

}
