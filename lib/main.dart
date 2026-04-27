import 'package:eagle_badger/config/routes.dart'; // Import your new file
import 'package:eagle_badger/theme/app_theme.dart';
import 'package:eagle_badger/screens/auth/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eagle Badger',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme(context),
      home: const SplashScreen(),
      routes: AppRoutes.routes,
    );
  }
}
