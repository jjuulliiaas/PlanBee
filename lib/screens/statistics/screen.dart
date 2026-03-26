import 'package:flutter/material.dart';
import 'package:planbee/widgets/bottom_bar.dart';

import 'body.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textScheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
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
