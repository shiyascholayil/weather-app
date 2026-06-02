import 'package:flutter/material.dart';
import 'package:wheather_app/const.dart';

class HomeColomn extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const HomeColomn({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: whiteColor,
          size: 30,
        ),

        const SizedBox(height: 10),

        Text(
          value,
          style: const TextStyle(
            color: whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          label,
          style: smalltextStyle.copyWith(
            color: white70Color,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}