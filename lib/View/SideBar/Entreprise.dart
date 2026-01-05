import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

class Amanamesager extends StatelessWidget {
  const Amanamesager({super.key});

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppGradients.hero,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amana messagerie nationale',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Collecte, transport et livraison rapides pour les entreprises.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<String> items) {
    return Card(
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                for (final item in items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline,
                            color: AppColors.primary, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(item, style: const TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
              ],
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
          _buildHeader(),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset('assets/images/AmanaDelivery.jpg',
                height: 200, fit: BoxFit.cover),
          ),
          const SizedBox(height: 16),
          const Text(
            'Amana Messagerie Nationale assure la collecte, le transport et la livraison des colis dans des delais express adaptes aux entreprises.',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            'Caracteristiques',
            const [
              'Delais de livraison entre 1 et 2 jours selon la destination',
              'Reseau de plus de 1800 points de contact',
              'Mise en instance en agence pour plus de proximite',
              'Solutions adaptees aux besoins des entreprises',
            ],
          ),
          _buildInfoCard(
            'Avantages',
            const [
              'Livraison tardive jusqu a 19h et le samedi matin',
              'Securite renforcee pour vos envois',
              'Suivi des envois en temps reel',
              'Retour de fonds credite le jour meme',
              'Accompagnement commercial dedie',
            ],
          ),
        ],
      ),
      bottomNavigationBar: const NavBottom(),
    );
  }
}
