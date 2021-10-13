import 'package:flutter/material.dart';

class ViewWait extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 4),
          Text('I dati stanno arrivando. Attendi.'),
        ],
      ),
    );
  }

}