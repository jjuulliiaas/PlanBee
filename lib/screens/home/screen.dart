import 'package:flutter/material.dart';
import 'package:planbee/screens/home/body.dart';
import 'package:planbee/widgets/bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textScheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PlanBee'),
        titleTextStyle: textScheme.headlineSmall?.copyWith(color: colorScheme.outline),
        ),
      body: const HomeBody(),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
