import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_amana_app/View/Menu/Accueil.dart';
import 'package:my_amana_app/View/SideBar/Mediathique.dart';
import 'package:my_amana_app/View/SideBar/produit.dart';
import 'package:my_amana_app/View/NavigationBar/Agences.dart';
import 'package:my_amana_app/View/NavigationBar/Contact.dart';
import 'package:my_amana_app/View/NavigationBar/Tarif.dart';
import 'package:my_amana_app/View/SideBar/AmnMaNatio.dart';


import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'package:my_amana_app/core/widgets/tracking_search_card.dart';

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
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      gradient: AppGradients.hero,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Image(
                            image: AssetImage("assets/images/logoProAmana.png"),
                            height: 60,
                            width: 60,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'My Amana',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Barid Al Maghrib',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
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

                  title: const Text('Produit', style: TextStyle(color: Colors.white)),
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

                  title: const Text('Agences', style: TextStyle(color: Colors.white)),
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

                  title: const Text('MÃ©diathÃ©que', style: TextStyle(color: Colors.white)),
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

                  title: const Text('Suivi ClientÃ©le', style: TextStyle(color: Colors.white)),
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

                  title: const Text('NumÃ©ros Utiles', style: TextStyle(color: Colors.white)),
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

                  title: const Text('Produit ProhibÃ©s', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Handle Settings menu item tap
                    
                  },
                ),
                 ListTile(
                  leading:const Icon(Icons.question_mark_rounded),

                  title: const Text('FAQ', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Handle Settings menu item tap
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FaQ()),
                    );
                  },
                ),
                 ListTile(
                  leading:const Icon(Icons.messenger),

                  title: const Text('Feedbackcs', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FeedB()),
                    );
                    // Handle Settings menu item tap
                  },
                ),
                 ListTile(
                  leading:const Icon(Icons.gpp_maybe_sharp),

                  title: const Text('Guide De Bonnes Pratique', style: TextStyle(color: Colors.white)),
                  onTap: () {
                       Navigator.pop(context);
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => const GuideBonn()),
                       );
                    // Handle Settings menu item tap
                  },
                ),
                ]
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
            onScan: () {},
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
    color: Colors.white54,
    fontSize: 8,
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
            items: [
              BottomNavigationBarItem(
                icon:Padding(padding:const EdgeInsets.only(bottom: 4) ,child: Icon(Boxicons.bxs_navigation, color: Colors.orange[700])),
                label: 'Suivi',
              ),
              BottomNavigationBarItem(
                icon: Padding(padding:const EdgeInsets.only(bottom: 4),child:Icon(Boxicons.bx_current_location, color: Colors.orange[700])),
                label: 'Agences',
              ),
              BottomNavigationBarItem(
                icon: Padding(padding: const EdgeInsets.only(bottom: 4),child: Icon(Boxicons.bx_calculator, color: Colors.orange[700])),
                label: 'Tarif',
              ),
              BottomNavigationBarItem(
                icon:Padding(padding:const EdgeInsets.only(bottom: 4),child: Icon(Boxicons.bxs_contact, color: Colors.orange[700])),
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

class FeedB extends StatelessWidget {
  const FeedB({super.key});

  @override
  Widget build(BuildContext context) {
    return const CheckboxPage();
  }
}

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  final List<bool> checkboxes = [false, false, false, false];

  void navigateToCheckedPages() {
    final List<String> checkedPages = [];

    for (int i = 0; i < checkboxes.length; i++) {
      if (checkboxes[i]) {
        checkedPages.add('/page${i + 1}');
      }
    }

    if (checkedPages.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MultiPageViewer(pages: checkedPages),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selectionnez au moins un formulaire.')),
      );
    }
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppGradients.hero,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Feedback',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Choisissez les formulaires a remplir.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxTile(String label, int index) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(fontSize: 12)),
      value: checkboxes[index],
      activeColor: AppColors.primary,
      onChanged: (value) {
        setState(() {
          checkboxes[index] = value ?? false;
        });
      },
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
          _buildHeader(),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Formulaires disponibles',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCheckboxTile(
                    "Formulaire du Feedback sur l'Agence",
                    0,
                  ),
                  _buildCheckboxTile(
                    "Feedback sur l'expÇ¸rience de l'application mobile My Amana ",
                    1,
                  ),
                  _buildCheckboxTile(
                    "Feedback sur l'expÇ¸rience de l'application le call centre ",
                    2,
                  ),
                  _buildCheckboxTile(
                    "Feedback sur l'expÇ¸rience de livraison Çÿ domicile",
                    3,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: navigateToCheckedPages,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Continuer'),
            ),
          ),
        ],
      ),
    );
  }
}

class MultiPageViewer extends StatefulWidget {
  final List<String> pages;

  const MultiPageViewer({super.key, required this.pages});

  @override
  State<MultiPageViewer> createState() => _MultiPageViewerState();
}

class _MultiPageViewerState extends State<MultiPageViewer> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (_currentPage < widget.pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaires'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: widget.pages
                  .map((page) => Navigator(
                        onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => PageRouter(page: page),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousPage,
                  icon: const Icon(Icons.arrow_back),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_currentPage + 1}/${widget.pages.length}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  onPressed: nextPage,
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PageRouter extends StatelessWidget {
  final String page;

  const PageRouter({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: page,
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/page1':
            builder = (BuildContext context) => const FeedbackPage(
                  title: 'Feedback Agence',
                  subtitle: 'Parlez-nous de votre passage en agence.',
                );
            break;
          case '/page2':
            builder = (BuildContext context) => const FeedbackPage(
                  title: 'Feedback Application',
                  subtitle: 'Votre avis sur l experience My Amana.',
                );
            break;
          case '/page3':
            builder = (BuildContext context) => const FeedbackPage(
                  title: 'Feedback Call Center',
                  subtitle: 'Comment evalueriez-vous notre support ?',
                );
            break;
          case '/page4':
            builder = (BuildContext context) => const FeedbackPage(
                  title: 'Feedback Livraison',
                  subtitle: 'Partagez votre experience de livraison.',
                );
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: AppGradients.hero,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Votre retour',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 12),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Nom et prenom',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 12),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.mail_outline),
                  ),
                ),
                const SizedBox(height: 12),
                const TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Votre message',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.message_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Envoyer'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
