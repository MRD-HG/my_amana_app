import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

class DeliveryTimesPage extends StatelessWidget {
  const DeliveryTimesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      _DeliveryTimeItem(
        title: 'Express / EMS',
        subtitle: 'Fast delivery (usually 1–2 business days in Morocco).',
        icon: Icons.flash_on,
      ),
      _DeliveryTimeItem(
        title: 'Standard',
        subtitle: 'Economy delivery (usually 2–4 business days in Morocco).',
        icon: Icons.local_shipping,
      ),
      _DeliveryTimeItem(
        title: 'International',
        subtitle: 'Variable delivery time (customs + destination).',
        icon: Icons.public,
      ),
    ];

    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.schedule, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Delivery times are indicative and can vary by city, peak periods, and operational constraints.',
                      style: TextStyle(color: AppColors.mutedText),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...items.map((e) => Card(
                child: ListTile(
                  leading: Icon(e.icon, color: AppColors.primary),
                  title: Text(e.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(e.subtitle),
                ),
              )),
        ],
      ),
    );
  }
}

class _DeliveryTimeItem {
  const _DeliveryTimeItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}
