import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_amana_app/core/bootstrap/app_repositories.dart';
import 'package:my_amana_app/core/config/app_config.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';

import 'View/Menu/MenuSide.dart';
import 'View/pagesSplish/simulator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppRepositories.configure();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Amana',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    // Short branding delay (was a fixed 5 s) while reading the onboarding flag.
    final results = await Future.wait([
      SharedPreferences.getInstance(),
      Future<void>.delayed(const Duration(milliseconds: 1800)),
    ]);
    if (!mounted) return;

    final prefs = results.first as SharedPreferences;
    final onboardingDone = prefs.getBool(kOnboardingDoneKey) ?? false;

    // Returning users skip the space chooser + onboarding and land on the
    // client home directly. The Facteur space stays reachable from the drawer.
    final Widget next = onboardingDone ? const AppShell() : const Choisir();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => next),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  image: AssetImage('assets/images/logoProAmana.png'),
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
      ),
    );
  }
}
