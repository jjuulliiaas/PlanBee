import 'package:flutter/material.dart';

class AppConfirmButton extends StatelessWidget {
  const AppConfirmButton({
    super.key,
    this.text = 'Confirm',
    this.icon,
    required this.onTap,
    this.color
  });

  final String text;
  final VoidCallback? onTap;
  final Widget? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
          onPressed: onTap,
          label: Text(text),
          icon: icon,
        style: ElevatedButton.styleFrom(
          backgroundColor: color
        ),
      ),
    );
  }
}
