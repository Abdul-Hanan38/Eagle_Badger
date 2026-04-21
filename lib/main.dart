import 'package:eagle_badger/screens/finalize/queue.dart';
import 'package:eagle_badger/screens/report/evidence_capture.dart';
import 'package:eagle_badger/screens/report/report_incident.dart';
import 'package:eagle_badger/screens/report/result_sheet.dart';
import 'package:eagle_badger/screens/report/result_verification.dart';
import 'package:eagle_badger/screens/report/review_checkin.dart';
import 'package:eagle_badger/screens/tally/activity_flow.dart';
import 'package:eagle_badger/screens/contact/bloc_details.dart';
import 'package:eagle_badger/screens/canvassing/daily_route.dart';
import 'package:eagle_badger/screens/canvassing/dashboard.dart';
import 'package:eagle_badger/screens/contact/engagement_memo.dart';
import 'package:eagle_badger/screens/survey/field_report_screen.dart';
import 'package:eagle_badger/screens/survey/poster_report_screen.dart';
import 'package:eagle_badger/screens/fieldWork/field_work_menu.dart';
import 'package:eagle_badger/screens/fieldSruveys/field_survey.dart';
import 'package:eagle_badger/screens/canvassing/local_pulse.dart';
import 'package:eagle_badger/screens/auth/login_screen.dart';
import 'package:eagle_badger/screens/auth/otp_verification_screen.dart';
import 'package:eagle_badger/screens/auth/permission_screen.dart';
import 'package:eagle_badger/screens/contact/socio_culture_blocs.dart';
import 'package:eagle_badger/screens/fieldSruveys/voter_profiling_screen.dart';
import 'package:eagle_badger/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:eagle_badger/screens/auth/splash_screen.dart';
import 'package:eagle_badger/screens/auth/language_selection_screen.dart';

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
        '/login': (context) => const LoginScreen(),
        '/otp': (context) => const OtpVerificationScreen(),
        '/permission': (context) => const PermissionScreen(),
        '/fieldWork': (context) => const FieldWorkMenuScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/fieldSurvey': (context) => const FieldSurveyScreen(),
        '/dailyRoute': (context) => const AiDailyRouteScreen(),
        '/localPulse': (context) => const LocalPulseScreen(),
        '/voterProfiling': (context) => const VoterProfilingScreen(),
        '/posterReport': (context) => const PosterReportScreen(),
        '/fieldReport': (context) => const FieldReportScreen(),
        '/activityFlow': (context) => const ActivityFlowScreen(),
        '/socioCulture': (context) => const SocioCulturalBlocsScreen(),
        '/blocDetails': (context) => const BlocDetailsScreen(),
        '/engagementMemo': (context) => const EngagementMemoScreen(),
        '/reviewCheckIn': (context) => const ReviewCheckInScreen(),
        '/reportIncident': (context) => const ReportIncidentScreen(),
        '/evidenceCapture': (context) => const EvidenceCaptureScreen(),
        '/resultSheet': (context) => const ResultSheetUploadScreen(),
        '/resultVerification': (context) => const ResultVerificationScreen(),
        '/queue': (context) => const QueueScreen(),
      },
    );
  }
}
