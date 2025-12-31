import 'package:flutter/material.dart';

class Amanamesager extends StatefulWidget {
  const Amanamesager({super.key});

  @override
  _Amanamesager createState() => _Amanamesager();
}

class Poop {
  Poop(
      this.title,
      this.body1,
      this.body2,
      this.body3,
this.body4,
this.body5,
      [this.isExpanded = true]
    );
  String title;
  String body1;
 String body2;
 String body3;
 String body4;
 String body5;
  bool isExpanded;
 
}

List<Poop> getPoop() {
  return [
    Poop('Avatages','• Sécurité renforcée pour le transport de documents de valeurs ' ,'• Service de traçabilité . ','• Retour de fonds crédité sur votre compte le jour même de la livraison ;',
    '• Une relation commerciale personnalisée : un commercial dédié ,','• Un service middle office et un service après - vente .'
    
    
    ),
  ];
}
class Step {
  Step(
      this.title,
      this.body1,
      this.body2,
      this.body3,
      this.body4,
      this.body5,
      this.body6,
      this.body7,
      this.body8,
      this.body9,
      this.body10,
      this.body11,
      this.body12,
       this.body13,
      this.body14,
      this.body15,
      this.body16,
      this.body17,
      this.body18,
      this.body19,
      this.body20,
       [this.isExpanded = true]
    );
  String title;
  String body1;
  String body2;
  String body3;
  String body4;
  String body5;
  String body6;
  String body7;
  String body8;
  String body9;
  String body10;
  String body11;
  String body12;
  String body13;
  String body14;
  String body15;
  String body16;
  String body17;
  String body18;
  String body19;
  String body20;
  bool isExpanded;
 
}

List<Step> getSteps() {
  return [
    Step(
        'Caractéristiques',
        "• Des délais de livraison allant de 1 à 2 jours selon la destination;" ,
         "• Réseau étendu pour vos livraisons (plus de 1800 points de contact);" ,
        "• Mise en instance au guichet pour plus de proximité avec vos clients finaux;" ,
            "• Des solutions adaptées selon votre besoin et les exigences de votre métier:" ,
            "• Offre sacoches: pour répondre aux besoins des entreprises/banques en réseau en matière de transport de documents de valeur." ,
            "• Offre marchandises: dédiées aux entreprises ayant une présence régionale pour le transport de leurs marchandises (franchises, magasins, agences, etc)." ,
            "• Des délais de livraison allant de 1 à 2 jours selon la destination;" ,
            "• Réseau étendu pour vos livraisons (plus de 1800 points de contact);" ,
            "• Mise en instance au guichet pour plus de proximité avec vos clients finaux;" ,
            "• Des solutions adaptées selon votre besoin et les exigences de votre métier:" ,
            "• Offre sacoches: pour répondre aux besoins des entreprises/banques en réseau en matière de transport de documents de valeur." ,
            "• Offre marchandises: dédiées aux entreprises ayant une présence régionale pour le transport de leurs marchandises (franchises, magasins, agences, etc)." ,
            "• Offres documents: adaptée à toute entreprise ayant le besoin de transport de toute sorte de document administratifs sous enveloppes ou cartons." ,
            "• Offre intra ville: adressée aux banques et aux entreprises souhaitant un transport dédié à l'intérieur de la même ville ou périphérie." ,
            "• Offre e-commerce: Livraison à domicile via 2 tentatives avec utilisation préalable d'alerte SMS et d'appels téléphoniques dans plus de 52 villes." ,
            "• Livraison tardive tous les jours jusqu'à 19h00 et le samedi matin;• Sécurité renforcée pour le transport de documents de valeurs" ,
            "• Service de traçabilité." ,
            "• Retour de fonds crédité sur votre compte le jour même de la livraison;" ,
            "• Une relation commerciale personnalisée : un commercial dédié," , "• Un service middle office et un service après-vente." ),
  ];
}

