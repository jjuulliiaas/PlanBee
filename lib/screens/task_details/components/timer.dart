import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/core/theme/app_theme.dart';
import 'package:planbee/core/utils/app_padding.dart';
import '../../../generated/l10n.dart';
import '../controller.dart';

class TimerCard extends StatelessWidget {
  final TaskDetailsController controller;

  const TimerCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final $ = S.of(context);

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
                    Text($.focusTimer, style: textTheme.bodyLarge),
                    if (!isTaskCompleted && (isRunning || isPaused))
                      _buildSmallActionButton(
                        context,
                        label: $.stopFocus,
                        onTap: () => controller.resetTimer(),
                      ),
                    if (!isTaskCompleted && isFinished)
                      _buildSmallActionButton(
                        context,
                        label: $.add5Min,
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
                    $.timeUpGreatFocus,
                    style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ],
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPresetButton(context, minutes: 15),
                    _buildPresetButton(context, minutes: 30),
                    _buildPresetButton(context, minutes: 45),
                    _buildPresetButton(context, icon: Icons.edit),
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
    final $ = S.of(context);

    String label = $.startFocus;
    IconData? icon = Icons.play_arrow;

    if (isTaskCompleted) {
      label = $.completed;
      icon = Icons.check;
    } else if (isFinished) {
      label = $.done;
      icon = null;
    } else if (isRunning) {
      label = $.pauseFocus;
      icon = Icons.pause;
    } else if (isPaused) {
      label = $.resumeTimer;
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
    int? minutes,
    String? label,
    IconData? icon,
  }) {
    final l10n = S.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final $ = S.of(context);

    return InkWell(
      onTap: minutes != null
          ? () => controller.startPresetTimer(minutes)
          : () => controller.showCustomTimerPicker(),
      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      child: Container(
        width: 72.w,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (minutes != null) ...[
              Text(
                '$minutes',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                l10n.minutesUnit,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ] else ...[
              if (icon != null) ...[
                Icon(icon, size: 14.sp, color: colorScheme.primary),
                SizedBox(height: 2.h),
              ],
              Text(
                $.custom,
                textAlign: TextAlign.center,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}