import 'package:flutter/material.dart';
import 'package:planbee/widgets/bottom_bar.dart';

import 'body.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(
            children: [
              AllTasksBody(),
              const CustomBottomBar(currentIndex: 1)
            ]
        )
    );
  }
}
