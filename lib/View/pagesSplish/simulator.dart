import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/View/Facteure/LogFact.dart';
import 'package:my_amana_app/View/PageMenu.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

class Simulateur extends StatelessWidget {
  const Simulateur({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(24),
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
                  'Simulateur de tarif',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Estimez le prix de vos envois en quelques secondes.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Image.asset(
            'assets/images/Calulator.jpg',
            width: 160,
            height: 160,
          ),
          const SizedBox(height: 24),
          const Text(
            'Calculer le tarif de vos envois',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: AppColors.mutedText),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AppShell()),
                );
              },
              child: const Text('Allons-y'),
            ),
          ),
        ],
      ),
    );
  }
}

class Choisir extends StatelessWidget {
  const Choisir({super.key});

  Widget _buildChoiceCard({
    required String label,
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
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 24),
          Image.asset('assets/images/logoProAmana.png', height: 120),
          const SizedBox(height: 16),
          const Text(
            'Bienvenue sur My Amana',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          const Text(
            'Choisissez votre espace pour continuer.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppColors.mutedText),
          ),
          const SizedBox(height: 24),
          _buildChoiceCard(
            label: 'Client',
            icon: Icons.person_outline,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const pageMenu()),
              );
            },
          ),
          _buildChoiceCard(
            label: 'Facteur',
            icon: Icons.local_shipping_outlined,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
          ),
        ],
      ),
    );
  }
}
