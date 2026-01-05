import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/View/SideBar/AmnMaNatio.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'Entreprise.dart';

class Produit extends StatelessWidget {
  const Produit({super.key});

  Widget _buildCategoryCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppGradients.hero,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nos produits',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Decouvrez les solutions Amana pour chaque besoin.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCategoryCard(
            title: 'Particuliers & professionnels',
            subtitle: 'Messagerie, e-commerce et international.',
            icon: Icons.local_shipping,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PartiProf()),
              );
            },
          ),
          _buildCategoryCard(
            title: 'Entreprises',
            subtitle: 'Offres dediees aux entreprises.',
            icon: Icons.apartment,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EntrepBut()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: const NavBottom(),
    );
  }
}

class PartiProf extends StatelessWidget {
  const PartiProf({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppGradients.hero,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Particuliers & pros',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Choisissez un service pour en savoir plus.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildServiceCard(
            context,
            title: 'Amana messagerie nationale',
            icon: Icons.storefront,
            page: const DefinitionPage(),
          ),
          _buildServiceCard(
            context,
            title: 'E-commerce',
            icon: Icons.shopping_bag,
            page: const Ecommerce(),
          ),
          _buildServiceCard(
            context,
            title: 'Amana international',
            icon: Icons.public,
            page: const AmanaInter(),
          ),
          _buildServiceCard(
            context,
            title: 'Postcolis',
            icon: Icons.markunread_mailbox_outlined,
            page: const Postcolis(),
          ),
        ],
      ),
      bottomNavigationBar: const NavBottom(),
    );
  }
}

class EntrepBut extends StatelessWidget {
  const EntrepBut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppGradients.hero,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Entreprises',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Services dedies aux entreprises et reseaux.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildServiceCard(
            context,
            title: 'Amana messagerie nationale',
            icon: Icons.storefront,
            page: const Amanamesager(),
          ),
          _buildServiceCard(
            context,
            title: 'Amana logistics',
            icon: Icons.inventory_2_outlined,
            page: const Amanamesager(),
          ),
        ],
      ),
      bottomNavigationBar: const NavBottom(),
    );
  }
}

Widget _buildServiceCard(
  BuildContext context, {
  required String title,
  required IconData icon,
  required Widget page,
}) {
  return Card(
    child: ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    ),
  );
}
