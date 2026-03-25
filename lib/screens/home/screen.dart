import 'package:flutter/material.dart';
import 'package:planbee/screens/home/body.dart';
import 'package:planbee/widgets/bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          HomeBody(),
          const CustomBottomBar(currentIndex: 0),
        ]
      )
    );
  }
}
