import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/app_padding.dart';

class TimePickerWheel extends StatefulWidget {
  const TimePickerWheel({
    super.key,
    required this.selectedTime,
    required this.onTimeChanged,
  });

  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  @override
  State<TimePickerWheel> createState() => _TimePickerWheelState();
}

class _TimePickerWheelState extends State<TimePickerWheel> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _hourController = FixedExtentScrollController(initialItem: widget.selectedTime.hour);
    _minuteController = FixedExtentScrollController(initialItem: widget.selectedTime.minute);
  }

  @override
  void didUpdateWidget(covariant TimePickerWheel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedTime != widget.selectedTime && !_isAnimating) {
      _animateToCurrentTime();
    }
  }

  Future<void> _animateToCurrentTime() async {
    _isAnimating = true;

    await Future.wait([
      if (_hourController.hasClients)
        _hourController.animateToItem(
          widget.selectedTime.hour,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
      if (_minuteController.hasClients)
        _minuteController.animateToItem(
          widget.selectedTime.minute,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        ),
    ]);

    _isAnimating = false;
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textStyle = theme.textTheme.headlineLarge;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 60.h,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: colorScheme.primaryContainer, width: 1.5),
              bottom: BorderSide(color: colorScheme.primaryContainer, width: 1.5),
            ),
          ),
        ),
        SizedBox(
          height: 250.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildWheel(
                controller: _hourController,
                itemCount: 24,
                onChanged: (h) {
                  if (!_isAnimating) {
                    HapticFeedback.lightImpact();
                    widget.onTimeChanged(TimeOfDay(hour: h, minute: widget.selectedTime.minute));
                  }
                },
                textStyle: textStyle!,
                colorScheme: colorScheme,
                isSelected: (index) => index == widget.selectedTime.hour,
              ),
              Padding(
                padding: AppPadding.screen(context),
                child: Text(":", style: textStyle),
              ),
              _buildWheel(
                controller: _minuteController,
                itemCount: 60,
                onChanged: (m) {
                  if (!_isAnimating) {
                    HapticFeedback.lightImpact();
                    widget.onTimeChanged(TimeOfDay(hour: widget.selectedTime.hour, minute: m));
                  }
                },
                textStyle: textStyle,
                colorScheme: colorScheme,
                padLeft: true,
                isSelected: (index) => index == widget.selectedTime.minute,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWheel({
    required FixedExtentScrollController controller,
    required int itemCount,
    required ValueChanged<int> onChanged,
    required TextStyle textStyle,
    required ColorScheme colorScheme,
    required bool Function(int) isSelected,
    bool padLeft = false,
  }) {
    return SizedBox(
      width: 75.w,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 55.h,
        perspective: 0.005,
        diameterRatio: 1.5,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: itemCount,
          builder: (context, index) {
            final active = isSelected(index);
            final text = padLeft ? index.toString().padLeft(2, '0') : index.toString();
            return Center(
              child: Text(
                text,
                style: textStyle.copyWith(
                  color: active ? colorScheme.onSecondaryContainer : colorScheme.outline,
                  fontWeight: active ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}