import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import 'detail_name.dart';

class AppSwitcher extends StatelessWidget {
  const AppSwitcher({
    super.key,
    required this.value,
    required this.onChanged
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final $ = S.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DetailName(
          icon: Icons.priority_high_rounded,
          text: $.highPriority,
        ),
        Transform.scale(
          scale: 0.8,
          child: Switch(
              value: value,
              onChanged: onChanged
          ),
        )
      ],
    );
  }
}
