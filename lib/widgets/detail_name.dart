import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailName extends StatelessWidget {
  const DetailName({
    super.key,
    required this.icon,
    required this.text
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20.r,
        ),
        SizedBox(width: 4.w,),
        Text(
          text,
          style: textTheme.bodyLarge,
        ),
      ],
    );
  }
}
