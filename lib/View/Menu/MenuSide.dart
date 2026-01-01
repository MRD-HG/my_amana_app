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

import '../SideBar/FAQ.dart';
import '../SideBar/NumeUtil.dart';
import '../SideBar/feedback.dart';
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
              color: Colors.orange[900],
              child: ListView(
                children: [
                  Container(
                    child: DrawerHeader(
                                  
                    child: Container(
                      color: Colors.white,
                      child:
                      
                      
                    const Image(image: AssetImage("assets/images/logoProAmana.png"),height: 70,width: 70,)
                    
                    ),
                                  
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

                  title: const Text('Médiathéque', style: TextStyle(color: Colors.white)),
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

                  title: const Text('Suivi Clientéle', style: TextStyle(color: Colors.white)),
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

                  title: const Text('Numéros Utiles', style: TextStyle(color: Colors.white)),
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

                  title: const Text('Produit Prohibés', style: TextStyle(color: Colors.white)),
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
    return Center(
      child:  Container(
        child: Column(
          crossAxisAlignment : CrossAxisAlignment.center,
          
          children: [
             Padding(
          padding: const EdgeInsets.all(11.0),
          child: SizedBox(
            width: 350,
            child: TextFormField(
              controller: _trackingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2)),
                  borderSide: BorderSide(width: 3,color:Colors.black )),

                labelText: "SCANNER OU SAISIR LE CODE DE SUIVI",
                labelStyle: TextStyle(color: Colors.grey[600],fontSize: 15),
                suffixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize:MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _submitTracking,
                    ),
                     IconButton(
                      icon: const Icon(Icons.qr_code_scanner),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          
        
                
                
                
                /* validator: (String? value) {
                  if(value!.isEmpty){
                    return "Saisir votre Code De Suivi";
                  }
                }, */
                

              ),
            ),
           CarouselSlider.builder(
              itemCount: scrollImage.length , 
              itemBuilder: (context,index,realindex){
                final scroll=scrollImage[index];
                return buildImage(scroll,index);
              },
               options: CarouselOptions(
                height: 300,
                enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  

               ) 
               )

          ],
        
        ),
      ) 
      ,
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
    return BottomNavigationBar(
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
      selectedItemColor: Colors.amber[100],
      onTap: (index) => _handleTap(context, index),
    );
  }
}


Widget buildImage(String scroll , int index )=>Container(child :Image.asset(scroll,fit: BoxFit.cover,));
PreferredSizeWidget appB(BuildContext context, {VoidCallback? onHomeTap}) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.orange), // Sets the color of the leading icon
    backgroundColor: Colors.white, // Sets the background color of the AppBar
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
        child: Image.asset(
          "assets/images/logoProAmana.png",
          height: 80,
          width: 80,
          alignment: FractionalOffset.center,
        ),
      ),
    ),
    centerTitle: true, // Aligns the title to the center
  );
}
