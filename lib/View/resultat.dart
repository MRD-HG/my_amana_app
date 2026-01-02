import 'package:flutter/material.dart';

import 'Menu/MenuSide.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
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

  Widget _stageIcon(
    IconData icon,
    bool active,
    Color activeColor,
    Color inactiveColor,
  ) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: active ? activeColor : inactiveColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: active ? Colors.white : Colors.black54,
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
    final activeColor = AppColors.primary;
    final inactiveColor = Colors.grey.shade300;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: AppGradients.hero,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.id,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${latest.description} - ${latest.location}',
                      style: const TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '${info.weightKg.toStringAsFixed(1)} KG',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          info.service,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Paiement a la livraison',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        const Spacer(),
                        Text(
                          '${info.codAmount.toStringAsFixed(0)} DH',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      formatTrackingTimestamp(latest.timestamp),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _stageIcon(
                Icons.storefront,
                _hasStage(info, TrackingStage.accepted),
                activeColor,
                inactiveColor,
              ),
              _stageIcon(
                Icons.place,
                _hasStage(info, TrackingStage.inTransit),
                activeColor,
                inactiveColor,
              ),
              _stageIcon(
                Icons.local_shipping,
                _hasStage(info, TrackingStage.outForDelivery),
                activeColor,
                inactiveColor,
              ),
              _stageIcon(
                Icons.check_circle,
                _hasStage(info, TrackingStage.delivered),
                activeColor,
                inactiveColor,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Information sur l'expedition",
              style: TextStyle(
                color: AppColors.mutedText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: info.events.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final event = info.events[index];
              return Card(
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.local_shipping, color: AppColors.primary),
                  ),
                  title: Text(event.description),
                  subtitle: Text(event.location),
                  trailing: Text(
                    formatTrackingTimestamp(event.timestamp),
                    style: const TextStyle(fontSize: 10),
                  ),
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
