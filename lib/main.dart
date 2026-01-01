import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:my_amana_app/core/firebase/firebase_bootstrap.dart';

import 'View/pagesSplish/simulator.dart';

const int  counter = 0 ;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseBootstrap.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.orange,
        body:mainApp()
       
        
        ),
    );
  }
}

class mainApp extends StatefulWidget{
  
  const mainApp({super.key});

  @override
  State<mainApp> createState() => _mainAppState();
}

class _mainAppState extends State<mainApp> {
  @override

    void initState() {
      super.initState();
      navigateToMain();
  }
 Route  route =  MaterialPageRoute(builder:  ((context) => const Choisir() ));
  void navigateToMain() {
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) {
        return;
      }
      Navigator.pushReplacement(context, route);
    });
  }

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      backgroundColor: Colors.orange,
    /*   decoration: const BoxDecoration(
        shape:BoxShape.circle,
        
        color: Colors.amber,
      
        
      ), */
      
      body: SizedBox(
        
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
                  
                Image(image: AssetImage("assets/images/logoProAmana.png")
                ,width: 250,height:500,),
                SpinKitDoubleBounce(
                        color: Colors.white,
                        size: 50.0,

                  ),
                        
                    ],
                  ),
      ),
      
       

        
    
      
       
       
              
              
        
     
      
    );
    
  }
}


