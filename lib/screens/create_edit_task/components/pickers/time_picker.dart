import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/widgets/app_confirm_button.dart';

import '../../../../core/theme/colors_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../../widgets/app_choice_chip.dart';
import '../../../../widgets/base_picker_layout.dart';
import '../../../../widgets/time_picker_wheel.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    super.key,
    this.initialTime
  });

  final TimeOfDay? initialTime;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    _selectedTime = widget.initialTime ?? TimeOfDay.now();
    super.initState();
  }

  void _onTimeChanged(TimeOfDay time) {
    setState(() {
      _selectedTime = time;
    });
  }

  bool _isPresetActive(int hour, int minute) {
    return _selectedTime.hour == hour && _selectedTime.minute == minute;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final customColors = theme.extension<AppColorsExtension>();

    final heightSpace = SizedBox(height: 24.h,);
    final weightSpace = SizedBox(width: 16.w,);

    final $ = S.of(context);

    return BasePickerLayout(
      title: $.setTime,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [

              /// Preset +1 hour from current time
              AppChoiceChip(
                label: $.plusOneHour,
                icon: CupertinoIcons.timer,
                iconColor: colorScheme.primary,
                isSelected: false,
                onSelected: () {
                  final now = DateTime.now();
                  final newTime = TimeOfDay.fromDateTime(now.add(const Duration(hours: 1)));
                  _onTimeChanged(newTime);
                },
              ),
              weightSpace,

              /// Preset Morning 9:00
              AppChoiceChip(
                label: $.timeMorning,
                icon: CupertinoIcons.sun_max_fill,
                iconColor: customColors?.yellow,
                isSelected: _isPresetActive(9, 0),
                onSelected: () => _onTimeChanged(const TimeOfDay(hour: 9, minute: 0)),
              ),
              weightSpace,

              /// Preset Evening 19:00
              AppChoiceChip(
                label: $.timeEvening,
                icon: CupertinoIcons.moon_stars_fill,
                iconColor: customColors?.yellow,
                isSelected: _isPresetActive(19, 0),
                onSelected: () => _onTimeChanged(const TimeOfDay(hour: 19, minute: 0)),
              ),
            ],
          ),
        ),
        heightSpace,
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimePickerWheel(
              selectedTime: _selectedTime,
              onTimeChanged: _onTimeChanged,
            ),
            heightSpace,
            AppConfirmButton(
                onTap: () {
                  Navigator.maybePop(context, _selectedTime);
                }
            ),
          ],
        )
      ],
    );
  }
}
