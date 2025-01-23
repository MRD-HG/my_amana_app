import 'package:flutter/material.dart';
import 'package:my_amana_app/View/pagesSplish/geolocal.dart';




class pageMenu extends StatefulWidget {
  const pageMenu({super.key});

  @override
  State<pageMenu> createState() => _pageMenuState();
}

class _pageMenuState extends State<pageMenu> {
  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
      

       body: AppCode() ,
      
    );
  }
}
class AppCode extends StatefulWidget {
  const AppCode({super.key});

  @override
  State<AppCode> createState() => _AppCodeState();
}

class _AppCodeState extends State<AppCode> {
  @override
  Widget build(BuildContext context) {
    
    return   Scaffold(
      backgroundColor:  Colors.white,
      body: Center(
        
        
          
          
             child: Column(
            
            children:  [
              
             const Padding(padding: EdgeInsets.only(top:130),
              child: 
              Image(image: AssetImage('assets/images/trackingLogo.jpg'),width: 150,height: 150,),
              
      
              ),
            const  Padding(padding: EdgeInsets.only(top: 40),
              child: Text('Tracking',textAlign: TextAlign.center, style: TextStyle(
                color:Colors.orange,fontSize: 18,
                fontFamily: AutofillHints.countryName,
                fontWeight: FontWeight.bold ),),
              ),
              const   Padding(padding:EdgeInsets.only(top:30),
                 child: Text('suivez vos envoi en temps réel ', textAlign: TextAlign.center, style: TextStyle(color:Color.fromARGB(255, 160, 152, 152),fontSize: 10),)
                 ),
                const SizedBox(height: 102),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Padding(padding:const EdgeInsets.only(top:10),
                
                    child: GestureDetector(
                      onTap: () {
                      Route  route =  MaterialPageRoute(builder:  ((context) =>  const Geolocalistion()));

                         Navigator.pushReplacement(context,route );
                        },
                        child:const Text(
                          
                          'PASSER CETTE ETAPE',textAlign: TextAlign.center, style: TextStyle(color:Colors.orange,fontSize: 12),
                          
                        ),
                        
                  ),
                  )
                ),
                 
                  
                 
            ],
          
        ),
      

          
          
      
        
       ),
       
      
      

    );
  }
}

/*
appBar:AppBar(
          backgroundColor: Colors.white,
             elevation: 0,
          leading: IconButton(onPressed: (){}, icon:const Icon(Icons.arrow_back),color: Colors.black,)  ,
          
          ),
     body:Container(
      child:Column(
        children:[
          Padding(
            padding: const EdgeInsets.only(left: 60,top: 5,right: 15,bottom: 15),
            child: RichText(text: const TextSpan(text: "Connexion/Inscription à Eat",style: TextStyle(color: Colors.black , 
            fontSize: 26,
            fontWeight: FontWeight.bold
            ),
            children:[
              TextSpan(text: "sly",style: TextStyle(color: Colors.orange, fontSize: 26,
            fontWeight: FontWeight.bold))
            ] 
            
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 2)
                ),
                border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(3)),borderSide: BorderSide(width: 5,color: Colors.black)),
                hintText: "E-mail",
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 2)
                )
              ),
              
            ),
          ),
          ElevatedButton(onPressed: (){}, child: const Text("Continuer"),
          
          style: ElevatedButton.styleFrom(
            
            fixedSize:const Size(200, 20) ,
            // 
           side: ,
            shadowColor: Colors.black,
            backgroundColor:Colors.orange),
          ),
          
          
        ]
      ) ,)
      
      */