import 'package:elis_analytics_dashboard/model/data/sensor.dart';
import 'package:flutter/material.dart';

class FragmentDynamicRoomsList extends StatelessWidget {

  const FragmentDynamicRoomsList({
    required this.sensorData,
    this.scrollDirection = Axis.vertical,
  });

  final SensorData sensorData;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    // Get rooms data
    final roomsData = sensorData.roomsData.where((roomData) => !roomData.room.standing);
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
        width: scrollDirection == Axis.vertical ? 200 : double.infinity,
        height: scrollDirection == Axis.horizontal ? 160 : double.infinity,
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
                child: Text('${roomsData.elementAt(index).room}'),
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
                  '${roomsData.elementAt(index).occupancy}/${roomsData.elementAt(index).room.capacity}'
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
