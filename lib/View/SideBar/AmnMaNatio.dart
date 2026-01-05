import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/View/NavigationBar/Tarif.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

class DefinitionPage extends StatelessWidget {
  const DefinitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceDetailsPage(
      title: 'Amana messagerie nationale',
      tagline: 'Aussitot envoye, aussitot livre !',
      description:
          'Livrez vos colis et documents partout au Maroc avec des delais express garantis.',
      imagePath: 'assets/images/AmanaDelivery.jpg',
      characteristics: [
        'Contre remboursement disponible',
        'Preuve de livraison signee',
        'Valeur declaree pour vos envois',
        'Traitement special pour les envois fragiles',
      ],
      advantages: [
        'Livraison a domicile',
        'Delai de garde de 15 jours en agence',
        'Alertes SMS expeditateur et destinataire',
        'Emballages adaptes a vos colis',
        'Services de tracabilite',
      ],
    );
  }
}

class Ecommerce extends StatelessWidget {
  const Ecommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceDetailsPage(
      title: 'E-commerce',
      tagline: 'Livraison flexible pour vos clients',
      description:
          'Une offre dediee aux acteurs e-commerce avec options de livraison et encaissement.',
      imagePath: 'assets/images/AmanaDelivery.jpg',
      characteristics: [
        'Deux tentatives de livraison',
        'Alertes SMS et appels avant livraison',
        'Encaissement a la livraison',
      ],
      advantages: [
        'Couverture nationale et regionale',
        'Suivi en temps reel des colis',
        'Solutions adaptees aux pics d activite',
      ],
    );
  }
}

class AmanaInter extends StatelessWidget {
  const AmanaInter({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceDetailsPage(
      title: 'Amana internationale',
      tagline: 'Livrez vos colis a l etranger',
      description:
          'Delais maitrises entre 4 et 7 jours selon la destination.',
      imagePath: 'assets/images/AmanaDelivery.jpg',
      characteristics: [
        'Poids jusqu a 70 kg par colis',
        'Large couverture internationale',
      ],
      advantages: [
        'Meilleur rapport qualite/prix',
        'Suivi des envois',
      ],
    );
  }
}

class Postcolis extends StatelessWidget {
  const Postcolis({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceDetailsPage(
      title: 'Postcolis',
      tagline: 'Messagerie internationale economique',
      description:
          'Solution pour les colis jusqu a 30 kg avec tarifs competitifs.',
      imagePath: 'assets/images/AmanaDelivery.jpg',
      characteristics: [
        'Couverture de plus de 200 destinations',
        'Delais a partir de 7 jours',
      ],
      advantages: [
        'Tarifs economiques',
        'Formalites simples',
        'Service de tracabilite',
      ],
    );
  }
}

class ServiceDetailsPage extends StatelessWidget {
  const ServiceDetailsPage({
    super.key,
    required this.title,
    required this.tagline,
    required this.description,
    required this.imagePath,
    required this.characteristics,
    required this.advantages,
  });

  final String title;
  final String tagline;
  final String description;
  final String imagePath;
  final List<String> characteristics;
  final List<String> advantages;

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppGradients.hero,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            tagline,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
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
            child: Image.asset(imagePath, height: 190, fit: BoxFit.cover),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(fontSize: 12, color: AppColors.text),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapAppt()),
                );
              },
              child: const Text('Calculer un tarif'),
            ),
          ),
          const SizedBox(height: 12),
          if (characteristics.isNotEmpty)
            _buildInfoCard('Caracteristiques', characteristics),
          if (advantages.isNotEmpty) _buildInfoCard('Avantages', advantages),
        ],
      ),
      bottomNavigationBar: const NavBottom(),
    );
  }
}
