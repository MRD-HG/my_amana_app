import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:my_amana_app/View/Facteure/facteur.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
  
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
     body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              // User is already logged in
              return const Facteur();
            } else {
              // User is not logged in
              return const LoginFact();
            }
          }
        },
      ),
    );
  }
}


class LoginFact extends StatefulWidget {
  const LoginFact({super.key});

  @override
  State<LoginFact> createState() => _LoginFactState();
}

class _LoginFactState extends State<LoginFact> {
 //code init login
 
 
 
 
 //pour login
  static Future<User?> login({required String email ,required String password ,required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user ;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;

    } on FirebaseException catch(e){
      if(e.code=="user-not-found"){
        print('Aucun Utilisateur Avec Ce Email');
      }
    }
      
  return user;
  }

  
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController=TextEditingController();
    TextEditingController passwordController=TextEditingController();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Image.asset('images/iconAmana.jpg',)),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: "Votre Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                        prefixIcon: Icon(Icons.email_rounded,color: Colors.orange),

                    focusColor: Colors.black),
                onChanged: (value) {
                },
              ),
              const SizedBox(height: 25),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: "Votre Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                        prefixIcon: Icon(Icons.lock
                        ,color: Colors.orange),
                    focusColor: Colors.black),
                onChanged: (value) {
                },
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () 
                  async{
                        User? user = await login(email: emailController.text, password: passwordController.text, context: context);
                        print(user);
                        if(user != null){
                            Route route = MaterialPageRoute(
                        builder: ((context) => const Facteur()));

                                Navigator.pushReplacement(context, route);
                        }
                  },
                
                style: ElevatedButton.styleFrom(
                    fixedSize: Size((MediaQuery.of(context).size.width) * 0.3,
                        (MediaQuery.of(context).size.height) * 0.06)),
                child: const Text("Log In"),
              )
            ],
          )),
    );
  }
}
