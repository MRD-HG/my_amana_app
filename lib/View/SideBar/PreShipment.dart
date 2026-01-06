import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/core/bootstrap/app_repositories.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'package:my_amana_app/features/pre_shipment/models/pre_shipment.dart';
import 'package:my_amana_app/features/pre_shipment/pre_shipment_repository.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PreShipmentPage extends StatefulWidget {
  const PreShipmentPage({super.key});

  @override
  State<PreShipmentPage> createState() => _PreShipmentPageState();
}

class _PreShipmentPageState extends State<PreShipmentPage> {
  final PreShipmentRepository _repository = AppRepositories.preShipment;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _senderName = TextEditingController();
  final TextEditingController _senderCity = TextEditingController();
  final TextEditingController _receiverName = TextEditingController();
  final TextEditingController _receiverCity = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  String _serviceType = 'Standard';
  bool _isSubmitting = false;

  @override
  void dispose() {
    _senderName.dispose();
    _senderCity.dispose();
    _receiverName.dispose();
    _receiverCity.dispose();
    _weight.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final weight = double.tryParse(_weight.text.trim().replaceAll(',', '.')) ?? 0;
    setState(() => _isSubmitting = true);

    try {
      final pre = await _repository.createPreShipment(
        senderName: _senderName.text.trim(),
        senderCity: _senderCity.text.trim(),
        receiverName: _receiverName.text.trim(),
        receiverCity: _receiverCity.text.trim(),
        serviceType: _serviceType,
        weightKg: weight,
      );

      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (_) => _QrDialog(preShipment: pre),
      );

      _senderName.clear();
      _senderCity.clear();
      _receiverName.clear();
      _receiverCity.clear();
      _weight.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pre-shipment created.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to create pre-shipment.')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pre-shipment (Generate QR)',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    _twoFields(
                      left: TextFormField(
                        controller: _senderName,
                        decoration: const InputDecoration(labelText: 'Sender name'),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                      right: TextFormField(
                        controller: _senderCity,
                        decoration: const InputDecoration(labelText: 'Sender city'),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _twoFields(
                      left: TextFormField(
                        controller: _receiverName,
                        decoration: const InputDecoration(labelText: 'Receiver name'),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                      right: TextFormField(
                        controller: _receiverCity,
                        decoration: const InputDecoration(labelText: 'Receiver city'),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _serviceType,
                      items: const [
                        DropdownMenuItem(value: 'Standard', child: Text('Standard')),
                        DropdownMenuItem(value: 'Express', child: Text('Express')),
                        DropdownMenuItem(value: 'EMS', child: Text('EMS')),
                        DropdownMenuItem(value: 'International', child: Text('International')),
                      ],
                      onChanged: _isSubmitting ? null : (v) => setState(() => _serviceType = v ?? 'Standard'),
                      decoration: const InputDecoration(labelText: 'Service type'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _weight,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Weight (kg)'),
                      validator: (v) {
                        final value = double.tryParse((v ?? '').trim().replaceAll(',', '.')) ?? 0;
                        if (value <= 0) return 'Enter a valid weight.';
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isSubmitting ? null : _submit,
                        icon: const Icon(Icons.qr_code_2),
                        label: Text(_isSubmitting ? 'Generating...' : 'Generate QR'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _twoFields({required Widget left, required Widget right}) {
    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 10),
        Expanded(child: right),
      ],
    );
  }
}

class _QrDialog extends StatelessWidget {
  const _QrDialog({required this.preShipment});

  final PreShipment preShipment;

  @override
  Widget build(BuildContext context) {
    final qrPayload = preShipment.id;
    return AlertDialog(
      title: const Text('Your QR code'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QrImageView(
            data: qrPayload,
            size: 220,
            errorCorrectionLevel: QrErrorCorrectLevel.M,
          ),
          const SizedBox(height: 10),
          Text(
            'Reference: ${preShipment.id}',
            style: TextStyle(color: AppColors.mutedText),
          ),
          const SizedBox(height: 6),
          Text(
            '${preShipment.senderCity} → ${preShipment.receiverCity} • ${preShipment.serviceType} • ${preShipment.weightKg.toStringAsFixed(1)}kg',
            style: TextStyle(color: AppColors.mutedText, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
