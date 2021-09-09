import 'package:flutter/material.dart';

class ViewError extends StatelessWidget {

  const ViewError({
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Icon(Icons.error, color: Theme.of(context).errorColor),
          SizedBox(height: 4),
          Text(error, maxLines: null),
        ],
      ),
    );
  }

}
