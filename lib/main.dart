import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:my_amana_app/core/firebase/firebase_bootstrap.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: Scaffold(
        backgroundColor: Colors.transparent,
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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFF7A3D),
            Color(0xFFF26430),
            Color(0xFFE05225),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/logoProAmana.png"),
                width: 220,
                height: 220,
              ),
              SizedBox(height: 16),
              SpinKitDoubleBounce(
                color: Colors.white,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
    
  }
}


