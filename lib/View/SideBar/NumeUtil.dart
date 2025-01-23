import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/services.dart';

import '../Menu/MenuSide.dart';

class NumeroTlf extends StatefulWidget {
  const NumeroTlf({super.key});

  @override
  State<NumeroTlf> createState() => _NumeroTlfState();
}

class _NumeroTlfState extends State<NumeroTlf> {
  List<dynamic> agents = [];
  String selectedRegion = 'Tout';
  Future<void> fetchAgent() async {
    final jsonData = await rootBundle.loadString('assets/phone.json');
    final getdata = await json.decode(jsonData);
    agents = getdata['List']
        .where((agent) => agent['Region'] == selectedRegion)
        .toList();
  }

  int selectedIdx = -1;
  int selectedOption = 1;
  final List<String> items = [
    'Tout',
    'Rabat',
    'Casablanca',
    'Tanger',
    'Fés-Meknés',
    'Oujda',
    'Agadir',
    'Marrakech',
  ];
  String? selectedValue;
  @override
  void initState() {
    super.initState();
    fetchAgent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appB(context),
        drawer: darweF(context),
        body: Container(
            child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      color: Colors.white,
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                color: Colors.orange[900],
                                width: 70,
                                height: 70,
                                child: const Icon(Icons.call,
                                    color: Colors.white, size: 30),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Center National de débouanement postal",
                                    style: TextStyle(color: Colors.orange[900]),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Tel: 0522 33 91 35",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              ),
                            ],
                          ))),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Card(
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            color: Colors.orange[900],
                            width: 70,
                            height: 70,
                            child: const Icon(Icons.call,
                                color: Colors.white, size: 30),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Center d'appel",
                                style: TextStyle(color: Colors.orange[900]),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Tel: 080 200 60 60",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        ],
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Card(
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                              color: Colors.orange[900],
                              width: 70,
                              height: 70,
                              child: const Icon(Icons.call,
                                  color: Colors.white, size: 30)),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Numéro dédié à la gestion de la collecte",
                                style: TextStyle(color: Colors.orange[900]),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Tel: 0522 34 44 93",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        ],
                      ))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Contacter un commercial",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton2(
                  
                    isExpanded: true,
                    hint: Container(
                      child:const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Région',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 103, 103, 103),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                        value: selectedRegion,
                    onChanged: (value) {
                      setState(() {
                        selectedRegion = value as String;
                        fetchAgent();
                      });
                     
                    },
                    buttonStyleData: const ButtonStyleData(
                      height: 40,
                      width: 450,
                      padding: EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(color: Colors.white),
                      elevation: 2,
                    ),
                    dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: 800,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 8,
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: WidgetStateProperty.all(6),
                          thumbVisibility: WidgetStateProperty.all(true),
                        )),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: agents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                color: Colors.orange[900],
                                width: 70,
                                height: 70,
                                child: const Icon(
                                  Icons.call,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    agents[index]['Agent'],
                                    style: TextStyle(
                                      color: Colors.orange[900],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    agents[index]['Tel'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    agents[index]['Email'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    agents[index]['Region'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        ),
        bottomNavigationBar:const NavBottom(),
        );
  }
}
