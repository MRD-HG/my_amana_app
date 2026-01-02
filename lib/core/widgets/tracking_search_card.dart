import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class TrackingSearchCard extends StatelessWidget {
  const TrackingSearchCard({
    super.key,
    required this.controller,
    required this.onSearch,
    this.onScan,
    this.trailing,
    this.title = 'Suivi',
    this.hintText = 'Saisir votre code',
  });

  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback? onScan;
  final Widget? trailing;
  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppGradients.hero,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.location_on, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: AppColors.text),
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_circle_right),
                    onPressed: onSearch,
                  ),
                  IconButton(
                    icon: const Icon(Icons.qr_code_scanner),
                    onPressed: onScan,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
