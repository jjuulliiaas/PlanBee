import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../blocks/statistics/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/colors_extension.dart';

class YesterdayMotivationWidget extends StatelessWidget {
  final VoidCallback? onClose;

  const YesterdayMotivationWidget({
    super.key,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<StatsProvider>();
    final theme = Theme.of(context);
    final customColors = theme.extension<AppColorsExtension>();
    final count = stats.yesterdayCompletedCount;

    if (count == 0) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: customColors?.yellow.withOpacity(0.15) ?? Colors.yellow.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppTheme.radiusBig),
        border: Border.all(
          color: customColors?.yellow.withOpacity(0.3) ?? Colors.yellow.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          const _InfiniteBouncingBee(),
          SizedBox(width: 16.w),
          Expanded(
            child: _MotivationContent(count: count),
          ),
          IconButton(
            onPressed: onClose,
            icon: Icon(
              Icons.close,
              size: 20.r,
              color: customColors?.yellow.withOpacity(0.5) ?? Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfiniteBouncingBee extends StatelessWidget {
  const _InfiniteBouncingBee();

  @override
  Widget build(BuildContext context) {
    final toggle = ValueNotifier<double>(0);

    return ValueListenableBuilder(
      valueListenable: toggle,
      builder: (context, value, child) {
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: value == 0 ? 8 : 0, end: value == 0 ? 0 : 8),
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          onEnd: () {
            toggle.value = toggle.value == 0 ? 8 : 0;
          },
          builder: (context, offset, child) {
            return Transform.translate(
              offset: Offset(0, -offset),
              child: Text(
                "🐝",
                style: TextStyle(
                  fontSize: 30.sp,
                  shadows: [
                    Shadow(
                      color: Colors.yellow.shade700.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _MotivationContent extends StatelessWidget {
  final int count;

  const _MotivationContent({required this.count});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<AppColorsExtension>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'YESTERDAY SUCCESS',
          style: theme.textTheme.labelSmall?.copyWith(
            color: customColors?.yellow.withOpacity(0.8),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        SizedBox(height: 2.h),
        Text.rich(
          TextSpan(
            text: 'You completed ',
            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: '$count',
                style: TextStyle(
                  color: customColors?.yellow ?? Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              TextSpan(text: count == 1 ? ' task.' : ' tasks.'),
              const TextSpan(
                text: '\nBusy Bee! 🐝',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}