import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

class Guide extends StatelessWidget {
  const Guide({super.key});

  static const List<String> _interdits = [
    'Animaux vivants',
    'Plantes vivantes',
    'Armes et projectiles',
    'Couteaux et sabres',
    'Produits chimiques',
    'Liquides inflammables',
    'Substances radioactives',
    'Matieres toxiques et infectieuses',
    'Stupefiants et drogues',
    'Articles portant atteinte a la moralite',
    'Objets dangereux pour les agents',
    'Pornographie',
    'Antiquites',
    'Alcool (sauf boissons autorisees)',
    'Metaux et pierres precieuses',
    'Argents et billets de banque',
    'Fourrures animales',
    'Depouilles ou cendres humaines',
    'Sorcellerie et talismans',
    'Prelevement de sang',
    'Marchandises contrefaites',
    'Parfums',
    'Derives de porc vers pays musulmans',
    'Batteries et piles au lithium',
  ];

  static const List<String> _conditionnels = [
    'Produits dangereux avec fiche MSDS',
    'Produits chimiques et liquides industriels',
    'Produits pharmaceutiques avec ordonnance',
    'Antiquites avec autorisation ministerielle',
    'Plantes cosmetiques avec autorisation phytosanitaire',
    'Fossiles avec autorisation',
    'Produits cosmetiques soumis a controle',
    "Passeports avec autorisation du Ministere de l'interieur",
    'Cassettes video avec controle de contenu',
    'Produits perissables avec emballage specifique',
  ];

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
            'Produits prohibes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Liste des envois interdits ou conditionnels.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildListCard(String title, List<String> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 12),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.block, color: AppColors.primary, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
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
          _buildListCard('Interdits a l\'export', _interdits),
          _buildListCard(
            'Admis conditionnellement',
            _conditionnels,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Les envois Amana a l'etranger sont soumis a un controle douanier.",
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBottom(),
    );
  }
}
