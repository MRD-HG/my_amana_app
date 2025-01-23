import "package:flutter/material.dart";

import "../Menu/MenuSide.dart";



class Guide extends StatelessWidget {
  const Guide({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body:  ListView(children: const [
         Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: 20),
             Padding(
               padding: EdgeInsets.only(left:10.0),
               child: Text("Interdits à l'export",textAlign: TextAlign.left,textDirection: TextDirection.ltr,style: TextStyle(
                fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                
        
                ),

                ),

             ),
             Padding(padding: EdgeInsets.only( top : 10,left: 30),
             child: Text("1. Animaux vivants.")
             ),
             Padding(padding: EdgeInsets.only(left: 30),
             child: Text("2. Plantes vivantes.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("3. Armes.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("4. Projectiles et sarbes.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("5. Couteaux et sabres.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("6. Produits chimiques.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("7. Liquides inflammables.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("8. Substances et matiéres radiocatives.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("9. Matiéres toxiques et substances infectieuses.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("10. Stupéfiant et drogue.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("11. Livres et tout manuscrit, film et autres articles portant atteinte à la morailité et aux bonnes.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("12. Objets qui, par leur nature ou leur emballage,peuvent présenter un danger pour les agents, salir ou détériorer les correspondances .")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("13. Pornogarphie.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("14. Antiquité.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("15. Alcool sauf boissons alcoolisées.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("16. Méteaux et pierres précieuses.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("17. Argents, billets de banques nationales ou en devises étrangéres.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("18. Fourrures animales.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("19. Dépouilles ou cendres d'un corps humain.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("20. Talisman, Sorcellerie.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("21. Prélèvement de sang.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("22. Marchandises contrefaites et piratées.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("23. Parafums.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("24. Dérivés de proc vers les pays musulmans.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("25. Batteries et piles au lithium.")
             ),


             //sapce 

             SizedBox(height: 20),
             Padding(
               padding: EdgeInsets.only(left:10.0),
               child: Text("Objects admis conditionnellement",textAlign: TextAlign.left,textDirection: TextDirection.ltr,style: TextStyle(
                fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                
        
                ),

                ),

             ),
              Padding(padding: EdgeInsets.only( top : 10,left: 30),
             child: Text("1. Produit dangereux : explosifs , inflammables,toxiques, radioactive et tous les produits qui représentent un danger pour l'avion et les passagers.")
             ),
             Padding(padding: EdgeInsets.only(left: 30),
             child: Text("2. Produit chimiques et liquides industriels par présentation d'une fiche technique du produit MSDS.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("3. Produit pharmaceutique pour particulier : par une ordinnance médicale.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("4. Antiquité et patrimoine national : une autorisation du Ministére concerné.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("5. Plantes à usage cosmétique ou médical: sous réserve de présenter une autorisation phytosanitaire.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("6. Fossiles : par une autorisation  d'exploitation du Ministére concerné.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("7. Produits cosmétiques contrôle sanitaire.")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("8. Passeports, sauf en cas d'autorisation d'exploitation du Ministére de l'intérieur et des Affaires étragéres .")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("9. Cassette-vidéo contrôle de contenu")
             ),Padding(padding: EdgeInsets.only(left: 30),
             child: Text("10. Produits et aliments périssables :par un emballage spécifique.")
             ),
             Padding(padding: EdgeInsets.only(top:15 ,left: 30),
             child: Text("Les envois Amana à l'étranger sont soumis à un contrôle douanier pour s'assurer de la conformité du contenu et se garantir des documents d'accompagnement")
             ),
                SizedBox(height:30)
          ],

        )
      ],
      
      ),
      bottomNavigationBar:const NavBottom(),
    );
  }
}