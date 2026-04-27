import 'package:flutter/material.dart';

import 'package:eagle_badger/screens/finalize/day_summary.dart';
import 'package:eagle_badger/screens/finalize/queue.dart';
import 'package:eagle_badger/screens/finalize/rewards_badges.dart';
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
import 'package:eagle_badger/screens/auth/language_selection_screen.dart';

class AppRoutes {
  // Define route constants to avoid typos in your screens later
  static const String language = '/language';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String permission = '/permission';
  static const String fieldWork = '/fieldWork';
  static const String dashboard = '/dashboard';
  static const String fieldSurvey = '/fieldSurvey';
  static const String dailyRoute = '/dailyRoute';
  static const String localPulse = '/localPulse';
  static const String voterProfiling = '/voterProfiling';
  static const String posterReport = '/posterReport';
  static const String fieldReport = '/fieldReport';
  static const String activityFlow = '/activityFlow';
  static const String socioCulture = '/socioCulture';
  static const String blocDetails = '/blocDetails';
  static const String engagementMemo = '/engagementMemo';
  static const String reviewCheckIn = '/reviewCheckIn';
  static const String reportIncident = '/reportIncident';
  static const String evidenceCapture = '/evidenceCapture';
  static const String resultSheet = '/resultSheet';
  static const String resultVerification = '/resultVerification';
  static const String queue = '/queue';
  static const String daySummary = '/daySummary';
  static const String rewards = '/rewards';

  // The Map that goes into MaterialApp
  static Map<String, WidgetBuilder> get routes => {
    language: (context) => const LanguageSelectionScreen(),
    login: (context) => const LoginScreen(),
    otp: (context) => const OtpVerificationScreen(),
    permission: (context) => const PermissionScreen(),
    fieldWork: (context) => const FieldWorkMenuScreen(),
    dashboard: (context) => const DashboardScreen(),
    fieldSurvey: (context) => const FieldSurveyScreen(),
    dailyRoute: (context) => const AiDailyRouteScreen(),
    localPulse: (context) => const LocalPulseScreen(),
    voterProfiling: (context) => const VoterProfilingScreen(),
    posterReport: (context) => const PosterReportScreen(),
    fieldReport: (context) => const FieldReportScreen(),
    activityFlow: (context) => const ActivityFlowScreen(),
    socioCulture: (context) => const SocioCulturalBlocsScreen(),
    blocDetails: (context) => const BlocDetailsScreen(),
    engagementMemo: (context) => const EngagementMemoScreen(),
    reviewCheckIn: (context) => const ReviewCheckInScreen(),
    reportIncident: (context) => const ReportIncidentScreen(),
    evidenceCapture: (context) => const EvidenceCaptureScreen(),
    resultSheet: (context) => const ResultSheetUploadScreen(),
    resultVerification: (context) => const ResultVerificationScreen(),
    queue: (context) => const QueueScreen(),
    daySummary: (context) => const DaySummaryScreen(),
    rewards: (context) => const RewardsBadgesScreen(),
  };
}
