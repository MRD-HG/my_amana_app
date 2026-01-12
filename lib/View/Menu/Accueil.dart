import 'package:flutter/material.dart';
import 'package:my_amana_app/View/SideBar/MyTrackings.dart';
import 'package:my_amana_app/View/resultat.dart';
import 'package:my_amana_app/core/local/prefs_store.dart';
import 'package:my_amana_app/features/my_trackings/models/saved_tracking.dart';
import 'package:my_amana_app/features/my_trackings/my_trackings_store.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Accueila extends StatefulWidget {
  const Accueila({super.key});

  @override
  State<Accueila> createState() => _AccueilaState();
}

class _AccueilaState extends State<Accueila> {
  // ===== New UI colors =====
  static const Color kOrange = Color(0xFFF36A1D);
  static const Color kTextBlue = Color(0xFF0A6D8C);

  // ===== Controllers / State =====
  final TextEditingController _trackingController = TextEditingController();
  final PageController _bannerController = PageController(viewportFraction: 0.92);

  int _bannerIndex = 0;

  int _trackingsCount = 0;
  int _shipmentsCount = 0;
  int _ticketsCount = 0;

  List<SavedTracking> _recentTrackings = const [];

  // Keep same assets you already use
  final List<String> _banners = const [
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
    _bannerController.dispose();
    super.dispose();
  }

  // ===== Logic stays the same =====
  Future<void> _loadDashboard() async {
    try {
      final store = await MyTrackingsStore.create();
      final trackings = await store.loadAll();
      trackings.sort((a, b) => b.lastViewedAt.compareTo(a.lastViewedAt));

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

    await _loadDashboard();
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

  // ===== Small UI helpers =====
  Widget _shadowCard({required Widget child, EdgeInsets? padding}) {
    return Container(
      padding: padding ?? const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            offset: Offset(0, 8),
            color: Color(0x22000000),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _statCard({
    required IconData icon,
    required String label,
    required int value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: _shadowCard(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: kOrange.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: kOrange, size: 20),
            ),
            const SizedBox(height: 10),
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade600,
              ),
            ),
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
        const SizedBox(width: 10),
        Expanded(
          child: _statCard(
            icon: Icons.local_shipping_outlined,
            label: 'Envois',
            value: _shipmentsCount,
          ),
        ),
        const SizedBox(width: 10),
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
      return _shadowCard(
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.history_rounded),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Aucun suivi enregistré. Faites une recherche et vous le retrouverez ici.',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return _shadowCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: List.generate(_recentTrackings.length, (i) {
          final t = _recentTrackings[i];
          final last = _formatShortDate(t.lastViewedAt);

          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                title: Text(
                  t.label.trim().isEmpty ? t.id : t.label,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: Text(
                  'Numéro: ${t.id}\nDernière consultation: $last',
                  style: TextStyle(color: Colors.grey.shade600, height: 1.3),
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => _navigateToResult(t.id),
              ),
              if (i != _recentTrackings.length - 1)
                Divider(height: 1, color: Colors.grey.shade200),
            ],
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Top orange curved header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: _HeaderClipper(),
              child: Container(
                height: 190,
                color: kOrange,
              ),
            ),
          ),

          // Bottom-right orange blob
          Positioned(
            right: -55,
            top: 470,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: kOrange,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),

          RefreshIndicator(
            onRefresh: _loadDashboard,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
              children: [
                // Top row: menu | logo | avatar
                Row(
                  children: [
                    Builder(
                      builder: (ctx) => IconButton(
                        onPressed: () => Scaffold.maybeOf(ctx)?.openDrawer(),
                        icon: const Icon(Icons.menu_rounded, color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                    // Logo only
                    SizedBox(
                      height: 34,
                      child: Image.asset(
                        'assets/images/amana_logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.local_shipping_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: const DecorationImage(
                          image: NetworkImage('https://i.pravatar.cc/150?img=3'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                const Text(
                  'Welcome to AMANA',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: kTextBlue,
                  ),
                ),

                const SizedBox(height: 14),

                // Search + QR
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 18,
                              offset: Offset(0, 8),
                              color: Color(0x22000000),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _trackingController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: _navigateToResult,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Scanner ou saisissez',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.grey.shade600,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 18,
                            offset: Offset(0, 8),
                            color: Color(0x22000000),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: _scanAndNavigate,
                        icon: const Icon(Icons.qr_code_2_rounded),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Banner carousel
                SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _bannerController,
                    itemCount: _banners.length,
                    onPageChanged: (i) => setState(() => _bannerIndex = i),
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  _banners[i],
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: const Color(0xFFF2F2F2),
                                    child: const Center(child: Text('Banner')),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.45),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: const BoxDecoration(
                                    color: Color(0x33FFFFFF),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(14),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.local_shipping_rounded, size: 16, color: Colors.white),
                                      SizedBox(width: 8),
                                      Text(
                                        'Livraison à domicile dans\n60 villes',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 14,
                                right: 14,
                                bottom: 12,
                                child: Text(
                                  'Suivez vos colis, préparez vos envois, et gardez tout sous contrôle.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                Center(
                  child: SmoothPageIndicator(
                    controller: _bannerController,
                    count: _banners.length,
                    effect: ExpandingDotsEffect(
                      expansionFactor: 3.2,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 8,
                      activeDotColor: kOrange,
                      dotColor: kOrange.withOpacity(0.25),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                _buildStatsRow(),

                const SizedBox(height: 18),

                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Historique récent',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
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
          ),
        ],
      ),
    );
  }
}

class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.20, size.height * 0.65, size.width * 0.55, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.95, size.height * 0.78, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
