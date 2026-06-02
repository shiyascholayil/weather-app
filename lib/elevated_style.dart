import 'package:flutter/material.dart';
import '../const.dart';

class CustomElevatedstyle extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomElevatedstyle({
    required this.onPressed,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonBgColor,
        foregroundColor: buttonTextColor,
        minimumSize: const Size(double.infinity, 52),
        padding: const EdgeInsets.all(16),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(text, style: btntextStyle),
      ),
    );
  }
}
