import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../blocks/statistics/provider.dart';

class GoldenBeeCard extends StatelessWidget {
  const GoldenBeeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<StatsProvider>();
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        leading: Icon(Icons.wb_sunny_outlined, color: Colors.orange, size: 30.r),
        title: Text('Golden Bee Hour', style: theme.textTheme.titleSmall),
        subtitle: Text(
          stats.goldenHour,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.auto_awesome, color: Colors.amber),
      ),
    );
  }
}