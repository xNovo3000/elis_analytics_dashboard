import 'package:elis_analytics_dashboard/model/enum/gender.dart';
import 'package:flutter/material.dart';

class ComponentGenderBar extends StatelessWidget {

  const ComponentGenderBar({
    required this.data,
    this.height = 8
  });

  final Map<Gender, int> data;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var genderPair in data.entries)
          Expanded(
            flex: genderPair.value,
            child: Container(
              color: genderPair.key.color,
              height: height,
            ),
          ),
      ],
    );
  }

}
