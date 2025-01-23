import 'package:flutter/material.dart';

import '../Menu/MenuSide.dart';

class FaQ extends StatefulWidget {
  const FaQ({super.key});

  @override
  State<FaQ> createState() => _FaQState();
}

class _FaQState extends State<FaQ> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: ListView(
        children: [
         const Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 10,top:40),
                child: Column(
                  children: [
                    Card(
                      shadowColor: Colors.black54,
                      elevation: 50,
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: Text("Comment puis-je m'assurer que mon colis a été bien reçu ?"),
                            children: [
                              Padding(
                                padding:  EdgeInsets.all(3),
                                child: Text(
                                    "Vous pouvez vous assurer de la livraison de vos envois grâce au service SMS optionnel ''notification de livraison expéditeur'' ou bien suivre votre envoi grâce au site web: https://bam-tracking.barid.ma/ ou sur l'application My Amana"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shadowColor: Colors.black54,
                      elevation: 50,
                      child: Column(
                        children: [
                          ExpansionTile(
                            backgroundColor: Colors.red,
                            title: Text("Comment puis-je bénéficier du service de contre remboursement ?"),
                            controlAffinity: ListTileControlAffinity.leading,
                            children: [
                              Text("database"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox( // Wrap the ListView with a Container and provide a fixed height
            height: 100, // Adjust the height as per your requirement
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () {},
                    child: ElevatedButton(style: ElevatedButton.styleFrom(fixedSize: Size((MediaQuery.of(context).size.width)*0.09, (MediaQuery.of(context).size.height)*0.02)),
                      onPressed: () {},
                      child: const Text("FAQ"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {},
                    child: ElevatedButton(style: ElevatedButton.styleFrom(fixedSize: Size((MediaQuery.of(context).size.width)*0.09, (MediaQuery.of(context).size.height)*0.02)),
                      onPressed: () {},
                      child: const Text("Generales"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {},
                    child: ElevatedButton(style: ElevatedButton.styleFrom(fixedSize: Size((MediaQuery.of(context).size.width)*0.09, (MediaQuery.of(context).size.height)*0.02)),
                      onPressed: () {},
                      child: const Text("AvantDepot"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {},
                    child: ElevatedButton(style: ElevatedButton.styleFrom(fixedSize: Size((MediaQuery.of(context).size.width)*0.09, (MediaQuery.of(context).size.height)*0.02)),
                      onPressed: () {},
                      child: const Text("Generales"),
                    ),
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {},
                    child: ElevatedButton(style: ElevatedButton.styleFrom(fixedSize: Size((MediaQuery.of(context).size.width)*0.09, (MediaQuery.of(context).size.height)*0.02)),
                      onPressed: () {},
                      child: const Text("Generales"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
