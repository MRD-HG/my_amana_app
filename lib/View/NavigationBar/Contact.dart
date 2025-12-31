import 'package:flutter/material.dart';

import '../Menu/MenuSide.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
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
  bool _switchValue = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      bottomNavigationBar: const NavBottom(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
                          hintText: 'Nom et Prénom',
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
                      child: TextField(
                        decoration: InputDecoration(
                          hintTextDirection: TextDirection.ltr,
                          hintText: 'Email',
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
                      child: TextField(
                        decoration: InputDecoration(
                          hintTextDirection: TextDirection.ltr,
                          hintText: 'Numéro de téléphone',
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
                      child: TextField(
                        decoration: InputDecoration(
                          hintTextDirection: TextDirection.ltr,
                          hintText: 'Numéro de suivi',
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
                              child: Text("Objet"),
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
                                child: const Text("Demande d'information"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextFormField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintTextDirection: TextDirection.ltr,
                          hintText: 'Message',
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
                          width: 500,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            border: Border.all(
                              color: const Color.fromARGB(255, 123, 123, 123),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child:
                                    Text("J'accepte les termes et conditions"),
                                  
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            Padding(padding: const EdgeInsets.only(left: 150),
                            
                          child:  Switch(
                                  value: _switchValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _switchValue = value;
                                    });
                                  },
                                  activeTrackColor: Colors.orange,
                                  activeColor: Colors.white,
                                  inactiveTrackColor: Colors.grey,
                                  inactiveThumbColor: Colors.grey,
                                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                            )
                             
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 10,
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
                                       left: 150,
                                      right: 150,
                                      top: 15,
                                      bottom: 15)),
                              child: const Text('ENVOYER'),
                            )
                          ],
                        )),
                          Padding(
                        padding: const EdgeInsets.only(left: 50, top: 5, bottom: 5),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: _ecomerse,
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 220, 60, 7),
                                  textStyle: const TextStyle(fontSize: 18),
                                  padding: const EdgeInsets.only(
                                      left: 65,
                                      right: 65,
                                      top: 15,
                                      bottom: 15)),
                              child: const Text('CONTACTER UN COMMERCIAL'),
                            )
                          ],
                        )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
