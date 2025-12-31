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
  const AppShell({super.key});
  
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {

  @override
  Widget build(BuildContext context) {
    return const SideMenu();
  }
}
  

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool show =false;

   void _envoiNatio() {
    setState(() {
      if (show == !true) {
        show =!show;
       
      }
      else{
        show =!show;


      }
    });
   
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
          drawer: darweF(context),
          body:const MenuAmana(),
      
               
                
                
          
        
      );
    
  }
}
Widget darweF(BuildContext context){
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
                    Route  route =  MaterialPageRoute(builder:  ((context) =>const Accueila()),);
                      Navigator.pushReplacement(context, route);// Handle Home menu item tap
                  },
                ),
                ListTile(
                  leading:const Icon(Icons.shopping_cart),

                  title: const Text('Produit', style: TextStyle(color: Colors.white)),
                  onTap: () {
                      Route  route =  MaterialPageRoute(builder:  ((context) => const Produit()),);
                      Navigator.pushReplacement(context, route);

                  },
                ),
                ListTile(
                  leading:const Icon(Icons.place_rounded),

                  title: const Text('Agences', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Route  route =  MaterialPageRoute(builder:  ((context) =>  const AgencLoc()),);
                      Navigator.pushReplacement(context, route);
                    // Handle Settings menu item tap
                  },
                ),
                ListTile(
                  leading:const Icon(Icons.slow_motion_video_outlined),

                  title: const Text('Médiathéque', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Handle Settings menu item tap
                    Route  route =  MaterialPageRoute(builder:  ((context) =>const VideoMed()));
                      Navigator.pushReplacement(context, route);
                  },
                ),
                 ListTile(
                  leading:const Icon(Icons.person_pin),

                  title: const Text('Suivi Clientéle', style: TextStyle(color: Colors.white)),
                  onTap: () {
                      Route  route =  MaterialPageRoute(builder:  ((context) =>   const DefinitionPage()));
                      Navigator.pushReplacement(context, route);

                    // Handle Settings menu item tap
                  },
                ),
                 ListTile(
                  leading:const Icon(Icons.call),

                  title: const Text('Numéros Utiles', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Handle Settings menu item tap
                     Route  route =  MaterialPageRoute(builder:  ((context) => const NumeroTlf()  ));
                    Navigator.pushReplacement(context, route);
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
                    Route  route =  MaterialPageRoute(builder:  ((context) =>const FaQ()));
                      Navigator.pushReplacement(context, route);
                  },
                ),
                 ListTile(
                  leading:const Icon(Icons.messenger),

                  title: const Text('Feedbackcs', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Route  route =  MaterialPageRoute(builder:  ((context) => const FeedB()));
                      Navigator.pushReplacement(context, route);
                    // Handle Settings menu item tap
                  },
                ),
                 ListTile(
                  leading:const Icon(Icons.gpp_maybe_sharp),

                  title: const Text('Guide De Bonnes Pratique', style: TextStyle(color: Colors.white)),
                  onTap: () {
                       Route  route =  MaterialPageRoute(builder:  ((context) =>const GuideBonn()));
                      Navigator.pushReplacement(context, route);
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
   final List<String> scrollImage = [
      'assets/images/scroller1.jpg',
      'assets/images/scroller2.jpg',
      'assets/images/scroller3.jpg',
      'assets/images/scroller4.jpg',

      
    ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child:  Container(
          child: Column(
            crossAxisAlignment : CrossAxisAlignment.center,
            
            children: [
               Padding(
            padding: const EdgeInsets.all(11.0),
            child: SizedBox(
              width: 350,
              child: TextFormField(

                onChanged: (value) {
                  // Print the value of the TextFormField
                },
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
                        onPressed: () {
                          Route  route =  MaterialPageRoute(builder:  ((context) => const Resultat()),);
                                    Navigator.pushReplacement(context, route);

                        },
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
      ),
    
      bottomNavigationBar: const NavBottom(),
    
    );
    
  }
}
class NavBottom extends StatefulWidget {
  const NavBottom({super.key});

  @override
  State<NavBottom> createState() => _NavBottomState();
}

class _NavBottomState extends State<NavBottom> {
  final TextStyle textSty = const TextStyle(
    color: Colors.white54,
    fontSize: 8,
  );

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the selected screen
    switch (index) {
      case 0:
      
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>const Accueila()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AgencLoc()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>const MapAppt()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Contact()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: textSty,
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
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[100],
      onTap: _onItemTapped,
    );
  }
}


Widget buildImage(String scroll , int index )=>Container(child :Image.asset(scroll,fit: BoxFit.cover,));
PreferredSizeWidget appB(BuildContext context) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.orange), // Sets the color of the leading icon
    backgroundColor: Colors.white, // Sets the background color of the AppBar
    title: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AppShell()),
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
