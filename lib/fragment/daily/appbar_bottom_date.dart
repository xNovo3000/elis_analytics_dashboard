import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FragmentDailyAppbarBottomDate extends StatelessWidget implements PreferredSizeWidget {

  static final _dateResolver = DateFormat('EEEE d MMMM y', 'it');
  static const _oneDay = Duration(days: 1);
  static final _minimumDate = DateTime(2021, 6, 28);

  const FragmentDailyAppbarBottomDate({
    required this.day,
  });

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_dateResolver.format(day)),
      trailing: Wrap(
        children: [
          if (_canGoBackwardInTime) IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _onDatePreviousPressed(context),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _onDateSelectPressed(context),
          ),
          if (_canGoForwardInTime) IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => _onDateForwardPressed(context),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);

  Future<void> _onDateSelectPressed(BuildContext context) async {
    // Generate lastDate
    final now = DateTime.now();
    final lastDate = DateTime(now.year, now.month, now.day).subtract(_oneDay);
    // Show DatePicker
    DateTime? chosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2021, 6, 28),
      initialDate: day,
      lastDate: lastDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    // Go to specific date if present
    if (chosenDate != null) {
      Navigator.popAndPushNamed(context, '/daily', arguments: {'day': chosenDate});
    }
  }

  void _onDatePreviousPressed(BuildContext context) {
    Navigator.of(context).popAndPushNamed('/daily', arguments: {'day': day.subtract(_oneDay)});
  }

  void _onDateForwardPressed(BuildContext context) {
    Navigator.of(context).popAndPushNamed('/daily', arguments: {'day': day.add(_oneDay)});
  }

  bool get _canGoBackwardInTime => day.isAfter(_minimumDate);
  bool get _canGoForwardInTime => day.add(_oneDay).isBefore(DateTime.now().subtract(_oneDay));

}
