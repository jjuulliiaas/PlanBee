import 'package:flutter/material.dart';

import 'detail_name.dart';

class AppSwitcher extends StatelessWidget {
  const AppSwitcher({
    super.key,
    required this.value
  });

  final bool value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DetailName(
          icon: Icons.priority_high_rounded,
          text: 'High priority',
        ),
        Transform.scale(
          scale: 0.8,
          child: Switch(
              value: value,
              onChanged: (bool value) {
                print('Priority is changed!');
              }
          ),
        )
      ],
    );
  }
}
