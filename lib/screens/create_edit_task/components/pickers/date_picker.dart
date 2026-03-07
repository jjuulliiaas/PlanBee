import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/widgets/app_confirm_button.dart';

import '../../../../widgets/app_calendar.dart';
import '../../../../widgets/app_choice_chip.dart';
import '../../../../widgets/base_picker_layout.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    this.initialDate
  });

  final DateTime? initialDate;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  void _onDateChanged(DateTime date) {
    setState(() {
      _selectedDate = DateTime(date.year, date.month, date.day);
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    final heightSpace = SizedBox(height: 16.h,);

    return BasePickerLayout(
      title: 'Set Date',
      children: [
        Row(
          children: [
            AppChoiceChip(
              label: 'Today',
              isSelected: _selectedDate != null && DateUtils.isSameDay(_selectedDate!, today),
              onSelected: () => _onDateChanged(today),
            ),
            SizedBox(width: 16.w,),
            AppChoiceChip(
              label: 'Tomorrow',
            isSelected: _selectedDate != null && DateUtils.isSameDay(_selectedDate!, tomorrow),
              onSelected: () => _onDateChanged(tomorrow),
            )
          ],
        ),
        heightSpace,
        AppCalendar(
          selectedDate: _selectedDate,
          onDateChanged: (DateTime value) => _onDateChanged(value),
        ),
        heightSpace,
        AppConfirmButton(
            onTap: () {
              if(_selectedDate != null) {
                Navigator.maybePop(context, _selectedDate);
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please select a date')),
              );
              }
            }
        )
      ],
    );
  }
}
