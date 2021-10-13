import 'package:flutter/material.dart';

class ViewError extends StatelessWidget {

  const ViewError({
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 48),
          SizedBox(height: 4),
          Text(error, maxLines: null),
        ],
      ),
    );
  }

}
