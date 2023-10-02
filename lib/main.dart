import 'dart:math';

import 'package:calendar_view/calendar_view.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/data/provider/login_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';

import 'package:rugst_alliance_academia/mobile_view/screens/splash_screen.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/web_view/screens/dashboard/home_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/login_view.dart';

import 'package:flutter/foundation.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_detail_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    ConfettiController controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));

    /// A custom Path to paint stars.
    Path drawStar(Size size) {
      // Method to convert degree to radians
      double degToRad(double deg) => deg * (pi / 180.0);

      const numberOfPoints = 5;
      final halfWidth = size.width / 2;
      final externalRadius = halfWidth;
      final internalRadius = halfWidth / 2.5;
      final degreesPerStep = degToRad(360 / numberOfPoints);
      final halfDegreesPerStep = degreesPerStep / 2;
      final path = Path();
      final fullAngle = degToRad(360);
      path.moveTo(size.width, halfWidth);

      for (double step = 0; step < fullAngle; step += degreesPerStep) {
        path.lineTo(halfWidth + externalRadius * cos(step),
            halfWidth + externalRadius * sin(step));
        path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
            halfWidth + internalRadius * sin(step + halfDegreesPerStep));
      }
      path.close();
      return path;
    }

    return kIsWeb
        ? ScreenUtilInit(
            designSize: const Size(1920, 1080),
            builder: (context, child) {
              controllerCenter.play();
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
                    ],
                    builder: (context, child) {
                      return MaterialApp(
                          debugShowCheckedModeBanner: false,
                          initialRoute: RouteNames.login,
                          routes: {
                            RouteNames.welcome: (context) =>
                                const SidebarPage(),
                            RouteNames.studentDetail: (context) =>
                                const StudentDetailView()
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
