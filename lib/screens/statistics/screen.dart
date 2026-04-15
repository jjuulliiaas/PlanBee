import 'package:flutter/material.dart';
import 'package:planbee/widgets/bottom_bar.dart';

import '../../generated/l10n.dart';
import 'body.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textScheme = theme.textTheme;
    final $ = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text($.statistics),
        titleTextStyle: textScheme.headlineSmall,
      ),
        body: Stack(
            children: [
              const StatisticsBody(),
              const CustomBottomBar(currentIndex: 2)
            ]
        )
    );
  }
}
