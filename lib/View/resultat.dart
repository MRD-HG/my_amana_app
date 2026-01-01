import 'package:flutter/material.dart';

import 'Menu/MenuSide.dart';
import 'package:my_amana_app/features/tracking/tracking_models.dart';
import 'package:my_amana_app/features/tracking/tracking_repository.dart';

class Resultat extends StatefulWidget {
  const Resultat({super.key, required this.trackingId});

  final String trackingId;

  @override
  State<Resultat> createState() => _ResultatState();
}

class _ResultatState extends State<Resultat> {
  final TrackingRepository _repository = const TrackingRepository();
  late Future<TrackingInfo?> _trackingFuture;

  @override
  void initState() {
    super.initState();
    _trackingFuture = _repository.fetchTracking(widget.trackingId);
  }

  bool _hasStage(TrackingInfo info, TrackingStage stage) {
    return info.events.any((event) => event.stage == stage);
  }

  Widget _stageIcon(IconData icon, bool active) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: active ? Colors.white : Colors.black26,
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildNotFound() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.trackingId,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Aucun resultat pour ce numero de suivi.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess(TrackingInfo info) {
    final latest = info.latestEvent;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            elevation: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10),
                  child: Text(
                    info.id,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${latest.description} - ${latest.location}',
                          style: const TextStyle(fontSize: 9),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Text(
                        '${info.weightKg.toStringAsFixed(1)} KG',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Paiement a la livraison',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Text(
                        '${info.codAmount.toStringAsFixed(0)} DH',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    info.service,
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    formatTrackingTimestamp(latest.timestamp),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _stageIcon(
                        Icons.storefront,
                        _hasStage(info, TrackingStage.accepted),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _stageIcon(
                        Icons.place,
                        _hasStage(info, TrackingStage.inTransit),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _stageIcon(
                        Icons.local_shipping,
                        _hasStage(info, TrackingStage.outForDelivery),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _stageIcon(
                        Icons.check_circle,
                        _hasStage(info, TrackingStage.delivered),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Information sur l'expedition",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: info.events.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final event = info.events[index];
              return ListTile(
                title: Text(event.description),
                subtitle: Text(event.location),
                trailing: Text(
                  formatTrackingTimestamp(event.timestamp),
                  style: const TextStyle(fontSize: 10),
                ),
              );
            },
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
      body: FutureBuilder<TrackingInfo?>(
        future: _trackingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoading();
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erreur lors du chargement.'),
            );
          }
          final info = snapshot.data;
          if (info == null) {
            return _buildNotFound();
          }
          return _buildSuccess(info);
        },
      ),
    );
  }
}
