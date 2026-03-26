import 'package:flutter/material.dart';

class StatisticsController {
  final BuildContext context;
  const StatisticsController(this.context);

  void onShowHeatmapDetail(DateTime date, int count) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('On ${date.day}/${date.month} you finished $count tasks! 🐝'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void onShareStats() {
  }
}