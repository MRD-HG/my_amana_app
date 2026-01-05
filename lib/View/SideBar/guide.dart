import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

class GuideBonn extends StatelessWidget {
  const GuideBonn({super.key});

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
                  'Guide des bonnes pratiques',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Conseils pour preparer et envoyer vos colis.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.inventory_2_outlined),
                  title: Text('Emballez solidement vos colis'),
                  subtitle: Text('Utilisez un carton adapte et renforcez les coins.'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.assignment_turned_in_outlined),
                  title: Text('Verifiez les documents'),
                  subtitle: Text('Ajoutez les informations necessaires pour le suivi.'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.schedule_outlined),
                  title: Text('Deposez avant l horaire limite'),
                  subtitle: Text('Assurez-vous d un passage en agence avant fermeture.'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBottom(),
    );
  }
}
