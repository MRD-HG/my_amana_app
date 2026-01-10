import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'package:my_amana_app/core/widgets/action_button.dart';

class PreShipment extends StatefulWidget {
  const PreShipment({super.key});

  @override
  State<PreShipment> createState() => _PreShipmentState();
}

class _PreShipmentState extends State<PreShipment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _shippingMethods = const [
    'En agence',
    'À domicile',
  ];

  String _selectedShippingMethod = 'En agence';
  DateTime? _pickupDate;

  // Simple demo form fields
  final TextEditingController _receiverName = TextEditingController();
  final TextEditingController _receiverPhone = TextEditingController();
  final TextEditingController _receiverCity = TextEditingController();
  final TextEditingController _receiverAddress = TextEditingController();
  final TextEditingController _weightKg = TextEditingController();

  @override
  void dispose() {
    _receiverName.dispose();
    _receiverPhone.dispose();
    _receiverCity.dispose();
    _receiverAddress.dispose();
    _weightKg.dispose();
    super.dispose();
  }

  Future<void> _selectPickupDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (pickedDate == null) return;

    if (!mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now.add(const Duration(hours: 2))),
    );
    if (pickedTime == null) return;

    setState(() {
      _pickupDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  double _parseWeight() {
    final raw = _weightKg.text.trim().replaceAll(',', '.');
    return double.tryParse(raw) ?? 0;
  }

  double _estimatePrice() {
    final w = _parseWeight();
    final base = 25.0;
    final perKg = 7.5;
    final pickupFee = _selectedShippingMethod == 'À domicile' ? 10.0 : 0.0;
    return (base + (w * perKg) + pickupFee).clamp(25.0, 9999.0);
  }

  bool get _isFormValid {
    if (_receiverName.text.trim().isEmpty) return false;
    if (_receiverPhone.text.trim().isEmpty) return false;
    if (_receiverCity.text.trim().isEmpty) return false;
    if (_selectedShippingMethod == 'À domicile' && _pickupDate == null) return false;
    return true;
  }

  String _formatPickup(DateTime dt) {
    final d = dt;
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yyyy = d.year.toString();
    final hh = d.hour.toString().padLeft(2, '0');
    final min = d.minute.toString().padLeft(2, '0');
    return '$dd/$mm/$yyyy • $hh:$min';
  }

  void _submit() {
    if (!_isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez compléter les informations requises.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pré-expédition enregistrée (démo).')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final estimate = _estimatePrice();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF7F8FB),
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Retour',
        ),
        title: const Text('Pré-expédition'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            tooltip: 'Menu',
          ),
        ],
      ),
      endDrawer: darweF(context),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          _HeroCard(
            title: 'Créez votre bordereau',
            subtitle: 'Préparez un envoi en quelques secondes et suivez-le facilement.',
            trailing: const Icon(Icons.local_shipping_rounded, size: 28, color: Colors.white),
          ),
          const SizedBox(height: 14),

          _Section(
            title: 'Mode de dépôt',
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _shippingMethods.map((m) {
                final selected = _selectedShippingMethod == m;
                return ChoiceChip(
                  label: Text(m),
                  selected: selected,
                  onSelected: (_) {
                    setState(() {
                      _selectedShippingMethod = m;
                      if (_selectedShippingMethod != 'À domicile') {
                        _pickupDate = null;
                      }
                    });
                  },
                  selectedColor: AppTheme.primary.withOpacity(0.15),
                  labelStyle: TextStyle(
                    color: selected ? AppTheme.primary : Colors.black87,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                    side: BorderSide(color: selected ? AppTheme.primary : const Color(0xFFE6E8EF)),
                  ),
                );
              }).toList(),
            ),
          ),

          if (_selectedShippingMethod == 'À domicile') ...[
            const SizedBox(height: 14),
            _Section(
              title: 'Rendez-vous de ramassage',
              child: Column(
                children: [
                  InkWell(
                    onTap: _selectPickupDate,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: AppTheme.cardDecoration,
                      child: Row(
                        children: [
                          const Icon(Icons.event_available_rounded, color: AppTheme.primary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _pickupDate == null ? 'Choisir une date et une heure' : _formatPickup(_pickupDate!),
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, color: Colors.black45),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Astuce : choisissez un créneau où quelqu\'un peut remettre le colis au livreur.',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 14),
          _Section(
            title: 'Destinataire',
            child: Column(
              children: [
                _Field(
                  controller: _receiverName,
                  label: 'Nom complet *',
                  icon: Icons.person_rounded,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                _Field(
                  controller: _receiverPhone,
                  label: 'Téléphone *',
                  icon: Icons.phone_rounded,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                _Field(
                  controller: _receiverCity,
                  label: 'Ville *',
                  icon: Icons.location_city_rounded,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                _Field(
                  controller: _receiverAddress,
                  label: 'Adresse (optionnel)',
                  icon: Icons.home_rounded,
                  maxLines: 2,
                  keyboardType: TextInputType.streetAddress,
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),
          _Section(
            title: 'Colis',
            child: Column(
              children: [
                _Field(
                  controller: _weightKg,
                  label: 'Poids estimé (kg)',
                  icon: Icons.scale_rounded,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: AppTheme.cardDecoration,
                  child: Row(
                    children: [
                      const Icon(Icons.price_change_rounded, color: AppTheme.primary),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Estimation',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '${estimate.toStringAsFixed(0)} MAD',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),
          ActionButton(
            label: 'Générer le bordereau',
            leading: const Icon(Icons.qr_code_rounded),
            onPressed: _isFormValid ? _submit : null,
          ),
          const SizedBox(height: 10),
          const Text(
            'En mode démo, aucune donnée n\'est envoyée en ligne.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, AppTheme.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withOpacity(0.25),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: trailing,
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.cardDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: AppTheme.primary),
          hintText: label,
        ),
      ),
    );
  }
}
