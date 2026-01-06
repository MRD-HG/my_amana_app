import 'package:flutter/material.dart';
import 'package:my_amana_app/View/SideBar/MyTrackings.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'package:my_amana_app/core/widgets/tracking_search_card.dart';
import 'package:my_amana_app/features/my_trackings/models/saved_tracking.dart';
import 'package:my_amana_app/features/my_trackings/my_trackings_store.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../resultat.dart';

class Accueila extends StatefulWidget {
  const Accueila({super.key});

  @override
  State<Accueila> createState() => _AccueilaState();
}

class _AccueilaState extends State<Accueila> {
  final TextEditingController _trackingController = TextEditingController();

  late final Future<MyTrackingsStore> _storeFuture;
  late Future<List<SavedTracking>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _storeFuture = MyTrackingsStore.create();
    _historyFuture = _loadHistory();
  }

  Future<List<SavedTracking>> _loadHistory() async {
    final store = await _storeFuture;
    final items = await store.loadAll();
    return items.take(5).toList();
  }

  Future<void> _refreshHistory() async {
    setState(() => _historyFuture = _loadHistory());
    await _historyFuture;
  }

  @override
  void dispose() {
    _trackingController.dispose();
    super.dispose();
  }

  Future<void> _submitTracking() async {
    final trackingId = _trackingController.text.trim();
    if (trackingId.isEmpty || trackingId.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez saisir un numero de suivi valide.'),
        ),
      );
      return;
    }

    final store = await _storeFuture;
    await store.saveViewed(trackingId);

    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Resultat(trackingId: trackingId),
      ),
    );
    await _refreshHistory();
  }

  Future<void> _scanTracking() async {
    final scanned = await Navigator.push<String?>(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(
          cancelButtonText: 'Annuler',
          isShowFlashIcon: true,
        ),
      ),
    );

    final value = (scanned ?? '').trim();
    if (value.isEmpty || value == '-1') {
      return;
    }

    _trackingController.text = value;

    final store = await _storeFuture;
    await store.saveViewed(value);

    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Resultat(trackingId: value),
      ),
    );
    await _refreshHistory();
  }

  void _openHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MyTrackingsPage()),
    ).then((_) => _refreshHistory());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TrackingSearchCard(
            controller: _trackingController,
            onSearch: _submitTracking,
            onScan: _scanTracking,
            trailing: InkWell(
              onTap: _openHistory,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '+ Historique',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            hintText: 'Scanner ou saisir votre code',
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Historique recent',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
              ),
              TextButton(
                onPressed: _openHistory,
                child: const Text('Voir tout'),
              )
            ],
          ),
          const SizedBox(height: 8),
          FutureBuilder<List<SavedTracking>>(
            future: _historyFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(12),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final items = snapshot.data ?? [];
              if (items.isEmpty) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: const [
                        Icon(Icons.history, color: AppColors.primary),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Aucun historique pour le moment.',
                            style: TextStyle(color: AppColors.mutedText),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Column(
                children: items.map((item) {
                  return Card(
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.local_shipping, color: AppColors.primary, size: 18),
                      ),
                      title: Text(item.label, style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(item.id, style: TextStyle(color: AppColors.mutedText)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () async {
                        final store = await _storeFuture;
                        await store.saveViewed(item.id);
                        if (!mounted) return;
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => Resultat(trackingId: item.id)),
                        );
                        await _refreshHistory();
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
