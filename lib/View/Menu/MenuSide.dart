import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_amana_app/View/Menu/Accueil.dart';
import 'package:my_amana_app/View/SideBar/Mediathique.dart';
import 'package:my_amana_app/View/SideBar/produit.dart';
import 'package:my_amana_app/View/SideBar/ProduitPro.dart';
import 'package:my_amana_app/View/NavigationBar/Agences.dart';
import 'package:my_amana_app/View/NavigationBar/Contact.dart';
import 'package:my_amana_app/View/NavigationBar/Tarif.dart';
import 'package:my_amana_app/View/SideBar/AmnMaNatio.dart';


import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'package:my_amana_app/core/widgets/tracking_search_card.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'feedback_page.dart';

import '../SideBar/FAQ.dart';
import '../SideBar/NumeUtil.dart';
import '../SideBar/guide.dart';
import '../resultat.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _selectedIndex;

  final List<Widget> _tabs = const [
    Accueila(),
    AgencLoc(),
    MapAppt(),
    Contact(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onTabSelected(int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context, onHomeTap: () => _onTabSelected(0)),
      drawer: darweF(context, onSelectTab: _onTabSelected),
      body: IndexedStack(
        index: _selectedIndex,
        children: _tabs,
      ),
      bottomNavigationBar: NavBottom(
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}

Widget darweF(BuildContext context, {ValueChanged<int>? onSelectTab}) {
  return Drawer(
            child: Container(
              color: AppColors.primaryDark,
              child: ListTileTheme(
                iconColor: Colors.white70,
                textColor: Colors.white,
                child: ListView(
                  children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      gradient: AppGradients.hero,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Image(
                            image: AssetImage("assets/images/logoProAmana.png"),
                            height: 52,
                            width: 52,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'My Amana',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Barid Al Maghrib',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                  
                  leading:const Icon(Icons.home),
                  title: const Text('Accueil', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    if (onSelectTab != null) {
                      onSelectTab(0);
                      Navigator.pop(context);
                      return;
                    }
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AppShell(initialIndex: 0),
                      ),
                      (route) => false,
                    );
                  },
                ),
                ListTile(
                  leading:const Icon(Icons.shopping_cart),

                  title: const Text('Produit'),
                  onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Produit()),
                      );
                  },
                ),
                ListTile(
                  leading:const Icon(Icons.place_rounded),

                  title: const Text('Agences'),
                  onTap: () {
                    if (onSelectTab != null) {
                      onSelectTab(1);
                      Navigator.pop(context);
                      return;
                    }
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AppShell(initialIndex: 1),
                      ),
                      (route) => false,
                    );
                  },
                ),
                ListTile(
                  leading:const Icon(Icons.slow_motion_video_outlined),

                  title: const Text('Mediatheque'),
                  onTap: () {
                    // Handle Settings menu item tap
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const VideoMed()),
                    );
                  },
                ),
                 ListTile(
                  leading:const Icon(Icons.person_pin),

                  title: const Text('Suivi clientele'),
                  onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DefinitionPage(),
                        ),
                      );

                    // Handle Settings menu item tap
                  },
                ),
                 ListTile(
                  leading:const Icon(Icons.call),

                  title: const Text('Numeros utiles'),
                  onTap: () {
                    // Handle Settings menu item tap
                     Navigator.pop(context);
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => const NumeroTlf()),
                     );
                  },
                ),
                ListTile(
                  leading:const Icon(Icons.shopping_cart),
                  title: const Text('Produit prohibes'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Guide()),
                    );
                  },
                ),
                ListTile(
                  leading:const Icon(Icons.question_mark_rounded),
                  title: const Text('FAQ'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FaQ()),
                    );
                  },
                ),
                ListTile(
                  leading:const Icon(Icons.messenger),
                  title: const Text('Feedback'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FeedB()),
                    );
                  },
                ),
                ListTile(
                  leading:const Icon(Icons.gpp_maybe_sharp),
                  title: const Text('Guide de bonnes pratiques'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GuideBonn()),
                    );
                  },
                ),
                  ],
                ),
              ),
            ) ,
          );
}
class MenuAmana extends StatefulWidget {
  const MenuAmana({super.key});

