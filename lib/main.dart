import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_agent_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_criminal_check_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_education_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_eng_proficieny_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_job_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_personal_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_recommendation_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_stand_test_provider.dart';

import 'package:rugst_alliance_academia/data/provider/common_provider.dart';
import 'package:rugst_alliance_academia/data/provider/dashboard_provider.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/data/provider/fees_provider.dart';
import 'package:rugst_alliance_academia/data/provider/file_upload_provider.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:rugst_alliance_academia/data/provider/login_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/result_provider.dart';
import 'package:rugst_alliance_academia/data/provider/staff_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/data/provider/study_history_provider.dart';
import 'package:rugst_alliance_academia/data/provider/timesheet_provider.dart';

import 'package:rugst_alliance_academia/mobile_view/screens/splash_screen.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';

import 'package:rugst_alliance_academia/web_view/screens/dashboard/vertical_tab_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/login_view.dart';

import 'package:flutter/foundation.dart';

import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(
    name: "dev",
    variables: {
      "flavorName": "dev",
      "baseUrl": "http://172.16.20.42:3015",
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return kIsWeb
        ? ScreenUtilInit(
            designSize: Size(size.width, size.height),
            builder: (context, child) {
              return CalendarControllerProvider(
                controller: EventController(),
                child: MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                        create: (context) => LoginProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => ProgramProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => FacultyProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => StudentProvider(),
                      ),
                      ChangeNotifierProxyProvider<StudentProvider,
                          ResultProvider>(
                        create: (context) => ResultProvider(
                            Provider.of<StudentProvider>(context,
                                listen: false)),
                        update: (context, value, previous) {
                          return ResultProvider(value);
                        },
                      ),
                      ChangeNotifierProvider(
                        create: (context) => FileUploadProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => TimeSheetProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => StaffProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => DashboardProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => FeesProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => CommonProvider(),
                      ),
                   
                      ChangeNotifierProvider(
                        create: (context) => StudyHistoryProvider(),
                      ),

                      ChangeNotifierProxyProvider<StudentProvider,
                          InvoiceProvider>(
                        create: (context) => InvoiceProvider(
                            Provider.of<StudentProvider>(context,
                                listen: false)),
                        update: (context, value, previous) {
                          return InvoiceProvider(value);
                        },
                      ),
                      
                        ChangeNotifierProvider(
                        create: (context) => AdmissionPersonalProvider(),
                      ),
                       ChangeNotifierProvider(
                        create: (context) => AdmissionAgentProvider(),
                      ),
                       ChangeNotifierProvider(
                        create: (context) => AdmissionEducationProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => AdmissionJobProvider(),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => AdmissionEngProficienyProvider(),
                      ),
                       ChangeNotifierProvider(
                        create: (context) => AdmissionProgramProvider(),
                      ),
                       ChangeNotifierProvider(
                        create: (context) => AdmissionStandTestProvider(),
                      ),
                       ChangeNotifierProvider(
                        create: (context) => AdmissionRecommendationProvider(),
                      ),
                       ChangeNotifierProvider(
                        create: (context) => AdmissionCriminalCheckProvider(),
                      ),
                    ],
                    builder: (context, child) {
                      return MaterialApp(
                          debugShowCheckedModeBanner: false,
                          initialRoute: RouteNames.login,
                          onGenerateRoute: (settings) {
                            if (settings.name == '/') {
                              return MaterialPageRoute(
                                  builder: (context) => const WebLoginView());
                            } else {
                              return MaterialPageRoute(
                                builder: (context) => const VerticalTabView(),
                              );
                            }
                          },
                          title: 'Academia',
                          theme: ThemeData(
                            primarySwatch: Colors.grey,
                          ),
                          home: const WebLoginView());
                    }),
              );
            })
        : ScreenUtilInit(
            designSize: const Size(428, 926),
            builder: (context, child) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primarySwatch: Colors.grey,
                  ),
                  home: const SplashScreen());
            });
  }
}
