import 'package:elis_analytics_dashboard/model/data/sensor_visits.dart';
import 'package:flutter/material.dart';

class FragmentRealtimeDynamicRoomsList extends StatelessWidget {

  const FragmentRealtimeDynamicRoomsList({
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
                child: Text('${roomsData[index].room}'),
              ),
              // TODO: add image here
              Expanded(
                child: Container(
                  color: Colors.blue[100],
                ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  '${roomsData[index].occupancy}/${roomsData[index].room.capacity}'
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
