import 'package:flutter/material.dart';

class ViewTest extends StatelessWidget {

  const ViewTest({
    required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    // Build
    return Scaffold(
      appBar: AppBar(
        title: const Text('TEST'),
      ),
      body: body,
    );
  }

}
