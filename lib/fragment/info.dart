import 'package:flutter/material.dart';

class FragmentInfo extends StatelessWidget {

  const FragmentInfo({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.error),
      title: Text(message),
    );
  }

}
