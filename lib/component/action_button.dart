import 'package:flutter/material.dart';

class ComponentActionButton extends StatefulWidget {

  const ComponentActionButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final Future<void> Function() onPressed;

  @override
  _ComponentActionButtonState createState() => _ComponentActionButtonState();

}

class _ComponentActionButtonState extends State<ComponentActionButton> {

  bool _isActing = false;

  @override
  Widget build(BuildContext context) {
    return _isActing
        ? ElevatedButton.icon(
      label: Text(widget.label),
      icon: const SizedBox(
        width: 20.0,
        height: 20.0,
        child: const CircularProgressIndicator(),
      ),
      onPressed: null,
    )
        : ElevatedButton(
      child: Text(widget.label),
      onPressed: _onActionPressed,
    );
  }

  Future<void> _onActionPressed() async {
    setState(() => _isActing = true);
    await widget.onPressed();
    setState(() => _isActing = false);
  }

}
