import 'package:flutter/material.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    this.onPressed,
    this.leading,
    this.icon,
  });

  final String label;
  /// When null, the button is disabled.
  final VoidCallback? onPressed;
  final Widget? leading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
        minimumSize: const Size(120, 44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 10),
          ] else if (icon != null) ...[
            Icon(icon, size: 20, color: Colors.white),
            const SizedBox(width: 10),
          ],
          Text(label),
        ],
      ),
    );
  }
}
