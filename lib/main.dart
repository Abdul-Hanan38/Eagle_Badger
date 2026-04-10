import 'package:eagle_badger/screens/canvassing.dart';
import 'package:eagle_badger/screens/contact.dart';
import 'package:eagle_badger/screens/field_surveys.dart';
import 'package:eagle_badger/screens/field_work_menu.dart';
import 'package:eagle_badger/screens/finalize.dart';
import 'package:eagle_badger/screens/help_screen.dart';
import 'package:eagle_badger/screens/login_screen.dart';
import 'package:eagle_badger/screens/otp_verification_screen.dart';
import 'package:eagle_badger/screens/permission_screen.dart';
import 'package:eagle_badger/screens/report.dart';
import 'package:eagle_badger/screens/survey.dart';
import 'package:eagle_badger/screens/tally.dart';
import 'package:eagle_badger/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:eagle_badger/screens/splash_screen.dart';
import 'package:eagle_badger/screens/language_selection_screen.dart';

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

      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
      routes: {
        '/language': (context) => const LanguageSelectionScreen(),
        '/help': (context) => const Help(),
        '/login': (context) => const LoginScreen(),
        '/otp': (context) => const OtpVerificationScreen(),
        '/permission': (context) => const PermissionScreen(),
        '/fieldWork': (context) => const FieldWorkMenuScreen(),
        '/canvassing': (context) => const Canvassing(),
        '/fieldSurvey': (context) => const FieldSurveyScreen(),
        '/survey': (context) => const SurveyScreen(),
        '/contact': (context) => const ContactScreen(),
        '/report': (context) => const ReportScreen(),
        '/tally': (context) => const TallyScreen(),
        '/finalize': (context) => const FinalizeScreen(),
      },
    );
  }
}
