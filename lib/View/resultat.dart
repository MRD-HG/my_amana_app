import 'package:flutter/material.dart';

import 'Menu/MenuSide.dart';

class Resultat extends StatefulWidget {
  const Resultat({super.key});

  @override
  State<Resultat> createState() => _ResultatState();
}

class _ResultatState extends State<Resultat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                elevation: 10,
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const  Padding(
                      padding:  EdgeInsets.only(left:8.0,top:10),
                      child:  Text("57895",style:TextStyle(fontWeight: FontWeight.bold) ,),
                    ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left:8.0),
                          child: Text("INEXISTANT - INEXISTANT",style: TextStyle(fontSize: 9),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:300),
                          child: Text("0 KG",style:TextStyle(fontWeight: FontWeight.bold) ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left:10.0),
                          child: Text("Paiment à la livrainson",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left :50),
                          child: Text("INEXISTANT DH",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                   const Padding(
                      padding:  EdgeInsets.only(left :8.0),
                      child:  Text("livre à domicile le  ",style: TextStyle(color: Colors.grey,fontSize: 10)),
                    ),
                   const Padding(
                      padding:  EdgeInsets.only(left:8.0),
                      child:  Text("NA",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset("assets/Icons/store.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                            color: Colors.grey,
                              // border color
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset("assets/Icons/destination.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                            color: Colors.grey,
                              // border color
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset("assets/Icons/fast-delivery.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                            color: Colors.grey,
                              // border color
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset("assets/Icons/delivered.png"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right :80),
                child: Text("Information sur l'expédition",style:TextStyle(color: Colors.grey)),
              ),
              Card(

                  child: Container(
                    color: Colors.white,
                    height:( MediaQuery.of(context).size.height)*0.09,
                    width: (MediaQuery.of(context).size.width)*0.8,
                    child: Text(
                                  "VOIR EN DETAILS",
                                  style: TextStyle(color: Colors.orange[800]),
                                ),
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBottom(),
    );
  }
}
