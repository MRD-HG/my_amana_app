import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/core/bootstrap/app_repositories.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'package:my_amana_app/features/offers/models/offer.dart';
import 'package:my_amana_app/features/offers/offers_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class OffersNewsPage extends StatefulWidget {
  const OffersNewsPage({super.key});

  @override
  State<OffersNewsPage> createState() => _OffersNewsPageState();
}

class _OffersNewsPageState extends State<OffersNewsPage> {
  final OffersRepository _repository = AppRepositories.offers;
  late Future<List<Offer>> _future;

  @override
  void initState() {
    super.initState();
    _future = _repository.fetchOffers();
  }

  Future<void> _refresh() async {
    setState(() {
      _future = _repository.fetchOffers();
    });
    await _future;
  }

  Future<void> _openLink(String url) async {
    final trimmed = url.trim();
    if (trimmed.isEmpty) return;
    final uri = Uri.tryParse(trimmed);
    if (uri == null) return;
    if (!await canLaunchUrl(uri)) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Offer>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Unable to load offers. Please try again.',
                    style: TextStyle(color: AppColors.mutedText),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            final offers = snapshot.data ?? [];
            if (offers.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'No promotions available right now.',
                    style: TextStyle(color: AppColors.mutedText),
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: offers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final offer = offers[index];
                return Card(
                  child: ListTile(
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.local_offer, color: AppColors.primary),
                    ),
                    title: Text(
                      offer.title.isEmpty ? 'Promotion' : offer.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      offer.summary.isEmpty ? 'Tap to view details' : offer.summary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OfferDetailsPage(offer: offer, onOpenLink: _openLink),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class OfferDetailsPage extends StatelessWidget {
  const OfferDetailsPage({
    super.key,
    required this.offer,
    required this.onOpenLink,
  });

  final Offer offer;
  final Future<void> Function(String url) onOpenLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(offer.title.isEmpty ? 'Offer' : offer.title),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.title.isEmpty ? 'Promotion' : offer.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    offer.summary.isEmpty ? 'No description provided.' : offer.summary,
                    style: TextStyle(color: AppColors.mutedText),
                  ),
                  const SizedBox(height: 14),
                  if (offer.linkUrl.trim().isNotEmpty)
                    ElevatedButton.icon(
                      onPressed: () => onOpenLink(offer.linkUrl),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Open'),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
