import 'package:flutter/material.dart';
import 'package:planbee/core/utils/app_padding.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppPadding.screen(context),
        child: const Text('placeholder'),
    );
  }
}
