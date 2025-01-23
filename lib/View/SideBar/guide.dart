import "package:flutter/material.dart";
import "package:my_amana_app/View/Menu/MenuSide.dart";
class GuideBonn extends StatelessWidget {
  const GuideBonn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: Container(
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.insert_drive_file_rounded,size: 30),
                ),
                SizedBox(width:35 ,),
                Text("Guide des bonnes pratiques", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
              ],
            )

          ],
        ) 
        ,
      )
      ,
    );
  }
}