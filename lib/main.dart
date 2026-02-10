import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/core/theme/app_theme.dart';
import 'package:planbee/screens/home/screen.dart';

void main() {
  runApp(const PlanBee());
}

class PlanBee extends StatelessWidget {
  const PlanBee({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'PlanBee',
          theme: AppTheme.lightTheme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        );
      },
    );
  }
}