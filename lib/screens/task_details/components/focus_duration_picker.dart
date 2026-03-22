import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/app_confirm_button.dart';
import '../../../widgets/base_picker_layout.dart';
import '../../../widgets/time_picker_wheel.dart';

class FocusDurationPicker extends StatefulWidget {
  const FocusDurationPicker({
    super.key,
    this.initialDuration = const Duration(minutes: 25),
  });

  final Duration initialDuration;

  @override
  State<FocusDurationPicker> createState() => _FocusDurationPickerState();
}

class _FocusDurationPickerState extends State<FocusDurationPicker> {
  late Duration _selectedDuration;

  @override
  void initState() {
    super.initState();
    _selectedDuration = widget.initialDuration;
  }

  void _onDurationChanged(TimeOfDay time) {
    setState(() {
      _selectedDuration = Duration(hours: time.hour, minutes: time.minute);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BasePickerLayout(
      title: 'Set Focus Duration',
      children: [
        // _buildPresets(),
        // SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 75.w,
              child: Center(child: Text('Hours', style: textTheme.bodySmall?.copyWith(color: Colors.grey))),
            ),
            SizedBox(width: 40.w),
            SizedBox(
              width: 75.w,
              child: Center(child: Text('Minutes', style: textTheme.bodySmall?.copyWith(color: Colors.grey))),
            ),
          ],
        ),

        TimePickerWheel(
          selectedTime: TimeOfDay(
              hour: _selectedDuration.inHours,
              minute: _selectedDuration.inMinutes % 60
          ),
          onTimeChanged: _onDurationChanged,
        ),

        SizedBox(height: 24.h),

        AppConfirmButton(
          text: 'Set Focus',
          onTap: () {
            Navigator.maybePop(context, _selectedDuration);
          },
        ),
      ],
    );
  }

  // Widget _buildPresets() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Row(
  //       children: [
  //         _buildChip('25 min', const Duration(minutes: 25)),
  //         SizedBox(width: 12.w),
  //         _buildChip('45 min', const Duration(minutes: 45)),
  //         SizedBox(width: 12.w),
  //         _buildChip('1 hour', const Duration(hours: 1)),
  //       ],
  //     ),
  //   );
  // }
}