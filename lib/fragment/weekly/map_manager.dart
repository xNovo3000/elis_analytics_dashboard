import 'package:elis_analytics_dashboard/foundation/utils.dart';
import 'package:elis_analytics_dashboard/fragment/map.dart';
import 'package:elis_analytics_dashboard/model/container/vodafone_daily.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FragmentWeeklyMapManager extends StatefulWidget {
  
  const FragmentWeeklyMapManager({
    required this.preferences,
    required this.campusVodafoneByRegion,
    required this.neighborhoodVodafoneByRegion,
  });

  final SharedPreferences preferences;
  final VodafoneDaily campusVodafoneByRegion;
  final VodafoneDaily neighborhoodVodafoneByRegion;

  @override
  _FragmentWeeklyMapManagerState createState() => _FragmentWeeklyMapManagerState();
  
}

class _FragmentWeeklyMapManagerState extends State<FragmentWeeklyMapManager> {
  
  late bool _isNeighborhood;
  
  @override
  void initState() {
    try {
      _isNeighborhood = widget.preferences.getBool('WeeklyMapViewSelector')!;
    } catch (_) {
      widget.preferences.remove('WeeklyMapViewSelector');
      _isNeighborhood = false;
    } finally {
      super.initState();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'PROVENIENZE DAL ${_isNeighborhood ? 'QUARTIERE' : 'CAMPUS'}',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          trailing: Switch(
            value: _isNeighborhood,
            onChanged: _onChanged,
          ),
        ),
        SizedBox(
          width: double.infinity, height: MediaQuery.of(context).size.height / 1.5,
          child: FragmentMap(
            mapShapeSource: Utils.generateMapShapeSourceFromVodafoneRegionData(
              _isNeighborhood ? widget.neighborhoodVodafoneByRegion : widget.campusVodafoneByRegion
            ),
            canZoomPan: false,
          ),
        ),
      ],
    );
  }
  
  void _onChanged(bool? value) {
    setState(() => _isNeighborhood = value ?? false);
    widget.preferences.setBool('WeeklyMapViewSelector', _isNeighborhood);
  }
  
}
