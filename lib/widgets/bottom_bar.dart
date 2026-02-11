import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routes.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key, required this.currentIndex});

  final int currentIndex;

  void _onTap(BuildContext context, int index) {
    if (currentIndex == index) return;

    switch(index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, AppRoutes.create);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AppRoutes.statistics);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, AppRoutes.settingsScreen);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 24.w),
        height: 60.w,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: colorScheme.onSurface,
          borderRadius: BorderRadius.circular(100.r),
          boxShadow: [
            BoxShadow(
              color: colorScheme.outline,
              blurRadius: 15,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildItem(context, index: 0, icon: Icons.home_rounded),
            _buildItem(context, index: 1, icon: Icons.add),
            _buildItem(context, index: 2, icon: Icons.bar_chart),
            _buildItem(context, index: 3, icon: Icons.settings)
          ],
        ),

      ),
    );


  }

  Widget _buildItem(
      BuildContext context, {
        required int index,
        required IconData icon,
        IconData? activeIcon
      }) {

    final bool isActive = currentIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => _onTap(context, index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: isActive ? colorScheme.primary : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isActive && activeIcon != null ? activeIcon : icon,
          size: 20.w,
          color: isActive ? colorScheme.onPrimary : colorScheme.outline,
        ),
      ),
    );
  }
}
