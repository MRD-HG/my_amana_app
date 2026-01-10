import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_amana_app/View/SideBar/MyTrackings.dart';
import 'package:my_amana_app/View/resultat.dart';
import 'package:my_amana_app/core/local/prefs_store.dart';
import 'package:my_amana_app/core/storage/local_store.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'package:my_amana_app/core/widgets/tracking_search_card.dart';
import 'package:my_amana_app/features/my_trackings/models/saved_tracking.dart';
import 'package:my_amana_app/features/my_trackings/my_trackings_store.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class Accueila extends StatefulWidget {
  const Accueila({super.key});

  @override
  State<Accueila> createState() => _AccueilaState();
}

class _AccueilaState extends State<Accueila> {
  final TextEditingController _trackingController = TextEditingController();

  int _activeSlide = 0;
  int _trackingsCount = 0;
  int _shipmentsCount = 0;
  int _ticketsCount = 0;

  List<SavedTracking> _recentTrackings = const [];

  final List<String> _carouselImages = const [
    'assets/images/scroller1.jpg',
    'assets/images/scroller2.jpg',
    'assets/images/scroller3.jpg',
    'assets/images/scroller4.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  @override
  void dispose() {
    _trackingController.dispose();
    super.dispose();
  }

  Future<void> _loadDashboard() async {
    try {
      // 1) Saved trackings
      final store = await MyTrackingsStore.create();
      final trackings = await store.loadAll();
      trackings.sort((a, b) => b.lastViewedAt.compareTo(a.lastViewedAt));

      // 2) Other local demo data
      final preShipments = await PrefsStore.readList('pre_shipments_v1');
      final tickets = await PrefsStore.readList('support_tickets_v1');

      if (!mounted) return;
      setState(() {
        _recentTrackings = trackings.take(5).toList();
        _trackingsCount = trackings.length;
        _shipmentsCount = preShipments.length;
        _ticketsCount = tickets.length;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _recentTrackings = [];
        _trackingsCount = 0;
        _shipmentsCount = 0;
        _ticketsCount = 0;
      });
    }
  }

  Future<void> _navigateToResult(String trackingNumber) async {
    final trimmed = trackingNumber.trim();
    if (trimmed.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer un numéro de suivi.')),
      );
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Resultat(trackingId: trimmed)),
    );

    // Refresh dashboard after returning (history may have changed)
    await _loadDashboard();
  }

  void _onScan() {
    _scanAndNavigate();
  }

  Future<void> _scanAndNavigate() async {
    final result = await SimpleBarcodeScanner.scanBarcode(context);
    if (!mounted) return;

    final trimmed = (result ?? '').trim();
    if (trimmed.isEmpty || trimmed == '-1') return;


    _trackingController.text = trimmed;
    await _navigateToResult(trimmed);
  }

  String _formatShortDate(DateTime dt) {
    final d = dt.toLocal();
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yyyy = d.year.toString();
    return '$dd/$mm/$yyyy';
  }

  Widget _buildCarousel(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CarouselSlider.builder(
            itemCount: _carouselImages.length,
            itemBuilder: (context, index, realIndex) {
              final asset = _carouselImages[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(asset, fit: BoxFit.fill),
                  // Soft overlay for readability
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.45),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 14,
                    right: 14,
                    bottom: 12,
                    child: Text(
                      'Suivez vos colis, préparez vos envois, et gardez tout sous contrôle.',
                      style: AppTheme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              );
            },
            options: CarouselOptions(
              height: 200,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayCurve: Curves.easeInOut,
              onPageChanged: (index, reason) => setState(() => _activeSlide = index),
            ),
          ),
        ),
        const SizedBox(height: 10),
        AnimatedSmoothIndicator(
          activeIndex: _activeSlide,
          count: _carouselImages.length,
          effect: const ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            expansionFactor: 3,
            spacing: 6,
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required String label,
    required int value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.border),
          boxShadow: AppTheme.shadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppTheme.primary, size: 20),
            ),
            const SizedBox(height: 10),
            Text(
              value.toString(),
              style: AppTheme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 2),
            Text(label, style: AppTheme.textTheme.bodySmall?.copyWith(color: AppTheme.muted)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            icon: Icons.qr_code_2_rounded,
            label: 'Suivis',
            value: _trackingsCount,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const MyTrackingsPage()),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: Icons.local_shipping_outlined,
            label: 'Envois',
            value: _shipmentsCount,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: Icons.support_agent_outlined,
            label: 'Tickets',
            value: _ticketsCount,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentHistory() {
    if (_recentTrackings.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.border),
          boxShadow: AppTheme.shadow,
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppTheme.secondary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.history_rounded),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Aucun suivi enregistré pour le moment. Faites une recherche et vous le retrouverez ici.',
                style: AppTheme.textTheme.bodyMedium?.copyWith(color: AppTheme.muted),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
        boxShadow: AppTheme.shadow,
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _recentTrackings.length,
        separatorBuilder: (_, __) => Divider(height: 1, color: AppTheme.border),
        itemBuilder: (context, i) {
          final t = _recentTrackings[i];
          final last = _formatShortDate(t.lastViewedAt);
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            title: Text(
              t.label.trim().isEmpty ? t.id : t.label,
              style: AppTheme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              'Numéro: ${t.id}\nDernière consultation: $last',
              style: AppTheme.textTheme.bodySmall?.copyWith(color: AppTheme.muted, height: 1.3),
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => _navigateToResult(t.id),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadDashboard,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          _buildCarousel(context),
          const SizedBox(height: 14),
          _buildStatsRow(),
          const SizedBox(height: 16),
          TrackingSearchCard(
            controller: _trackingController,
            onSearch: () => _navigateToResult(_trackingController.text),
            onScan: _onScan,
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Historique récent',
                  style: AppTheme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MyTrackingsPage()),
                ),
                child: const Text('Voir tout'),
              ),
            ],
          ),
          _buildRecentHistory(),
        ],
      ),
    );
  }
}
