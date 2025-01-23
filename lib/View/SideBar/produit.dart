import 'package:flutter/material.dart';

import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/View/SideBar/AmnMaNatio.dart';

import 'Entreprise.dart';




class Produit extends StatefulWidget {
  const Produit({super.key});

  @override
  State<Produit> createState() => _ProduitState();
}

class _ProduitState extends State<Produit> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar:appB(context),
       drawer: darweF(context),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                Padding(padding: const EdgeInsets.only(bottom: 20,top: 20),
                child: ElevatedButton(onPressed: () {
                  Route route = MaterialPageRoute(builder: (((context) =>const  PartiProf())));
                  Navigator.pushReplacement(context, route);
                }, 
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  fixedSize: const Size(300, 50)

                ), child:const  Text('Particuliers & Professionnels',style: TextStyle(color: Colors.white ))
                ),
                ),
                Padding(padding: const EdgeInsets.only(bottom: 20,top: 5),
                child: ElevatedButton(onPressed: () {
                  Route route = MaterialPageRoute(builder: (((context) =>const  EntrepBut())));
                  Navigator.pushReplacement(context, route);
                  
                },style:ElevatedButton.styleFrom(
                   
                  backgroundColor: Colors.red[600],
                  fixedSize: const Size(300, 50)

                ),
                       child: const Text('Entreprises',style: TextStyle(color: Colors.white )),

                ),

                )
            ],

          ),
        ),
      ),
      bottomNavigationBar: const NavBottom(),
    );
  }
}
class PartiProf extends StatelessWidget {
  const PartiProf({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:appB(context),
       drawer: darweF(context),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                Padding(padding: const EdgeInsets.only(bottom: 20,top: 20),
                child: ElevatedButton(onPressed: () {
                  Route route = MaterialPageRoute(builder: (((context) =>  const DefinitionPage())));
                  Navigator.pushReplacement(context, route);
                }, 
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  fixedSize: const Size(300, 50)

                ), child:const  Text('Amana Messagerie National',style: TextStyle(color: Colors.white ))
                ),
                ),
                Padding(padding: const EdgeInsets.only(bottom: 20,top: 5),
                child: ElevatedButton(onPressed: () {
                  Route route = MaterialPageRoute(builder: (((context) => const Ecommerce())));
                  Navigator.pushReplacement(context, route);
                },style:ElevatedButton.styleFrom(
                   
                  backgroundColor: Colors.red[600],
                  fixedSize: const Size(300, 50)

                ),
                       child: const Text('E-commerce',style: TextStyle(color: Colors.white )),
                ),

                ),
                Padding(padding: const EdgeInsets.only(bottom: 20,top: 5),
                child: ElevatedButton(onPressed: () {
                  Route route = MaterialPageRoute(builder: (((context) =>const  AmanaInter())));
                  Navigator.pushReplacement(context, route);
                },style:ElevatedButton.styleFrom(
                   
                  backgroundColor: Colors.red[600],
                  fixedSize: const Size(300, 50)

                ),
                       child: const Text('Amana International',style: TextStyle(color: Colors.white )),
                ),

                ),
                Padding(padding: const EdgeInsets.only(bottom: 20,top: 5),
                child: ElevatedButton(onPressed: () {
                  Route route = MaterialPageRoute(builder: (((context) => const Postcolis())));
                  Navigator.pushReplacement(context, route);
                },style:ElevatedButton.styleFrom(
                   
                  backgroundColor: Colors.red[600],
                  fixedSize: const Size(300, 50)

                ),
                       child: const Text('Postcolis',style: TextStyle(color: Colors.white )),
                ),

                )
            ],

          ),
        ),
      ),
      bottomNavigationBar: const NavBottom(),


    );
  }
}
class EntrepBut extends StatelessWidget {
  const EntrepBut({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                Padding(padding: const EdgeInsets.only(bottom: 20,top: 20),
                child: ElevatedButton(onPressed: () {
                  Route route = MaterialPageRoute(builder: (((context) =>   const Amanamesager())));
                  Navigator.pushReplacement(context, route);
                }, 
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  fixedSize: const Size(300, 50)

                ), child:const  Text('Amana Messagerie National',style: TextStyle(color: Colors.white ))
                ),
                ),
                Padding(padding: const EdgeInsets.only(bottom: 20,top: 5),
                child: ElevatedButton(onPressed: () {
                  Route route = MaterialPageRoute(builder: (((context) =>  const Amanamesager())));
                  Navigator.pushReplacement(context, route);
                },style:ElevatedButton.styleFrom(
                   
                  backgroundColor: Colors.red[600],
                  fixedSize: const Size(300, 50)

                ),
                       child: const Text('Amana Logistics',style: TextStyle(color: Colors.white )),
                ),
                )
            ]
          )
      )
      )
    );
  }
}