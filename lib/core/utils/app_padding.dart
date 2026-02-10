import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPadding {
  AppPadding._();

  static double horizontal(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1200) return 40.w;
    if (width >= 600) return 24.w;

    return 20.w;
  }

  static double vertical() => 16.h;

  static EdgeInsets screen(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: horizontal(context),
      vertical: vertical(),
    );
  }

  static EdgeInsets horizontalOnly(BuildContext context) {
    return EdgeInsets.symmetric(horizontal: horizontal(context));
  }

  static double get cardInternal => 16.r;

}