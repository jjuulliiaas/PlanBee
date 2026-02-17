import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/core/theme/app_theme.dart';

import '../../../../core/utils/app_padding.dart';

class BasePickerLayout extends StatelessWidget {
  const BasePickerLayout({
    super.key,
    required this.title,
    required this.children
  });

  final String title;
  final List<Widget> children;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child
}) {
    return showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (context) => child
    );
}


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final mediaQuery = MediaQuery.of(context);

    return Container(
      padding: AppPadding.screen(context),
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: mediaQuery.size.height * 0.7,
      ),
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
          ),
          Text(
            title,
            style: textTheme.headlineSmall,
          ),
          Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: children,
                ),
              )
          )
        ],
      ),
    );
  }
}
