import 'package:flutter/material.dart';
import 'package:planbee/screens/home/body.dart';
import 'package:planbee/widgets/bottom_bar.dart';

class CreateEditScreen extends StatelessWidget {
  const CreateEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textScheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
        titleTextStyle: textScheme.headlineSmall,
      ),
        body: Stack(
            children: [
              HomeBody(),
              const CustomBottomBar(currentIndex: 1)
            ]
        )
    );
  }
}
