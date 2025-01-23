import 'package:flutter/material.dart';

import '../Menu/MenuSide.dart';

void main() {
  runApp(const MapAppt());
}

class MapAppt extends StatefulWidget {
  const MapAppt({super.key});

  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapAppt> {
  bool envoiNatio = true;
  bool envioInterna = false;
  bool ecomerse = false;
  Alignment gh = Alignment.bottomCenter;

  void _envoiNatio() {
    setState(() {
      if (envoiNatio == !true) {
        envoiNatio = !envoiNatio;
        envioInterna = false;
        ecomerse = false;
      }
    });
  }

  void _envioInterna() {
    setState(() {
      if (envioInterna == !true) {
        envioInterna = !envioInterna;
        envoiNatio = false;

        ecomerse = false;
      }
    });
  }

  void _ecomerse() {
    setState(() {
      if (ecomerse == !true) {
        ecomerse = !ecomerse;
        envoiNatio = false;

        envioInterna = false;
      }
    });
  }

  bool isPanelOpen = false;
  int selectedIdx = -1;
  int selectedOption = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
            key: _scaffoldKey,
        appBar: appB(context),
        drawer:darweF(context),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                    padding:
                        const EdgeInsets.only(left: 18, right: 5, top: 5, bottom: 5),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: _envoiNatio,
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 216, 203, 183),
                              textStyle: const TextStyle(fontSize: 15),
                              padding: const EdgeInsets.all(18)),
                          child: const Text('ENVOI NATIONAL'),
                        )
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: _envioInterna,
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 216, 203, 183),
                              textStyle: const TextStyle(fontSize: 15),
                              padding: const EdgeInsets.all(18)),
                          child: const Text('ENVOI INTERNA'),
                        )
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: _ecomerse,
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 216, 203, 183),
                              textStyle: const TextStyle(fontSize: 16),
                              padding: const EdgeInsets.only(
                                  left: 28, right: 28, top: 18, bottom: 18)),
                          child: const Text('ECOMERCE'),
                        )
                      ],
                    )),
              ],
            ),
            Visibility(
                visible: envoiNatio,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: Container(
                    color: const Color.fromARGB(255, 237, 236, 236),
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextField(
                            decoration: InputDecoration(
                              hintTextDirection: TextDirection.ltr,
                              hintText: 'Poids',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 243, 114, 33),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 0, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 123, 123, 123),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Row(
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Type d'enballage"),
                                ),
                                const SizedBox(
                                  width: 185,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color.fromARGB(255, 0, 0, 0), backgroundColor: const Color.fromARGB(255, 240, 133, 26),
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5), // Set the border radius of the button
                                      ),
                                    ),
                                    child: const Text('Sans emballage'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 50, top: 5, bottom: 5),
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: _ecomerse,
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 216, 203, 183),
                                      textStyle: const TextStyle(fontSize: 18),
                                      padding: const EdgeInsets.only(
                                          left: 150,
                                          right: 150,
                                          top: 15,
                                          bottom: 15)),
                                  child: const Text('Calculer'),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                )),
            Visibility(
                visible: envioInterna,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: Container(
                    color: const Color.fromARGB(255, 237, 236, 236),
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextField(
                            decoration: InputDecoration(
                              hintTextDirection: TextDirection.ltr,
                              hintText: 'Poids',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 243, 114, 33),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 8, top: 5, bottom: 5),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: _ecomerse,
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: const Color.fromARGB(255, 111, 108, 108), backgroundColor: const Color.fromARGB(255, 237, 236, 236),
                                        textStyle: const TextStyle(fontSize: 15),
                                        padding: const EdgeInsets.only(
                                            left: 0,
                                            right: 382,
                                            top: 25,
                                            bottom: 25)),
                                    child: const Text(
                                      ' Nom pays',
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 0, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 123, 123, 123),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Row(
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Type d'enballage"),
                                ),
                                const SizedBox(
                                  width: 185,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color.fromARGB(255, 0, 0, 0), backgroundColor: const Color.fromARGB(255, 240, 133, 26),
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5), // Set the border radius of the button
                                      ),
                                    ),
                                    child: const Text('Sans emballage'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 20, right: 5),
                              width: 150,
                              height: 50,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintTextDirection: TextDirection.ltr,
                                  hintText: 'Longeur  ',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 243, 114, 33),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 5),
                              width: 150,
                              height: 50,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintTextDirection: TextDirection.ltr,
                                  hintText: 'Largeur',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 243, 114, 33),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 5),
                              width: 150,
                              height: 50,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintTextDirection: TextDirection.ltr,
                                  hintText: 'Hauteur',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 243, 114, 33),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 50, top: 5, bottom: 5),
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: _ecomerse,
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 216, 203, 183),
                                      textStyle: const TextStyle(fontSize: 18),
                                      padding: const EdgeInsets.only(
                                          left: 150,
                                          right: 150,
                                          top: 15,
                                          bottom: 15)),
                                  child: const Text('Calculer'),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                )),
           
                   Visibility(
              visible: ecomerse,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                child: Container(
                  color: const Color.fromARGB(255, 237, 236, 236),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 0, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 123, 123, 123),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 50),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 20),
                                              Radio(
                                                  value: 'INTRAVILE',
                                                  groupValue: selectedOption,
                                                  onChanged: (val) {
                                                    setState(() {});
                                                  }),
                                              const Text('INTRAVILE'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 50, right: 10),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 20),
                                              Radio(
                                                  value: 'DOMICILE',
                                                  groupValue: selectedOption,
                                                  onChanged: (val) {
                                                    setState(() {
                                                    });
                                                  }),
                                              const Text('DOMICILE'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 50),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 20),
                                              Radio(
                                                  value: 'INTERVIL',
                                                  groupValue: selectedOption,
                                                  onChanged: (val) {
                                                    setState(() {});
                                                  }),
                                              const Text('INTERVIL'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 53),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 20),
                                              Radio(
                                                  value: 'EN AGENCE',
                                                  groupValue: selectedOption,
                                                  onChanged: (val) {
                                                    setState(() {
                                                    });
                                                  }),
                                              const Text('EN AGENCE'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(padding:  const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                         child:  Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextField(
                            decoration: InputDecoration(
                              hintTextDirection: TextDirection.ltr,
                              hintText: 'Poids',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 243, 114, 33),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, top: 5, bottom: 5),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: _ecomerse,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 216, 203, 183),
                                textStyle: const TextStyle(fontSize: 18),
                                padding: const EdgeInsets.only(
                                    left: 150, right: 150, top: 15, bottom: 15),
                              ),
                              child: const Text('Calculer'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar:const NavBottom(),

      ),
    );
  }
}