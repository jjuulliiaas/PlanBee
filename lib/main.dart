import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/blocks/all_tasks/provider.dart';
import 'package:planbee/blocks/settings/provider.dart';
import 'package:planbee/blocks/statistics/provider.dart';
import 'package:planbee/core/theme/app_theme.dart';
import 'package:planbee/routes.dart';
import 'package:provider/provider.dart';

import 'blocks/category/provider.dart';
import 'blocks/task/provider.dart';
import 'blocks/timer/provider.dart';
import 'generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          ChangeNotifierProvider(
            create: (context) => StatsProvider(
              context.read<TaskProvider>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => SettingsProvider(
              taskProvider: context.read<TaskProvider>(),
            ),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(393, 852),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            final settings = context.watch<SettingsProvider>();
            return MaterialApp(
              title: 'PlanBee',
              theme: AppTheme.lightTheme,
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              locale: settings.language.toUpperCase() == 'UK' || settings.language.toUpperCase() == 'UA'
                  ? const Locale('uk')
                  : const Locale('en'),
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              onGenerateRoute: AppRoutes.generateRoute,
              initialRoute: AppRoutes.home,
            );
          },
        ),
    );
  }
}