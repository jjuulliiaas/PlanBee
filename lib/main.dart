import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/blocks/all_tasks/provider.dart';
import 'package:planbee/core/theme/app_theme.dart';
import 'package:planbee/routes.dart';
import 'package:provider/provider.dart';

import 'blocks/category/provider.dart';
import 'blocks/task/provider.dart';
import 'blocks/timer/provider.dart';

void main() {
  runApp(const PlanBee());
}

class PlanBee extends StatelessWidget {
  const PlanBee({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
          ChangeNotifierProvider(create: (_) => TaskProvider()),
          ChangeNotifierProvider(create: (_) => TimerProvider()),
          ChangeNotifierProvider(
            create: (context) => AllTasksProvider(
              context.read<TaskProvider>(),
            ),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(393, 852),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              title: 'PlanBee',
              theme: AppTheme.lightTheme,
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRoutes.generateRoute,
              initialRoute: AppRoutes.home,
            );
          },
        ),
    );
  }
}