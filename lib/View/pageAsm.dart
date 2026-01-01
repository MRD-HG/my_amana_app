import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';



class MapApp extends StatefulWidget {
  const MapApp({super.key});

  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  bool searchBarVisible = false;
  bool isExpanded = true;
  Alignment gh = Alignment.bottomCenter;

  void _toggleSearchBar() {
    setState(() {
      searchBarVisible = !searchBarVisible;
    });
  }

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  bool isPanelOpen = false;
  int selectedIdx = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.orange,
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: _toggleSearchBar,
              icon: const Icon(Icons.search, color: Colors.orange),
            ),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logoProAmana.png',
                width: 80,
                height: 80,
              ),
              const SizedBox(width: 8),
            ],
          ),
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const [ 
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.grey),
            
              label: 'Suivi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail, color: Colors.grey),
              label: 'Agences',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.grey),
              label: 'Tarifs',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: Colors.grey,
              ),
              label: 'Contact',
            ),
          ],
        ),
        body: SlidingUpPanel(
          maxHeight: size.height * 0.5,
          minHeight: size.height * 0.1,
          body: Column(
            children: [
              Center(
                child: Visibility(
                  visible: searchBarVisible,
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          panelBuilder:(controller)  {
            return SingleChildScrollView(
              controller: controller,
              child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.all(10),
                      child:   Row(
                  children: [
                    const Expanded(
                       
                      child: Text(
                        'Choisir le Régient',
                        textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.orange,
                          textStyle: const TextStyle(
                            fontSize: 20,
                          ),
                          padding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Set the border radius of the button
                          ),
                        ),
                        child: const Text('Rabat'),
                      ),
                    ),
                  ],
                ),
                    ),

               const SizedBox(height: 16),
               Padding(padding: const EdgeInsets.all(10),
               child:  Row(
                  children: [
                    
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Expanded(
                        
                        child: CircleAvatar( radius: 20,
                        backgroundImage:  AssetImage('assets/images/logoProAmana.png'),
                        ) 
                      ),
                       
                    ),
                    const Expanded(child: Center(child: Text('fhghhfj'))),
                     Align(
                    alignment: Alignment.centerRight,
                    child:  Expanded(
                      child: IconButton(
                        onPressed: _toggleSearchBar,
                        icon: const Icon(Icons.location_on, color: Colors.orange),
                      ),
                    ),
                   )
                  ],
                ),
               ),
               const SizedBox(height: 16),
                 
                Padding(padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Expanded(
                        child:CircleAvatar( radius: 20,
                      backgroundImage:  AssetImage('assets/images/logoProAmana.png'),
                        ) 
                        
                      ),
                    ),
                    const Expanded(child: Center(child: Text('fhghhfj'))),
                   Align(
                    alignment: Alignment.centerRight,
                    child:  Expanded(
                      child: IconButton(
                        onPressed: _toggleSearchBar,
                        icon: const Icon(Icons.location_on, color: Colors.orange),
                      ),
                    ),
                   )
                  ],
                ),
                )
              ],
              ) ,
            );
          } ,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10),
          ),
          color: Colors.blue,
        ),
    );
  }
}
