import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/core/theme/app_theme.dart';
import 'package:planbee/core/utils/app_padding.dart';
import '../controller.dart';

class TimerCard extends StatelessWidget {
  final TaskDetailsController controller;

  const TimerCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final bool isTaskCompleted = controller.isTaskCompleted;

    final bool isRunning = controller.isTimerRunningForThisTask;
    final String currentTime = controller.displayTime;
    final double progress = controller.displayProgress;
    final bool isFinished = currentTime == "00:00" && progress >= 1.0;
    final bool isPaused = !isRunning && currentTime != "00:00" && !isFinished;

    return Opacity(
      opacity: isTaskCompleted ? 0.5 : 1.0,
      child: IgnorePointer(
        ignoring: isTaskCompleted,
        child: Card(
          child: Padding(
            padding: AppPadding.screen(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Focus Timer', style: textTheme.bodyLarge),
                    if (!isTaskCompleted && (isRunning || isPaused))
                      _buildSmallActionButton(
                        context,
                        label: 'Stop',
                        onTap: () => controller.resetTimer(),
                      ),
                    if (!isTaskCompleted && isFinished)
                      _buildSmallActionButton(
                        context,
                        label: 'Add 5 min',
                        onTap: () => controller.startPresetTimer(5),
                      ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    _buildCircularProgress(colorScheme, progress),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          currentTime,
                          style: textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),

                    _buildMainButton(context, isRunning, isPaused, isFinished, isTaskCompleted),
                  ],
                ),
                if (isFinished && !isTaskCompleted) ...[
                  SizedBox(height: 12.h),
                  Text(
                    "Time's up. Great focus session!",
                    style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ],
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPresetButton(context, label: '15\nmin', minutes: 15),
                    _buildPresetButton(context, label: '30\nmin', minutes: 30),
                    _buildPresetButton(context, label: '45\nmin', minutes: 45),
                    _buildPresetButton(context, label: 'Custom', icon: Icons.edit),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //
  Widget _buildCircularProgress(ColorScheme colorScheme, double value) {
    return SizedBox(
      width: 35.r,
      height: 35.r,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: value, end: value),
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
        builder: (context, animatedValue, child) {
          return CircularProgressIndicator(
            value: animatedValue,
            strokeWidth: 6,
            strokeCap: StrokeCap.round,
            backgroundColor: colorScheme.primaryContainer,
            color: colorScheme.primary,
          );
        },
      ),
    );
  }

  // Small action button at the top (Stop / Add 5 min)
  Widget _buildSmallActionButton(BuildContext context, {required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Main button Start/Pause/Resume/Done
  Widget _buildMainButton(BuildContext context, bool isRunning, bool isPaused, bool isFinished, bool isTaskCompleted) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    String label = 'Start Focus';
    IconData? icon = Icons.play_arrow;

    if (isTaskCompleted) {
      label = 'Completed';
      icon = Icons.check;
    } else if (isFinished) {
      label = 'Done';
      icon = null;
    } else if (isRunning) {
      label = 'Pause Focus';
      icon = Icons.pause;
    } else if (isPaused) {
      label = 'Resume Focus';
      icon = Icons.play_arrow;
    }

    return FilledButton.icon(
      onPressed: isTaskCompleted ? null : (isFinished ? () => controller.markAsCompleted() : controller.onTimerButtonPressed),
      style: FilledButton.styleFrom(
        backgroundColor: isTaskCompleted ? colorScheme.outlineVariant : colorScheme.primary,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radiusMedium)),
      ),
      icon: icon != null ? Icon(icon, size: 15.r) : const SizedBox.shrink(),
      label: Text(
          label,
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.surface)
      ),
    );
  }

  Widget _buildPresetButton(BuildContext context, {
    required String label,
    int? minutes,
    IconData? icon}) {

    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: minutes != null
        ? () => controller.startPresetTimer(minutes)
        : () => controller.showCustomTimerPicker(),
      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      child: Container(
        width: 72.w,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        ),
        child: Column(
          children: [
            if (icon != null) Icon(icon, size: 10.r, color: colorScheme.primary),
            if (icon != null) SizedBox(height: 4.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}