class _Amanamesager extends State<Amanamesager> {
  String Amanamessag =
      'Amana Messagerie Nationale est le service assurant la collecte ,le transport et la livraison' 'des colis et des documents partout au Maroc dans des délais express garantis en fonction des destination.';

  final List<Step> _steps = getSteps();

  final List<Poop> _poop = getPoop();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            color: const Color.fromARGB(255, 238, 232, 232),
            child: ListView(
              
            children: [
              Container(
                width: 500,
                height: 300,
                color: Colors.orange,
                child:Image.asset("assets/images/AmanaDelivery.jpg"),

              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'AMANA',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 220, 60, 7),
                              fontSize: 25),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Aussitot envoyé, aussitot livré',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 25,
              ),
              Padding(
                  padding:
                    const  EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 10),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'AmanaMessagerie Nationale',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 220, 60, 7),
                              fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          Amanamessag,
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => const Amanamesager());
                            Navigator.push(context, route);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:const  Color.fromARGB(255, 220, 60, 7),
                              foregroundColor: Colors.white,
                              textStyle:const TextStyle(fontSize: 15),
                              padding:const EdgeInsets.only(
                                  left: 130, right: 130, top: 15, bottom: 15)),
                          child: const Text('CALCULER UN TARIF'),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
             Container(
              child:   ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _steps[index].isExpanded = !isExpanded;
                  });
                },
                children: 
                 _steps.map<ExpansionPanel>((Step step) {
                    
                  return ExpansionPanel(
                       backgroundColor: Colors.red,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(step.title),
                      );
                    },
                    body: Padding(padding: const EdgeInsets.all(10),
                    child: ListBody(children: [
                       Text(step.body1,textAlign: TextAlign.left,),
                       Text(step.body2,textAlign: TextAlign.left,),
                       Text(step.body3,textAlign: TextAlign.left,),
                       Text(step.body4,textAlign: TextAlign.left,),
                       Text(step.body5,textAlign: TextAlign.left,),
                       Text(step.body6,textAlign: TextAlign.left,),
                       Text(step.body7,textAlign: TextAlign.left,),
                       Text(step.body8,textAlign: TextAlign.left,),
                       Text(step.body9,textAlign: TextAlign.left,),
                       Text(step.body10,textAlign: TextAlign.left,),
                       Text(step.body11,textAlign: TextAlign.left,),
                       Text(step.body12,textAlign: TextAlign.left,),
                       Text(step.body13,textAlign: TextAlign.left,), 
                       Text(step.body14,textAlign: TextAlign.left,), 
                       Text(step.body15,textAlign: TextAlign.left,), 
                       Text(step.body16,textAlign: TextAlign.left,), 
                       Text(step.body17,textAlign: TextAlign.left,),
                       Text(step.body18,textAlign: TextAlign.left,), 
                       Text(step.body19,textAlign: TextAlign.left,), 
                       Text(step.body20,textAlign: TextAlign.left,),
                    ],),
                    ),
                    isExpanded: step.isExpanded,
                  );
                }
               ).toList(),
              ),
            ),const SizedBox(height: 10,),
             Container(
              child:   ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _poop[index].isExpanded = !isExpanded;
                  });
                },
                children: 
                 _poop.map<ExpansionPanel>((Poop poop) {
                    
                  return ExpansionPanel(
                       backgroundColor: Colors.white,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(poop.title),
                      );
                    },
                    body: Padding(padding: const EdgeInsets.all(10),
                    child: ListBody(children: [
                       Text(poop.body1,textAlign: TextAlign.left,),
                       Text(poop.body2,textAlign: TextAlign.left,),
                       Text(poop.body3,textAlign: TextAlign.left,),
                       Text(poop.body4,textAlign: TextAlign.left,),
                       Text(poop.body5,textAlign: TextAlign.left,),
                     
                    ],),
                    ),
                    isExpanded: poop.isExpanded,
                  );
                }
               ).toList(),
              ),
            )
            ],
                  ),
          ),
    );
  }
}
