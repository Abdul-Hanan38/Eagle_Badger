import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialization();
  }

  void _initialization() async {
    FlutterNativeSplash.remove();
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/language');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            // Logo
            Image.asset('assets/images/eagle.png', width: 150),
            const SizedBox(height: 20),
            // App Name
            const Text(
              'Eagle Badger',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Subtitle
            const Text(
              'Real-Time Political\nIntelligence',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const Spacer(flex: 2),
            // Loading Bar and Text
            const Text(
              'Initializing System',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                backgroundColor: Colors.white10,
                color: Colors.white,
                minHeight: 2,
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
