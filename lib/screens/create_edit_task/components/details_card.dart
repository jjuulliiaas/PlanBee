import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_padding.dart';
import '../../../widgets/detail_name.dart';

class DetailsCard extends StatefulWidget {
  const DetailsCard({super.key});

  @override
  State<DetailsCard> createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  bool _isHighPriority = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 10,
      child: Container(
        padding: AppPadding.screen(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailName(
                  icon: Icons.calendar_month,
                  text: 'Deadline',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                        onPressed: () {},
                        child: const Text('Set Date')
                    ),
                    SizedBox(width: 8.w),
                    OutlinedButton(
                        onPressed: () {},
                        child: const Text('Set Time')
                    )
                  ],
                )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailName(
                  icon: Icons.category_rounded,
                  text: 'Category',
                ),
                TextButton.icon(
                    onPressed: () {},
                    label: Row(
                      children: [
                        Text(
                            'Choose category',
                          style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
                        ),
                        Icon(
                            Icons.keyboard_arrow_down_outlined,
                          color: colorScheme.primary,
                        )
                      ],
                    ),
                )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailName(
                  icon: Icons.priority_high_rounded,
                  text: 'High priority',
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                      value: _isHighPriority,
                      onChanged: (bool value) {
                        print('Priority is changed!');
                      }
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
