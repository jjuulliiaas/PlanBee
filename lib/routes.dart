import 'package:flutter/material.dart';
import 'package:planbee/screens/create_edit_task/screen.dart';
import 'package:planbee/screens/home/screen.dart';
import 'package:planbee/screens/settings/screen.dart';
import 'package:planbee/screens/statistics/screen.dart';

class AppRoutes {
  final RouteObserver<PageRoute> routeObserver = RouteObserver();

  static const home = '/';
  static const create = '/create';
  static const statistics = '/statistics';
  static const settingsScreen = '/settings';

  static Route<dynamic> noAnimationRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {

      case home:
        return noAnimationRoute(const HomeScreen());

      case create:
        return noAnimationRoute(const CreateEditScreen());

      case statistics:
        return noAnimationRoute(const StatisticsScreen());

      case settingsScreen:
        return noAnimationRoute(const SettingsScreen());

      default:
        return noAnimationRoute(const HomeScreen());
    }
  }

}