import "package:flutter/material.dart";
import "package:my_amana_app/core/theme/app_theme.dart";
import "package:my_amana_app/core/widgets/tracking_search_card.dart";

import "../resultat.dart";

class Accueila extends StatefulWidget {
  const Accueila({super.key});

  @override
  State<Accueila> createState() => _AccueilaState();
}

class _AccueilaState extends State<Accueila> {
  final TextEditingController _trackingController = TextEditingController();

  @override
  void dispose() {
    _trackingController.dispose();
    super.dispose();
  }

  void _submitTracking() {
    final trackingId = _trackingController.text.trim();
    if (trackingId.isEmpty || trackingId.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez saisir un numero de suivi valide.'),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Resultat(trackingId: trackingId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TrackingSearchCard(
            controller: _trackingController,
            onSearch: _submitTracking,
            onScan: () {},
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '+ Historique',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            hintText: 'Scanner ou saisir votre code',
          ),
          const SizedBox(height: 24),
          const Text(
            'Historique recent',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.history, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Aucun historique pour le moment.',
                      style: TextStyle(color: AppColors.mutedText),
                    ),
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
