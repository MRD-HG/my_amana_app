import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/View/NavigationBar/Tarif.dart';

class DefinitionPage extends StatefulWidget {
  const DefinitionPage({super.key});

  @override
  State<DefinitionPage> createState() => _DefinitionPageState();
}

class _DefinitionPageState extends State<DefinitionPage> {
  final bool _showIcon = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer:darweF(context),
      body:ListView(

      children:[ Padding(
    
        padding:const EdgeInsets.all(1.0),
        
          child: Column(
             mainAxisSize: MainAxisSize.min, 
              crossAxisAlignment: CrossAxisAlignment.start, 
              
            children: [
              
               Image.asset("assets/images/AmanaDelivery.jpg",height: 100,width: 100  ),
                Text(textAlign:TextAlign.center, 

                'AMANA',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.orange[800]),
              ),
              const SizedBox(height:5),

              const Text(
                textAlign:TextAlign.center, 


                'Aussitôt envoyé,aussitôt livré !',overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              const SizedBox(height: 15),
              Text(textAlign: TextAlign.start,

                'Amana Messagerie Nationale',overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.red[800],),
              ),
              const SizedBox(height: 10),
              
              const Text(
                    textAlign:TextAlign.left,
                'Amana Messagerie Nationale vous permet de livrer vos colis et vos documents partout au Maroc et en seulement 24H dans 80% destinations.',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.black ,),
              ),
              const SizedBox(height: 2),


              ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: Colors.red[800], fixedSize: const Size(300, 10)),onPressed: () {
                Route route = MaterialPageRoute(builder: ((context)=> const MapAppt()));
                Navigator.push(context, route);
              }, child: const Text("CALCLULER UN TARIF"),),
              const SizedBox(height: 20,),
               Flexible(child: ExpansionTile(backgroundColor: Colors.red[500],
                title: const Text("Caractéristiques"),
             
               onExpansionChanged: (bool expanded){},
               children:  [
                ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Le Contre remboursement : Votre destinataire ne peut récupérer l'envoi qu'une fois le paîment que vous avez"
                  "préalablement convenu est réglé.",),
                ),
                ListTile(
                  tileColor: Colors.red[800],
                  title:const Text("La preuve de livrainson : Recevez une preuve de distribution signée par la destinataire"
                  ),
                ),
                ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("La valeur déclarée : Assurez le remboursement des envois de valeurs en cas de perte "
                  ,),
                ),
                 ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Envois fragile : Réservez un traitement spécial aux envois Amana dont le contenu est fragile ."
                  ),
                ),
               

               ],
               
               
             
             )
             ,),
             Flexible(child: ExpansionTile(backgroundColor: Colors.red[800],
                title: const Text("Avantages"),
             
               onExpansionChanged: (bool expanded){},
               children:  [
                ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Livraison à domicile"
                  ,overflow: TextOverflow.ellipsis,),
                ),
                ListTile(
                  tileColor: Colors.red[800],
                  title:const Text("Délai de garde de 15 jours de vos envois dans l'agences la plus proche de destinataire en cas d'absence."
                  ,overflow: TextOverflow.ellipsis,),
                ),
                ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("ALert SMS pour l'expéditeur et le destinataire ;"
                  ,overflow: TextOverflow.ellipsis,),
                ),
                 ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Gamme d'emballages compléte adaptée à la nature de vos colis"
                  ,overflow: TextOverflow.ellipsis,),
                ),
                 ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Services de traçabilité."
                  ,overflow: TextOverflow.ellipsis,),
                ),
               

               ],
               
               
             
             )
             ,)
          
            ]),
      ),],
      ),
      bottomNavigationBar: const NavBottom(),
      
      );
    
  }
}
class Ecommerce extends StatelessWidget {
  const Ecommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body:ListView(
        children:[ Padding(
    
        padding:const EdgeInsets.all(1.0),
        
          child: Column(
             mainAxisSize: MainAxisSize.min, 
              crossAxisAlignment: CrossAxisAlignment.start, 
              
            children: [
              
               Image.asset("assets/images/AmanaDelivery.jpg"),
                Text(textAlign:TextAlign.center, 

                'AMANA',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.orange[800]),
              ),
              const SizedBox(height:5),

              const Text(
                textAlign:TextAlign.center, 


                'Aussitôt envoyé,aussitôt livré !',overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              const SizedBox(height: 15),
              Text(textAlign: TextAlign.start,

                'E-commerce',overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.red[800],),
              ),
              const SizedBox(height: 10),
              
              const Text(
                    textAlign:TextAlign.left,overflow: TextOverflow.ellipsis,
                "",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.black ,),
              ),
              const SizedBox(height: 2),


              ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: Colors.red[800], fixedSize: const Size(300, 10)),onPressed: () {
                Route route = MaterialPageRoute(builder: ((context)=> const MapAppt()));
                Navigator.push(context, route);
              }, child: const Text("CALCLULER UN TARIF"),),
              const SizedBox(height: 20,),
               Flexible(child: ExpansionTile(backgroundColor: Colors.red[500],
                title: const Text("Caractéristiques"),
             
               onExpansionChanged: (bool expanded){},
               children:  [
                ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Le Contre remboursement : Votre destinataire ne peut récupérer l'envoi qu'une fois le paîment que vous avez"
                  "préalablement convenu est réglé.",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10)),
                ),
                ListTile(
                  tileColor: Colors.red[800],
                  title:const Text("La preuve de livrainson : Recevez une preuve de distribution signée par la destinataire"
                  ,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10)),
                ),
                ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("La valeur déclarée : Assurez le remboursement des envois de valeurs en cas de perte "
                  ,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10)),
                ),
                 ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Envois fragile : Réservez un traitement spécial aux envois Amana dont le contenu est fragile ."
                  ,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10)),
                ),
               

               ],
               
               
             
             )
             ,),
             Flexible(child: ExpansionTile(backgroundColor: Colors.red[800],
                title: const Text("Avantages"),
             
               onExpansionChanged: (bool expanded){},
               controlAffinity: ListTileControlAffinity.leading,
               children:  [
                ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Livraison à domicile"
                  ,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10)),
                ),
                ListTile(
                  tileColor: Colors.red[800],
                  title:const Text("Délai de garde de 15 jours de vos envois dans l'agences la plus proche de destinataire en cas d'absence."
                  ,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10)),
                ),
                ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("ALert SMS pour l'expéditeur et le destinataire ;"
                  ,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10)),
                ),
                 ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Gamme d'emballages compléte adaptée à la nature de vos colis"
                  ,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10)),
                ),
                 ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Services de traçabilité."
                  ,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10)),
                ),
               

               ],
               
               
             
             )
             ,)
          
            ]),
      ),],
      )

    );
  }
}
class AmanaInter extends StatelessWidget {
  const AmanaInter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appB(context),
      drawer: darweF(context),
      body:ListView(
        children:[ Padding(
    
        padding:const EdgeInsets.all(1.0),
        
          child: Column(
            mainAxisSize: MainAxisSize.min,
              
            children: [
              
               Image.asset("assets/images/AmanaDelivery.jpg"),
                Text(textAlign:TextAlign.center, 

                'AMANA',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.orange[800]),
              ),
              const SizedBox(height:5),

              const Text(
                textAlign:TextAlign.center, 


                'Aussitôt envoyé,aussitôt livré !',overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              const SizedBox(height: 15),
              Text(textAlign: TextAlign.start,

                'Amana Internationale',overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.red[800],),
              ),
              const SizedBox(height: 10),
              
              const Text(
                    textAlign:TextAlign.left,overflow: TextOverflow.ellipsis,
                "Amana Internationale vous permet de livrer vos colis à l'étranger dans un délai maîtrisé et garanti allant de 4 à 7"
                "jours ouvrables selon le pays de destination.",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.black ,),
              ),
              const SizedBox(height: 2),


              ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: Colors.red[800], fixedSize: const Size(300, 10)),onPressed: () {
                Route route = MaterialPageRoute(builder: ((context)=> const MapAppt()));
                Navigator.push(context, route);
              }, child: const Text("CALCLULER UN TARIF"),),
              const SizedBox(height: 20,),
               Flexible(child: ExpansionTile(backgroundColor: Colors.red[500],
                title: const Text("Caractéristiques"),
             
               onExpansionChanged: (bool expanded){},
               children:  [
                ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Des délai maîtrisés entre 4 à 7 jours ouvrables selon le pays de destination ;"
                  ,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10)),
                ),
                ListTile(
                  tileColor: Colors.red[800],
                  title:const Text("Une capacité de poids allant jusqu'à 70 kg/colis quelle que soit la destination."
                  ,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10)),
                ),
                
               

               ],
               
               
             
             )
             ,),
             Flexible(child: ExpansionTile(backgroundColor: Colors.red[800],
                title: const Text("Avantages"),
             
               onExpansionChanged: (bool expanded){},
               controlAffinity: ListTileControlAffinity.leading,
               children:  [
                ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Le meilleur rapport qualité prix;"
                  ,overflow: TextOverflow.ellipsis,),
                ),
                ListTile(
                  tileColor: Colors.red[800],
                  title:const Text("Une large couverture de distribution : 150 destination à travers le monde;"
                  ,overflow: TextOverflow.ellipsis,),
                ),
                ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Suivi des envois."
                  ,overflow: TextOverflow.ellipsis,),
                ),
                

               ],
               
               
             
             )
             ,)
          
            ]),
      ),],
      )
    );
  }
}
class Postcolis extends StatelessWidget {
  const Postcolis({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:appB(context),
      drawer:darweF(context),
      body:ListView(
        children:[ Padding(
    
        padding:const EdgeInsets.all(1.0),
        
          child: Column(
            mainAxisSize: MainAxisSize.min,
              
            children: [
              
               Image.asset("assets/images/AmanaDelivery.jpg"),
                Text(textAlign:TextAlign.center, 

                'AMANA',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.orange[800]),
              ),
              const SizedBox(height:5),

              const Text(
                textAlign:TextAlign.center, 


                'Aussitôt envoyé,aussitôt livré !',overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              const SizedBox(height: 15),
              Text(textAlign: TextAlign.start,

                'Postcolis',overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.red[800],),
              ),
              const SizedBox(height: 10),
              
              const Text(
                    textAlign:TextAlign.left,overflow: TextOverflow.ellipsis,
                "Postcolis est une solution économique de messagerie internationale pour les expéditions de vos colis jusqu'à 30 Kg",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.black ,),
              ),
              const SizedBox(height: 2),


              ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: Colors.red[800], fixedSize: const Size(300, 10)),onPressed: () {
                Route route = MaterialPageRoute(builder: ((context)=> const MapAppt()));
                Navigator.push(context, route);
              }, child: const Text("CALCLULER UN TARIF"),),
              const SizedBox(height: 20,),
               Flexible(child: ExpansionTile(backgroundColor: Colors.red[500],
                title: const Text("Caractéristiques"),
             
               onExpansionChanged: (bool expanded){},
               children:  [
                ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Large couverture de distribution : plus  de 200 destination dans le monde;"
                  ,overflow: TextOverflow.ellipsis,),
                ),
                ListTile(
                  tileColor: Colors.red[800],
                  title:const Text("Délai de livraison à partir de 07 jours selon la destination."
                  ,overflow: TextOverflow.ellipsis,),
                ),
                
               

               ],
               
               
             
             )
             ,),
             Flexible(child: ExpansionTile(backgroundColor: Colors.red[800],
                title: const Text("Avantages"),
             
               onExpansionChanged: (bool expanded){},
               controlAffinity: ListTileControlAffinity.leading,
               children:  [
                ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Tarifs économiques;"
                  ,overflow: TextOverflow.ellipsis,),
                ),
                ListTile(
                  tileColor: Colors.red[800],
                  title:const Text("Formalités de dépots simples;"
                  ,overflow: TextOverflow.ellipsis,),
                ),
                ListTile(
                  
                  tileColor: Colors.red[800],
                  title:const Text("Services de traçabilité"
                  ,overflow: TextOverflow.ellipsis,),
                ),
                 
               

               ],
               
               
             
             )
             ,)
          
            ]),
      ),],
      )
    );
  }
}
