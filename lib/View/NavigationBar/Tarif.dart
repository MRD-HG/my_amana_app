import 'package:flutter/material.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'package:my_amana_app/features/tarif/tarif_service.dart';
import 'package:my_amana_app/core/widgets/action_button.dart';

class MapAppt extends StatefulWidget {
  const MapAppt({super.key});

  @override
  State<MapAppt> createState() => _MapAppState();
}

class _MapAppState extends State<MapAppt> {
  bool envoiNatio = true;
  bool envioInterna = false;
  bool ecomerse = false;

  final TarifService _tarifService = TarifService();
  final TextEditingController _nationalWeightController =
      TextEditingController();
  final TextEditingController _internationalWeightController =
      TextEditingController();
  final TextEditingController _ecommerceWeightController =
      TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  double? _nationalResult;
  double? _internationalResult;
  double? _ecommerceResult;

  int selectedOption = 1;

  void _selectCategory(int index) {
    setState(() {
      envoiNatio = index == 0;
      envioInterna = index == 1;
      ecomerse = index == 2;
    });
  }

  @override
  void dispose() {
    _nationalWeightController.dispose();
    _internationalWeightController.dispose();
    _ecommerceWeightController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  double? _parsePositiveDouble(String value) {
    final parsed = double.tryParse(value.trim());
    if (parsed == null || parsed <= 0) {
      return null;
    }
    return parsed;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _calculateNational() {
    final weight = _parsePositiveDouble(_nationalWeightController.text);
    if (weight == null) {
      _showError('Saisissez un poids valide.');
      return;
    }
    setState(() {
      _nationalResult = _tarifService.calculate(
        type: TarifType.national,
        weightKg: weight,
      );
    });
  }

  void _calculateInternational() {
    final weight = _parsePositiveDouble(_internationalWeightController.text);
    if (weight == null) {
      _showError('Saisissez un poids valide.');
      return;
    }
    final length = _parsePositiveDouble(_lengthController.text);
    final width = _parsePositiveDouble(_widthController.text);
    final height = _parsePositiveDouble(_heightController.text);

    setState(() {
      _internationalResult = _tarifService.calculate(
        type: TarifType.international,
        weightKg: weight,
        lengthCm: length,
        widthCm: width,
        heightCm: height,
      );
    });
  }

  void _calculateEcommerce() {
    final weight = _parsePositiveDouble(_ecommerceWeightController.text);
    if (weight == null) {
      _showError('Saisissez un poids valide.');
      return;
    }
    setState(() {
      _ecommerceResult = _tarifService.calculate(
        type: TarifType.ecommerce,
        weightKg: weight,
      );
    });
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppGradients.hero,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Calculer un tarif',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Estimez vos envois nationaux, internationaux ou e-commerce.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary
                : AppColors.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.28),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.white : AppColors.text,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow() {
    return Row(
      children: [
        _buildCategoryButton(
          label: 'ENVOI\nNATIONAL',
          selected: envoiNatio,
          onTap: () => _selectCategory(0),
        ),
        const SizedBox(width: 8),
        _buildCategoryButton(
          label: 'ENVOI\nINTERNA',
          selected: envioInterna,
          onTap: () => _selectCategory(1),
        ),
        const SizedBox(width: 8),
        _buildCategoryButton(
          label: 'E-COMMERCE',
          selected: ecomerse,
          onTap: () => _selectCategory(2),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.mutedText,
          ),
        ),
      ],
    );
  }

  Widget _buildResultBanner(double value) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Tarif estime: ${value.toStringAsFixed(2)} DH',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackagingRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.mutedText.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Type d'emballage",
              style: TextStyle(fontSize: 12),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.accent,
              textStyle: const TextStyle(fontSize: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Sans emballage'),
          ),
        ],
      ),
    );
  }

  Widget _buildNationalSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(
              'Envoi national',
              'Estimez un envoi partout au Maroc.',
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nationalWeightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Poids (kg)',
                prefixIcon: Icon(Icons.scale_outlined),
              ),
            ),
            const SizedBox(height: 12),
            _buildPackagingRow(),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ActionButton(
                label: 'Calculer',
                onPressed: _calculateNational,
              ),
            ),
            if (_nationalResult != null) _buildResultBanner(_nationalResult!),
          ],
        ),
      ),
    );
  }

  Widget _buildInternationalSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(
              'Envoi international',
              'Indiquez le poids et les dimensions.',
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _internationalWeightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Poids (kg)',
                prefixIcon: Icon(Icons.scale_outlined),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Pays de destination',
                prefixIcon: Icon(Icons.public),
              ),
            ),
            const SizedBox(height: 12),
            _buildPackagingRow(),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _lengthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Longueur'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _widthController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Largeur'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Hauteur'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ActionButton(
                label: 'Calculer',
                onPressed: _calculateInternational,
              ),
            ),
            if (_internationalResult != null)
              _buildResultBanner(_internationalResult!),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label, int value) {
    final bool selected = selectedOption == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() {
          selectedOption = value;
        });
      },
      selectedColor: AppColors.primary.withOpacity(0.2),
      backgroundColor: AppColors.surface,
      labelStyle: TextStyle(
        color: selected ? AppColors.primary : AppColors.text,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget _buildEcommerceSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(
              'E-commerce',
              'Choisissez le mode de livraison et le poids.',
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChoiceChip('INTRAVILLE', 0),
                _buildChoiceChip('DOMICILE', 1),
                _buildChoiceChip('INTERVILLE', 2),
                _buildChoiceChip('EN AGENCE', 3),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _ecommerceWeightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Poids (kg)',
                prefixIcon: Icon(Icons.scale_outlined),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ActionButton(
                label: 'Calculer',
                onPressed: _calculateEcommerce,
              ),
            ),
            if (_ecommerceResult != null) _buildResultBanner(_ecommerceResult!),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildCategoryRow(),
          const SizedBox(height: 16),
          if (envoiNatio) _buildNationalSection(),
          if (envioInterna) _buildInternationalSection(),
          if (ecomerse) _buildEcommerceSection(),
        ],
      ),
    );
  }
}
