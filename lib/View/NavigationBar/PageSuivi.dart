import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';

class PageSuiv extends StatefulWidget {
  const PageSuiv({super.key});

  @override
  State<PageSuiv> createState() => _PageSuivState();
}

class _PageSuivState extends State<PageSuiv> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: const BodySuiv(),
    );
  }
}
class BodySuiv extends StatefulWidget {
  const BodySuiv({super.key});

  @override
  State<BodySuiv> createState() => _BodySuivState();
}

class _BodySuivState extends State<BodySuiv> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Scaffold(
      
      body: Center(
        child: Stack(
          children: [
            Container(
              height: size.height * .10,
              color: Colors.redAccent,
              

            )
          ],

        )
      ),


    );
  }
}