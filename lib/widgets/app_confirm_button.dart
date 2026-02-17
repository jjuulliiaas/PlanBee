import 'package:flutter/material.dart';

class AppConfirmButton extends StatelessWidget {
  const AppConfirmButton({
    super.key,
    this.text = 'Confirm',
    required this.onTap
  });

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onTap,
          child: Text(
            text,
          )
      ),
    );
  }
}
