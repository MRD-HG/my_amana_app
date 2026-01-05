import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

class NumeroTlf extends StatefulWidget {
  const NumeroTlf({super.key});

  @override
  State<NumeroTlf> createState() => _NumeroTlfState();
}

class _NumeroTlfState extends State<NumeroTlf> {
  final List<String> _regions = const [
    'Tout',
    'Rabat',
    'Casablanca',
    'Tanger',
    'Fes-Meknes',
    'Oujda',
    'Agadir',
    'Marrakech',
  ];

  List<dynamic> _agents = [];
  String _selectedRegion = 'Tout';

  @override
  void initState() {
    super.initState();
    _loadAgents();
  }

  Future<void> _loadAgents() async {
    final jsonData = await rootBundle.loadString('assets/phone.json');
    final data = json.decode(jsonData) as Map<String, dynamic>;
    final list = data['List'] as List<dynamic>;
    setState(() {
      if (_selectedRegion == 'Tout') {
        _agents = list;
      } else {
        _agents = list
            .where((agent) => agent['Region'] == _selectedRegion)
            .toList();
      }
    });
  }

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
            'Numeros utiles',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Les contacts officiels pour vous aider rapidement.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required String title,
    required String phone,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.call, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
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
                  const SizedBox(height: 6),
                  Text(
                    phone,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgentCard(Map<String, dynamic> agent) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.headset_mic, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    agent['Agent'] ?? 'Commercial',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(agent['Tel'] ?? '-', style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(agent['Email'] ?? '-', style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(agent['Region'] ?? '-', style: const TextStyle(fontSize: 12)),
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
          _buildContactCard(
            title: 'Centre national de debouanement postal',
            phone: 'Tel: 0522 33 91 35',
          ),
          _buildContactCard(
            title: "Centre d'appel",
            phone: 'Tel: 080 200 60 60',
          ),
          _buildContactCard(
            title: 'Numero collecte',
            phone: 'Tel: 0522 34 44 93',
          ),
          const SizedBox(height: 16),
          const Text(
            'Contacter un commercial',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: DropdownButton2<String>(
                isExpanded: true,
                value: _selectedRegion,
                hint: const Text('Region'),
                items: _regions
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRegion = value ?? 'Tout';
                  });
                  _loadAgents();
                },
                buttonStyleData: const ButtonStyleData(
                  height: 48,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  elevation: 0,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (_agents.isEmpty)
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Aucun contact disponible pour cette region.',
                style: TextStyle(color: AppColors.mutedText, fontSize: 12),
              ),
            )
          else
            for (final agent in _agents) _buildAgentCard(agent),
        ],
      ),
      bottomNavigationBar: const NavBottom(),
    );
  }
}
