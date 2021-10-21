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
      widget.preferences.remove("FirstKPI");
      widget.preferences.remove("SecondKPI");
      first = KPI.campusGender;
      second = KPI.campusForeigners;
    } finally {
      // Flutter initState
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}
