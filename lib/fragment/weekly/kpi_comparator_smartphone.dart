import 'package:elis_analytics_dashboard/fragment/weekly/kpi_comparator_visualizer.dart';
import 'package:elis_analytics_dashboard/fragment/weekly/kpi_selector.dart';
import 'package:elis_analytics_dashboard/model/enum/kpi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FragmentWeeklyKpiComparatorSmartphone extends StatefulWidget {

  const FragmentWeeklyKpiComparatorSmartphone({
    required this.preferences,
  });

  final SharedPreferences preferences;

  @override
  _FragmentWeeklyKpiComparatorSmartphoneState createState() => _FragmentWeeklyKpiComparatorSmartphoneState();

}

class _FragmentWeeklyKpiComparatorSmartphoneState extends State<FragmentWeeklyKpiComparatorSmartphone> {

  late KPI first;
  late KPI second;

  @override
  void initState() {
    try {
      // Get first and second KPI
      first = KPI.fromTechnicalName(widget.preferences.getString("FirstKPI")!);
      second = KPI.fromTechnicalName(widget.preferences.getString("SecondKPI")!);
    } catch (e) {
      // Remove strings for security reasons
      widget.preferences.remove("FirstKPI");
      widget.preferences.remove("SecondKPI");
      // Fallback
      first = KPI.campusGender;
      second = KPI.campusForeigners;
    } finally {
      // Flutter initState
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('VISUALIZZA DATI', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          subtitle: Text('$first e $second'),
          trailing: IconButton(
            icon: Icon(Icons.swap_horiz),
            onPressed: _onKpiChange,
          ),
        ),
        SizedBox(
          width: double.infinity, height: MediaQuery.of(context).size.height / 2,
          child: FragmentWeeklyKpiComparatorVisualizer(
            first: first,
            second: second,
          ),
        ),
      ],
    );
  }

  Future<void> _onKpiChange() async {
    // Select first kpi
    final firstKpi = await showDialog<KPI>(
      context: context,
      builder: (context) => FragmentWeeklyKpiSelector(),
    );
    if (firstKpi == null) {
      return;
    }
    // Select second kpi
    final secondKpi = await showDialog<KPI>(
      context: context,
      builder: (context) => FragmentWeeklyKpiSelector(
        firstSelected: firstKpi,
      ),
    );
    if (secondKpi == null) {
      return;
    }
    // Save in the preferences
    await widget.preferences.setString('FirstKPI', firstKpi.technicalName);
    await widget.preferences.setString('SecondKPI', secondKpi.technicalName);
    // Load inside first and second
    setState(() {
      first = firstKpi;
      second = secondKpi;
    });
  }

}