  @override
  State<MenuAmana> createState() => _MenuAmanaState();
}

class _MenuAmanaState extends State<MenuAmana> {
   final TextEditingController _trackingController = TextEditingController();

   final List<String> scrollImage = [
      'assets/images/scroller1.jpg',
      'assets/images/scroller2.jpg',
      'assets/images/scroller3.jpg',
      'assets/images/scroller4.jpg',

      
    ];

  @override
  void dispose() {
    _trackingController.dispose();
    super.dispose();
  }

  void _submitTracking() {
    final trackingId = _trackingController.text.trim();
    if (trackingId.isEmpty || trackingId.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez saisir un numero de suivi valide.'),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Resultat(trackingId: trackingId),
      ),
    );
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
    _trackingController.text = value;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Resultat(trackingId: value),
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
          TrackingSearchCard(
            controller: _trackingController,
            onSearch: _submitTracking,
            onScan: _scanTracking,
            hintText: 'Scanner ou saisir votre code',
          ),
          const SizedBox(height: 20),
          const Text(
            'Offres a la une',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          CarouselSlider.builder(
            itemCount: scrollImage.length,
            itemBuilder: (context, index, realindex) {
              final scroll = scrollImage[index];
              return buildImage(scroll, index);
            },
            options: CarouselOptions(
              height: 300,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
            ),
          ),
        ],
      ),
    );
    
  }
}
class NavBottom extends StatelessWidget {
  const NavBottom({super.key, this.currentIndex = 0, this.onTap});

  final int currentIndex;
  final ValueChanged<int>? onTap;

  static const TextStyle _textStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  void _handleTap(BuildContext context, int index) {
    if (onTap != null) {
      onTap!(index);
      return;
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => AppShell(initialIndex: index)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: SafeArea(
        top: false,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: _textStyle,
            unselectedLabelStyle: _textStyle,
            items: [
              BottomNavigationBarItem(
                icon:Padding(padding:const EdgeInsets.only(bottom: 4) ,child: Icon(Boxicons.bxs_navigation)),
                label: 'Suivi',
              ),
              BottomNavigationBarItem(
                icon: Padding(padding:const EdgeInsets.only(bottom: 4),child:Icon(Boxicons.bx_current_location)),
                label: 'Agences',
              ),
              BottomNavigationBarItem(
                icon: Padding(padding: const EdgeInsets.only(bottom: 4),child: Icon(Boxicons.bx_calculator)),
                label: 'Tarif',
              ),
              BottomNavigationBarItem(
                icon:Padding(padding:const EdgeInsets.only(bottom: 4),child: Icon(Boxicons.bxs_contact)),
                label: 'Contact',
              ),
            ],
            currentIndex: currentIndex,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.mutedText,
            showUnselectedLabels: true,
            onTap: (index) => _handleTap(context, index),
          ),
        ),
      ),
    );
  }
}


Widget buildImage(String scroll , int index )=>ClipRRect(
  borderRadius: BorderRadius.circular(20),
  child: Stack(
    children: [
      Image.asset(scroll, fit: BoxFit.cover, width: double.infinity),
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.0),
                Colors.black.withOpacity(0.6),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Text(
            'Promo ${index + 1}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ],
  ),
);
PreferredSizeWidget appB(BuildContext context, {VoidCallback? onHomeTap}) {
  return AppBar(
    iconTheme: const IconThemeData(color: AppColors.primary),
    backgroundColor: Colors.transparent,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.background.withOpacity(0.95),
            Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    ),
    title: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (onHomeTap != null) {
            onHomeTap();
            return;
          }
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AppShell()),
            (route) => false,
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/logoProAmana.png",
              height: 40,
              width: 40,
              alignment: FractionalOffset.center,
            ),
            const SizedBox(width: 8),
            const Text(
              'My Amana',
              style: TextStyle(color: AppColors.text),
            ),
          ],
        ),
      ),
    ),
    centerTitle: true, // Aligns the title to the center
  );
}
