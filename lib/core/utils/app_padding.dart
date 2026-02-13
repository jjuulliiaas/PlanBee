import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPadding {
  AppPadding._();

  static double horizontal(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1200) return 40.w;
    if (width >= 600) return 24.w;

    double dynamicPadding = width * 0.05;
    return dynamicPadding.clamp(16.0, 24.0).w;
  }

  static double vertical(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return topPadding > 0 ? 12.h : 20.h;
  }

  static EdgeInsets screen(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: horizontal(context),
      vertical: vertical(context),
    );
  }

  static EdgeInsets horizontalOnly(BuildContext context) {
    return EdgeInsets.symmetric(horizontal: horizontal(context));
  }

  static EdgeInsets card(BuildContext context) {
    return EdgeInsets.all(horizontal(context) * 0.8);
  }

}