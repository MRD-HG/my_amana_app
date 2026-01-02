import 'package:flutter/material.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(fontSize: 18),
        padding: const EdgeInsets.only(
          left: 150,
          right: 150,
          top: 15,
          bottom: 15,
        ),
      ),
      child: Text(label),
    );
  }
}
