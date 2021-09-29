import 'package:elis_analytics_dashboard/component/colored_app_bar.dart';
import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/error.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/wait.dart';
import 'package:elis_analytics_dashboard/component/modal/tile/error.dart';
import 'package:elis_analytics_dashboard/component/modal/tile/wait.dart';
import 'package:elis_analytics_dashboard/model/enum/kpi.dart';
import 'package:elis_analytics_dashboard/model/inherited/error.dart';
import 'package:elis_analytics_dashboard/model/inherited/weekly_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_icons/weather_icons.dart';

class ViewWeeklySmartphone extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Check for data
    final weeklyData = ModelInheritedWeeklyData.maybeOf(context);
    final error = ModelInheritedError.maybeOf(context);
    // Build UI
    return Scaffold(
      appBar: ColoredAppBar(
        title: Text('Visualizzazione settimanale'),
      ),
      body: weeklyData != null
        ? _ViewWeeklySmartphoneData(weekRange: (ModalRoute.of(context)!.settings.arguments as Map)['week'])
        : error != null
          ? ComponentModalFullscreenError(error: error.error)
          : ComponentModalFullscreenWait(),
    );
  }

}

class _ViewWeeklySmartphoneData extends StatelessWidget {

  static const _oneWeek = Duration(days: 7);
  static const _epsilonTime = Duration(seconds: 1);
  static final _minimumDate = DateTime(2021, 6, 28);
  static final _startDateResolver = DateFormat('d', 'it');
  static final _endDateResolver = DateFormat('d MMMM yyyy', 'it');
  static final _weatherDateResolver = DateFormat('EEEE d MMMM y', 'it');

  _ViewWeeklySmartphoneData({
    required this.weekRange,
  }) : super(key: ValueKey(weekRange));

  final DateTimeRange weekRange;
  final kpiHelperState = GlobalKey<_ViewWeeklySmartphoneDataKpiHelperState>();

  @override
  Widget build(BuildContext context) {
    // Retrieve data
    final weeklyData = ModelInheritedWeeklyData.of(context);
    // Build UI
    return ListView(
      key: PageStorageKey('_ViewWeeklySmartphoneDataList'),
      children: [
        ListTile(
          title: Text('${_startDateResolver.format(weekRange.start)}-${_endDateResolver.format(weekRange.end.subtract(_epsilonTime))}'),
          // subtitle: const Text('Settimana'),
          trailing: Wrap(
            children: [
              if (_canGoBackwardInTime) IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).popAndPushNamed(
                  '/weekly',
                  arguments: {'week': DateTimeRange(
                    start: weekRange.start.subtract(_oneWeek),
                    end: weekRange.end.subtract(_oneWeek),
                  )}
                ),
              ),
              if (_canGoForwardInTime) IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => Navigator.of(context).popAndPushNamed(
                  '/weekly',
                  arguments: {'week': DateTimeRange(
                    start: weekRange.start.add(_oneWeek),
                    end: weekRange.end.add(_oneWeek),
                  )}
                ),
              ),
            ],
          ),
        ),
        Divider(indent: 8, endIndent: 8),
        ListTile(
          title: Text(
            'RAPPORTO METEO',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)
          ),
        ),
        for (var weather in weeklyData.weathers)
          ListTile(
            leading: BoxedIcon(weather.icon),
            title: Text('${weather.ambientTemperatureMin.floor()}°C / ${weather.ambientTemperatureMax.floor()}°C'),
            subtitle: Text(_weatherDateResolver.format(weather.timestamp)),
          ),
        Divider(indent: 8, endIndent: 8),
      ],
    );
  }

  bool get _canGoBackwardInTime => weekRange.start.subtract(_oneWeek).isAfter(_minimumDate);
  bool get _canGoForwardInTime => weekRange.end.add(_oneWeek).isBefore(DateTime.now());

}

/* SPLITTING WIDGETS IS ALWAYS USEFUL */
class _ViewWeeklySmartphoneDataKpiHelper extends StatefulWidget {

  const _ViewWeeklySmartphoneDataKpiHelper({
    Key? key,
  }) : super(key: key);

  @override
  _ViewWeeklySmartphoneDataKpiHelperState createState() => _ViewWeeklySmartphoneDataKpiHelperState();

}

class _ViewWeeklySmartphoneDataKpiHelperState extends State<_ViewWeeklySmartphoneDataKpiHelper> {

  @override
  Widget build(BuildContext context) {
    return ComponentManagedFutureBuilder<List<String>>(
      future: _getKpisToShow(),
      onSuccess: (context, data) => _ViewWeeklySmartphoneDataKpiShower(stringKpis: data),
      onWait: (context) => ComponentModalTileWait(message: 'Costruisco i KPI'),
      onError: (context, error) => ComponentModalTileError(error: '$error'),
    );
  }

  Future<List<String>> _getKpisToShow() async =>
    (await SharedPreferences.getInstance()).getStringList('KPIs') ?? [];

  Future<void> addKpi(KPI kpi) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final kpis = await _getKpisToShow();
    if (!kpis.contains(kpi.technicalName)) {
      kpis.add(kpi.technicalName);
      await sharedPreferences.setStringList('KPIs', kpis);
      setState(() => null);
    }
  }

  Future<void> removeKpi(KPI kpi) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final kpis = await _getKpisToShow();
    if (kpis.contains(kpi.technicalName)) {
      kpis.remove(kpi.technicalName);
      await sharedPreferences.setStringList('KPIs', kpis);
      setState(() => null);
    }
  }

}

class _ViewWeeklySmartphoneDataKpiShower extends StatelessWidget {

  const _ViewWeeklySmartphoneDataKpiShower({
    required this.stringKpis,
  });

  final List<String> stringKpis;

  @override
  Widget build(BuildContext context) {
    // Retrieve data
    final weeklyData = ModelInheritedWeeklyData.of(context);
    // Get real KPIs
    final kpis = <KPI>[];
    stringKpis.forEach((stringKpi) => kpis.add(KPI.fromTechnicalName(stringKpi)));
    // Build UI
    return Column(
      children: [
        for (KPI kpi in kpis)
          Column(
            children: [
              ListTile(
                subtitle: Text('$kpi'),
              ),
              SizedBox(
                width: double.infinity, height: MediaQuery.of(context).size.height / 2.2,
                child: SfCartesianChart(
                  margin: EdgeInsets.all(8),
                  primaryXAxis: CategoryAxis(),
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    overflowMode: LegendItemOverflowMode.scroll,
                  ),
                  series: _getSeriesDataFromKPI(weeklyData, kpi),
                ),
              ),
            ],
          ),
      ],
    );
  }

  List _getSeriesDataFromKPI(ModelInheritedWeeklyData data, KPI kpi) {
    if (kpi == KPI.roomsOccupancy) {
      return kpi.series(data.sensors);
    } else {  // TODO: split indoor and outdoors -> duplicate Vodafone KPIs
      return kpi.series(data.campusVodafone);
    }
  }

}

