import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/core/bootstrap/app_repositories.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'package:my_amana_app/features/facteur/facteur_repository.dart';
import 'package:my_amana_app/features/facteur/models/facteur_models.dart';
import 'package:my_amana_app/features/tracking/models/tracking_models.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class Facteur extends StatefulWidget {
  const Facteur({super.key, required this.user});

  final FacteurUser user;

  @override
  State<Facteur> createState() => _FacteurState();
}

class _FacteurState extends State<Facteur> {
  final FacteurRepository _repository = AppRepositories.facteur;
  final TextEditingController _locationController = TextEditingController();

  final List<String> _statusOptions = const [
    'Colis accepte',
    'En transit',
    'En cours de livraison',
    'Livre',
  ];

  List<ShipmentSummary> _shipments = [];
  ShipmentSummary? _selectedShipment;
  String _selectedStatus = 'En cours de livraison';
  bool _isLoading = true;
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadShipments();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _loadShipments() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final shipments = await _repository.fetchAssignedShipments(widget.user);
      if (!mounted) {
        return;
      }
      setState(() {
        _shipments = shipments;
        _selectedShipment ??= shipments.isNotEmpty ? shipments.first : null;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage = 'Erreur lors du chargement.';
        _isLoading = false;
      });
    }
  }

  Future<void> _updateStatus() async {
    final shipment = _selectedShipment;
    if (shipment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selectionnez un colis.')),
      );
      return;
    }

    final location = _locationController.text.trim().isNotEmpty
        ? _locationController.text.trim()
        : shipment.receiverCity;

    setState(() {
      _isSaving = true;
    });

    try {
      await _repository.updateShipmentStatus(
        trackingId: shipment.trackingId,
        status: _selectedStatus,
        event: ShipmentEvent(
          stage: trackingStageFromString(_selectedStatus),
          description: _selectedStatus,
          location: location,
          timestamp: DateTime.now(),
        ),
      );
      if (!mounted) {
        return;
      }
      _locationController.clear();
      await _loadShipments();
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Statut mis a jour.')),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible de mettre a jour.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _scanTracking() async {
    final scanned = await SimpleBarcodeScanner.scanBarcode(context);
    if (!mounted) {
      return;
    }
    final value = (scanned ?? '').trim();
    if (value.isEmpty || value == '-1') {
      return;
    }
    final match = _shipments
        .where((shipment) => shipment.trackingId == value)
        .toList();
    if (match.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Colis non trouve.')),
      );
      return;
    }
    setState(() {
      _selectedShipment = match.first;
    });
  }

  Widget _buildShipmentTile(ShipmentSummary shipment) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.local_shipping, color: AppColors.primary),
        ),
        title: Text(shipment.trackingId),
        subtitle: Text(
          '${shipment.senderCity} -> ${shipment.receiverCity}',
          style: const TextStyle(fontSize: 11, color: AppColors.mutedText),
        ),
        trailing: Text(
          shipment.status,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppGradients.hero,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Espace facteur',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Gerez rapidement vos livraisons du jour.',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await _repository.signOut();
                  },
                  icon: const Icon(Icons.logout, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_errorMessage != null)
            Center(child: Text(_errorMessage!))
          else if (_shipments.isEmpty)
            const Center(
              child: Text('Aucune livraison assignee.'),
            )
          else ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    DropdownButtonFormField<ShipmentSummary>(
                      value: _selectedShipment,
                      items: _shipments
                          .map((shipment) => DropdownMenuItem<ShipmentSummary>(
                                value: shipment,
                                child: Text(shipment.trackingId),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedShipment = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Colis assigne',
                        prefixIcon: Icon(Icons.inventory_2_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedStatus,
                      items: _statusOptions
                          .map((status) => DropdownMenuItem<String>(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedStatus = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Nouveau statut',
                        prefixIcon: Icon(Icons.flag_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        hintText: 'Localisation',
                        prefixIcon: Icon(Icons.place_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _scanTracking,
                            icon: const Icon(Icons.qr_code_scanner),
                            label: const Text('Scanner'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isSaving ? null : _updateStatus,
                            child: _isSaving
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                              Colors.white),
                                    ),
                                  )
                                : const Text('Mettre a jour'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Livraisons assignees',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _shipments.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return _buildShipmentTile(_shipments[index]);
              },
            ),
          ],
        ],
      ),
      bottomNavigationBar: const NavBottom(),
    );
  }
}
