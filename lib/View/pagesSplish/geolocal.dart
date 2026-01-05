import 'package:flutter/material.dart';
import 'package:my_amana_app/View/pagesSplish/simulator.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

class Geolocalistion extends StatelessWidget {
  const Geolocalistion({super.key});

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
                  'Geolocalisation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Trouvez l agence Amana la plus proche.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Image.asset('assets/images/geoloca.png', width: 160, height: 160),
          const SizedBox(height: 24),
          const Text(
            'Autorisez la localisation pour des suggestions precises.',
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
                  MaterialPageRoute(builder: (context) => const Simulateur()),
                );
              },
              child: const Text('Continuer'),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Simulateur()),
              );
            },
            child: const Text('Passer cette etape'),
          ),
        ],
      ),
    );
  }
}
