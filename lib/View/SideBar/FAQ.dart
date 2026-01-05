import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

class FaQ extends StatefulWidget {
  const FaQ({super.key});

  @override
  State<FaQ> createState() => _FaQState();
}

class _FaQState extends State<FaQ> {
  final List<Map<String, String>> _items = const [
    {
      'question': "Comment puis-je m'assurer que mon colis a bien ete recu ?",
      'answer':
          "Suivez votre envoi sur le site bam-tracking.barid.ma ou activez la notification de livraison.",
    },
    {
      'question': 'Comment beneficier du service de contre remboursement ?',
      'answer': 'Ce service est disponible en agence. Demandez-le lors du depot.',
    },
    {
      'question': 'Quels sont les delais de livraison ?',
      'answer':
          'Les delais varient selon la destination. Les envois nationaux sont souvent livres en 24/48h.',
    },
    {
      'question': 'Comment contacter le support ?',
      'answer': "Appelez le centre d'appel au 080 200 60 60.",
    },
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
            'FAQ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Reponses rapides a vos questions.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
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
          for (final item in _items)
            Card(
              child: ExpansionTile(
                title: Text(item['question']!),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      item['answer']!,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              Chip(label: Text('FAQ')),
              Chip(label: Text('General')),
              Chip(label: Text('Depot')),
              Chip(label: Text('Livraison')),
            ],
          ),
        ],
      ),
    );
  }
}
