import 'package:elis_analytics_dashboard/component/managed_future_builder.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/error.dart';
import 'package:elis_analytics_dashboard/component/modal/fullscreen/wait.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily_list.dart';
import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:elis_analytics_dashboard/model/data/weather_daily.dart';
import 'package:elis_analytics_dashboard/model/enum/kpi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ComponentKpiComparator extends StatefulWidget {

  const ComponentKpiComparator({
    required this.weathers,
    required this.sensors,
    required this.campusVodafone,
    required this.neighborhoodVodafone,
  });

  final List<WeatherDaily> weathers;
  final List<SensorData> sensors;
  final VodafoneDailyList campusVodafone;
  final VodafoneDailyList neighborhoodVodafone;

  @override
  ComponentKpiComparatorState createState() => ComponentKpiComparatorState();

}

class ComponentKpiComparatorState extends State<ComponentKpiComparator> {

  var first = KPI.na;
  var second = KPI.na;

  @override
  void initState() {
    // Init Flutter state
    super.initState();
    // Load async KPIs
    _loadKPIs();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('COMPARA', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          subtitle: Text('Stai comparando "$first" e "$second"'),
          trailing: IconButton(
            icon: Icon(Icons.swap_horiz),
            onPressed: () => _onChangeKpiPressed(context),
          ),
        ),
        ComponentManagedFutureBuilder<Map<String, dynamic>>(
          future: _generateKpiData(),
          onSuccess: (context, data) => SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(),
            axes: [
              NumericAxis(
                majorGridLines: MajorGridLines(width: 0),
                opposedPosition: true,
              ),
            ],
            legend: Legend(
              isVisible: true,
              position: LegendPosition.bottom,
            ),
            series: <ChartSeries>[]
              ..addAll(data['first_kpi_series'])
              ..addAll(data['second_kpi_series']),
          ),
          onWait: (context) => ComponentModalFullscreenWait(),
          onError: (context, error) => ComponentModalFullscreenError(error: '$error'),
        ),
      ],
    );
  }

  Future<void> _loadKPIs() async {
    // Temp KPIs
    late KPI functionFirst;
    late KPI functionSecond;
    // Get KPIs from preferences (after this block will always exists and will be always valid)
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      functionFirst = KPI.fromTechnicalName(preferences.getString('FirstKPI')!);
      functionSecond = KPI.fromTechnicalName(preferences.getString('SecondKPI')!);
      // Cannot be complex
      if (functionSecond.complex) {
        throw Exception();
      }
    } catch (e) {
      functionFirst = KPI.age;
      functionSecond = KPI.country;
      await preferences.setString('FirstKPI', functionFirst.technicalName);
      await preferences.setString('SecondKPI', functionSecond.technicalName); // TODO: add simple KPI
    }
    setState(() {
      first = functionFirst;
      second = functionSecond;
    });
  }

  Future<void> _onChangeKpiPressed(BuildContext context) async {
    KPI? functionFirst = await showDialog(
      context: context,
      builder: (context) => _ComponentDialogKpiChooser(
        title: 'Seleziona la prima visualizzazione',
        selectableKpis: List.of(KPI.values, growable: false),  // Shallow copy
      ),
    );
    if (functionFirst == null) {
      return;
    }
    KPI? functionSecond = await showDialog(
      context: context,
      builder: (context) => _ComponentDialogKpiChooser(
        title: 'Seleziona la seconda visualizzazione',
        selectableKpis: List.of(KPI.values.where((kpi) => kpi != functionFirst && !kpi.complex)),
      ),
    );
    if (functionSecond == null) {
      return;
    }
    // Both first and second KPI exists
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('FirstKPI', functionFirst.technicalName);
    await preferences.setString('SecondKPI', functionSecond.technicalName);
    // Set the new KPIs
    setState(() {
      first = functionFirst;
      second = functionSecond;
    });
  }

  Future<Map<String, dynamic>> _generateKpiData() async {
    return {};
  }

  List<ChartSeries> _getFromKpi(final KPI kpi, {bool simple = true}) {
    switch (kpi.assignation) {
      case KpiAssignation.weather:
        return kpi.series(widget.weathers, simple: simple);
      case KpiAssignation.sensor:
        return kpi.series(widget.sensors, simple: simple);
      case KpiAssignation.crowdCell:
        return kpi.series(widget.campusVodafone, simple: simple);
      case KpiAssignation.cell:
        return kpi.series(widget.neighborhoodVodafone, simple: simple);
      case KpiAssignation.na:
        return kpi.series([], simple: simple);
    }
  }

}

class _ComponentDialogKpiChooser extends StatelessWidget {

  _ComponentDialogKpiChooser({
    required this.title,
    required this.selectableKpis,
  });

  final String title;
  final List<KPI> selectableKpis;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title),
      children: [
        for (var kpi in selectableKpis)
          SimpleDialogOption(
            child: Text('$kpi'),
            onPressed: () => Navigator.of(context).pop(kpi),
          ),
      ],
    );
  }

}
