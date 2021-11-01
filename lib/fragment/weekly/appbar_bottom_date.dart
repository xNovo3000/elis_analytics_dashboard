import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FragmentWeeklyAppbarBottomDate extends StatelessWidget implements PreferredSizeWidget {

  static const _oneSecond = Duration(seconds: 1);
  static const _oneWeek = Duration(days: 7);
  static final _minimumWeek = DateTimeRange(start: DateTime(2021, 06, 21), end: DateTime(2021, 06, 28));
  static final _weekStartResolver = DateFormat('d', 'it');
  static final _weekEndResolver = DateFormat('d MMMM yyyy', 'it');

  const FragmentWeeklyAppbarBottomDate({
    required this.weekRange,
    required this.lastAvailableWeekRange,
  });

  final DateTimeRange weekRange;
  final DateTimeRange lastAvailableWeekRange;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${_weekStartResolver.format(weekRange.start)} - ${_weekEndResolver.format(weekRange.end.subtract(_oneSecond))}'),
      trailing: Wrap(
        children: [
          if (_canGoBackwardInTime) IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _onDatePreviousPressed(context),
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

  void _onDatePreviousPressed(BuildContext context) {
    Navigator.of(context).popAndPushNamed('/weekly', arguments: {
      'week': DateTimeRange(
        start: weekRange.start.subtract(_oneWeek),
        end: weekRange.end.subtract(_oneWeek),
      ),
      'last_available_week': lastAvailableWeekRange,
    });
  }

  void _onDateForwardPressed(BuildContext context) {
    Navigator.of(context).popAndPushNamed('/weekly', arguments: {
      'week': DateTimeRange(
        start: weekRange.start.add(_oneWeek),
        end: weekRange.end.add(_oneWeek),
      ),
      'last_available_week': lastAvailableWeekRange,
    });
  }

  bool get _canGoBackwardInTime => weekRange != _minimumWeek;
  bool get _canGoForwardInTime => weekRange != lastAvailableWeekRange;

}
