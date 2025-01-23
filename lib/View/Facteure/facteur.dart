import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../Menu/MenuSide.dart';
class Facteur extends StatefulWidget {
  const Facteur({super.key});

  @override
  State<Facteur> createState() => _FacteurState();
}

class _FacteurState extends State<Facteur> {
  String selectedColis = '121021021';

  List<String> pop=[
    "121021021",
    "985240032",
    "120300200",
    "121021120",
    "121021020",
    "132006101"

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appB(context),
      drawer: darweF(context),
      body:Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton2(
                  
                    isExpanded: true,
                    hint: Container(
                      child:const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Colis',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 103, 103, 103),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    items: pop
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
                        value:selectedColis,
                       
                    onChanged: (value) {
                     setState(() {
                       selectedColis=value as String;
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
             Text('Vous avez choisi La Colis :  $selectedColis'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              
              child: Row(
                children: [
                  const Text("Tout delivery"),
                  Checkbox(value:false , onChanged: (value) {
                
              },),
                ],
              )
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
              elevation: 10,
              fixedSize: const Size(150, 50),
              backgroundColor: Colors.orange[800]
            ),  child: const Text("Sauvgarder"),),
          )
          ],
        ),
      ) ,
      bottomNavigationBar:const NavBottom(),
    );
  }
}