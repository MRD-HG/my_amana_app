
import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';

import '../Facteure/LogFact.dart';
import '../PageMenu.dart';


class Simulateur extends StatefulWidget {
  const Simulateur({super.key});

  @override
  State<Simulateur> createState() => _SimulateurState();
}

class _SimulateurState extends State<Simulateur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 80),
                child: Image(
                  image: AssetImage('images/Calulator.jpg'),
                  width: 150,
                  height: 150,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(

                  'Simulateur',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                      fontFamily: AutofillHints.countryName,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'Calculer le tarif de vos envois',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 160, 152, 152),
                        fontSize: 10),
                  )),
              const SizedBox(
                height: 150,
              ),
              ElevatedButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(
                        builder: ((context) => const AppShell()));

                    Navigator.pushReplacement(context, route);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      fixedSize: const Size(100, 20)),
                  child: const Text("ALLONS-Y!"))
            ],
          ),
        ),
      ),
    );
  }
}

class Choisir extends StatelessWidget {
  const Choisir({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(82),
      child: Container(
          height: 600,
          width: 350,
          color: Colors.white60,
          child: Card(
              color: Colors.white,
              elevation: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0, right: 20),
                    child: Image.asset(
                      "assets/images/logoProAmana.png",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Route route = MaterialPageRoute(
                            builder: ((context) => const pageMenu()),
                          );
                          Navigator.pushReplacement(context, route);
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                (MediaQuery.of(context).size.width) * 0.5,
                                (MediaQuery.of(context).size.height) * 0.1),
                            backgroundColor: Colors.orange),
                        child: const Text(
                          'Client',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Route route = MaterialPageRoute(
                              builder: ((context) => const LoginFact()));
                          Navigator.pushReplacement(context, route);
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                (MediaQuery.of(context).size.width) * 0.5,
                                (MediaQuery.of(context).size.height) * 0.1),
                            backgroundColor: Colors.orange),
                        child: const Text(
                          'Facteur',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ),
                ],
              ))),
    ));
  }
}

