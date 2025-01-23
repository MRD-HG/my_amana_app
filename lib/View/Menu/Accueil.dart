import "package:flutter/material.dart";

import "../resultat.dart";
import "MenuSide.dart";
class Accueila extends StatefulWidget {
  const Accueila({super.key});

  @override
  State<Accueila> createState() => _AccueilaState();
}

class _AccueilaState extends State<Accueila> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: Container(
        child: Column(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height) * 0.3,
              width: (MediaQuery.of(context).size.width) * 1,
              color: Colors.orange,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                   const  Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Icon(
                            Icons.map,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 40),
                          child: Text("Suivi",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 250, top: 40),
                          child:  Text(
                            "+Historique",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:20),
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          filled: true,
                          border: InputBorder.none,
                          labelStyle:
                              const TextStyle(color: Colors.grey, fontSize: 15),
                          labelText: "SCANNER OU SAISIR VOTRE CODE",
                          suffixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
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
                                onPressed: (){},
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:40.0),
              child: Card(

                  elevation: 60,
                  child: Container(
                    color: Colors.white,
                    height: (MediaQuery.of(context).size.height) * 0.08,
                    width: (MediaQuery.of(context).size.width) * 0.85,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text(
                            "Numéro de Suivi",
                            style: TextStyle(color: Colors.orange[800]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 150),
                          child: Text(
                            "Action",
                            style: TextStyle(
                              color: Colors.orange[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
      bottomNavigationBar: const NavBottom(),
    );
  }

