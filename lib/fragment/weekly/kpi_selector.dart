import 'package:elis_analytics_dashboard/model/enum/kpi.dart';
import 'package:flutter/material.dart';

class FragmentWeeklyKpiSelector extends StatelessWidget {

  const FragmentWeeklyKpiSelector({
    this.firstSelected,
  });

  final KPI? firstSelected;

  @override
  Widget build(BuildContext context) {
    // Build list of selectable kpis
    final selectable = KPI.values  // Remove complex KPIs if second or blacklisted in the first place
      .where((kpi) => firstSelected != null ? (!kpi.isComplex && !KPI.blacklist[firstSelected]!.contains(kpi)) : true);
    // Build UI
    return SimpleDialog(
      title: Text('Seleziona il ${firstSelected != null ? 'secondo' : 'primo'} dato'),
      children: [
        for (KPI kpi in selectable)
          SimpleDialogOption(
            child: Text('$kpi'),
            onPressed: () => Navigator.of(context).pop(kpi),
          ),
      ],
    );
  }

}
