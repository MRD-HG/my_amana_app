import 'package:flutter/material.dart';

import 'package:my_amana_app/View/pagesSplish/simulator.dart';


class Geolocalistion extends StatefulWidget {
  const Geolocalistion({super.key});

  @override
  State<Geolocalistion> createState() => _GeolocalistionState();
}

class _GeolocalistionState extends State<Geolocalistion> {
  @override
  Widget build(BuildContext context) {
   return   Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        
        
          
          
             child: Column(
            
            children:  [
              
             const Padding(padding: EdgeInsets.only(top:130),
              child: 
              Image(image: AssetImage('images/geoloca.png'),width: 150,height: 150,),
              
      
              ),
            const  Padding(padding: EdgeInsets.only(top: 40),
              child: Text('Géolocalistaion',textAlign: TextAlign.center, style: TextStyle(
                color:Colors.orange,fontSize: 18,
                fontFamily: AutofillHints.countryName,
                fontWeight: FontWeight.bold ),),
              ),
              const   Padding(padding:EdgeInsets.only(top:30),
                 child: Text('Trouver l\'agence Amana la plus proche de vous', textAlign: TextAlign.center, style: TextStyle(color:Color.fromARGB(255, 160, 152, 152),fontSize: 10),)
                 ),
                const SizedBox(height: 60),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Padding(padding:const EdgeInsets.only(top:50),
                
                    child: GestureDetector(
                      onTap: () {
                      Route  route =  MaterialPageRoute(builder:  ((context) =>  const Simulateur()),);

                         Navigator.pushReplacement(context,route );
                        },
                        child:const Text(
                          
                          'PASSER CETTE ETAPE',textAlign: TextAlign.center, style: TextStyle(color:Colors.orange,fontSize: 12),
                          
                        ),
                        
                  ),
                  )
                )
                  
                 
            ],
          
        ),
      

          
          
      
        
       ),
       
      
      

    );
  }
}