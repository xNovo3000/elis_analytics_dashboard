import 'package:elis_analytics_dashboard/model/data/sensor_visits.dart';
import 'package:flutter/material.dart';

class FragmentRealtimeRoomsVisits extends StatelessWidget {

  const FragmentRealtimeRoomsVisits({
    required this.sensorData,
    this.scrollDirection = Axis.vertical,
  });

  final SensorVisits sensorData;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    // Get rooms data
    final roomsData = sensorData.roomsData;
    // Build UI
    return ListView.builder(
      key: PageStorageKey('FragmentDynamicRoomsList#ListView\$builder'),
      padding: EdgeInsets.symmetric(
        horizontal: scrollDirection == Axis.horizontal ? 12 : 0,
        vertical: scrollDirection == Axis.vertical ? 12 : 0,
      ),
      scrollDirection: scrollDirection,
      itemCount: roomsData.length,
      itemBuilder: (context, index) => SizedBox(
        width: scrollDirection == Axis.horizontal ? 200 : double.infinity,
        height: scrollDirection == Axis.vertical ? 160 : double.infinity,
        child: Card( // Height is 62 + image
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(4),
                child: Text('${roomsData[index].room}: ${roomsData[index].occupancy}'),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    image: AssetImage('asset/image/${roomsData[index].room.technicalName}.jpeg'),
                    errorBuilder: (context, _, __) => Container(
                      color: Colors.white,
                    ),
                    filterQuality: FilterQuality.medium,
                    fit: scrollDirection == Axis.horizontal ? BoxFit.fitWidth : BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
