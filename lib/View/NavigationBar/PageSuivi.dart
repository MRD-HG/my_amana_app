import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/View/resultat.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'package:my_amana_app/core/widgets/tracking_search_card.dart';

class PageSuiv extends StatefulWidget {
  const PageSuiv({super.key});

  @override
  State<PageSuiv> createState() => _PageSuivState();
}

class _PageSuivState extends State<PageSuiv> {
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

  Widget _buildTipRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: AppColors.text, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TrackingSearchCard(
            controller: _trackingController,
            onSearch: _submitTracking,
            onScan: () {},
            title: 'Suivi de colis',
            hintText: 'Numero de suivi',
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Conseils rapides',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildTipRow(
                    Icons.confirmation_number_outlined,
                    'Saisissez un code de suivi complet.',
                  ),
                  _buildTipRow(
                    Icons.access_time,
                    'Le suivi se met a jour toutes les 2 heures.',
                  ),
                  _buildTipRow(
                    Icons.support_agent,
                    'Besoin d aide ? Contactez notre equipe.',
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
