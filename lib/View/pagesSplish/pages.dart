import 'package:flutter/material.dart';

void main() {
  runApp(const MapApp());
}

class MapApp extends StatefulWidget {
  const MapApp({super.key});

  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  color: Colors.orange,
                ),
              ),
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                  child: ListView(
                children: [
                  const Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Feedback sur l'expeérience de livraison à domicile",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "  *1 étant la note la plus faible,5 étant la note la plus élevée",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      )),

                  //--------------------------------------
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Etes-vous expéditeur ou destinataire ",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RadioListTile(
                            title: const Text('Expéditeur'),
                            value: 2,
                            groupValue: "",
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RadioListTile(
                            title: const Text("Destinataire"),
                            value: 2,
                            groupValue: "",
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),

                        //******************************* */
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  " Avez-vous recu/envoyé un courrier ou un colis",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('Courrier'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('Colis'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        /**-------------------------------------------------------------- */
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Dans quell ville",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: TextFormField(
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 243, 114, 33),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //************************** */

                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  " A quel point étes-vous satisfait de ce mode de livraison",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('1'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('2'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('3'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('4'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('5'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //------------------------------------------------------
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  " Quelle noter attribuez-vous à voter livreur",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('1'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('2'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('3'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('4'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('5'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        /****************/
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  " Avez-vous des commentaires ou des suggestios d'amélioration :",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 450,
                                    child: TextFormField(
                                      maxLines: 4,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 243, 114, 33),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
            )));
  }
}

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  color: Colors.orange,
                ),
              ),
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                  child: ListView(
                children: [
                  const Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Feedback sur l'expeérience avec le call center",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "  *1 étant la note la plus faible,5 étant la note la plus élevée",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      )),

                  //--------------------------------------
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Avez-vous trouvé facilement le numéro de téléphone pour joindre notre call center ",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RadioListTile(
                            title: const Text('Oui'),
                            value: 2,
                            groupValue: "",
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RadioListTile(
                            title: const Text("Non"),
                            value: 2,
                            groupValue: "",
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),

                        //******************************* */
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  " Etes-vous satisfait de voter expérience avec noter call center",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('Oui'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('Non'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        /**-------------------------------------------------------------- */
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  " Avez-vous eu une réponce par rapport à  voter demande ou réclamation ",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('Oui'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('Non'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //************************** */

                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  " Quelle noter donnez-vous au conseiller qui vous a pris en charge",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('1'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('2'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('3'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('4'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RadioListTile(
                                  title: const Text('5'),
                                  value: 2,
                                  groupValue: "",
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        /****************/
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  " Avez-vous des commentaires ou des suggestios d'amélioration :",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 450,
                                    child: TextFormField(
                                      maxLines: 4,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 243, 114, 33),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
            )));
  }
}
