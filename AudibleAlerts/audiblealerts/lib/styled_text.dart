import "package:flutter/material.dart";

class StyledText extends StatelessWidget {
  const StyledText({super.key});
  @override
  Widget build(context) {
    return const Text(
      'AudibleAlerts',
      textAlign: TextAlign.justify,
      style: TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w700,
          fontSize: 27),
    );
  }
}
