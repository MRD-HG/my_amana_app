import 'package:flutter/material.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  bool _switchValue = true;

  Widget _buildChannelCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 18),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 11, color: AppColors.mutedText),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: AppGradients.hero,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(16),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Parlez a notre equipe, nous repondons vite.',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildChannelCard(
                icon: Icons.call_outlined,
                title: 'Telephone',
                subtitle: '05 00 00 00',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildChannelCard(
                icon: Icons.chat_bubble_outline,
                title: 'Chat',
                subtitle: 'Disponible 8h-20h',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(height: 4),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Nom et prenom',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.mail_outline),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Numero de telephone',
                    prefixIcon: Icon(Icons.call_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Numero de suivi',
                    prefixIcon: Icon(Icons.local_shipping_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Objet',
                    prefixIcon: Icon(Icons.chat_bubble_outline),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Message',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.message_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromARGB(255, 123, 123, 123),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "J'accepte les termes et conditions",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Switch(
                        value: _switchValue,
                        onChanged: (value) {
                          setState(() {
                            _switchValue = value;
                          });
                        },
                        activeTrackColor: AppColors.primary,
                        activeColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                        inactiveThumbColor: Colors.grey,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('ENVOYER'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryDark,
                      side: const BorderSide(color: AppColors.primaryDark),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('CONTACTER UN COMMERCIAL'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
