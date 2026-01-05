import 'package:flutter/material.dart';
import 'package:my_amana_app/View/pagesSplish/geolocal.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

class pageMenu extends StatelessWidget {
  const pageMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppCode(),
    );
  }
}

class AppCode extends StatelessWidget {
  const AppCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 32),
          Image.asset('assets/images/trackingLogo.jpg', height: 160),
          const SizedBox(height: 24),
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
                  'Tracking',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Suivez vos envois en temps reel.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Activez la localisation pour trouver les agences proches.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppColors.mutedText),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Geolocalistion()),
                );
              },
              child: const Text('Continuer'),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Geolocalistion()),
              );
            },
            child: const Text('Passer cette etape'),
          ),
        ],
      ),
    );
  }
}
