import 'package:flutter/material.dart';
import 'package:planbee/widgets/bottom_bar.dart';

import '../../generated/l10n.dart';
import 'body.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textScheme = theme.textTheme;
    final $ = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text($.settings),
        titleTextStyle: textScheme.headlineSmall,
      ),
        body: Stack(
            children: [
              const SettingsBody(),
              const CustomBottomBar(currentIndex: 3)
            ]
        )
    );
  }
}
