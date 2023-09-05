import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/login_screen.dart';
import 'package:rugst_alliance_academia/util/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Image.asset(
              ImagePath.logiLogo,
              height: 30.h,
              width: size.width,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0.sp),
              child: const TabBar(
                tabs: [
                  Tab(text: "Faculty"),
                  Tab(text: "Student"),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            const Expanded(
                child: TabBarView(
              children: [MobileLoginScreen(), MobileLoginScreen()],
            ))
          ],
        ),
      ),
    );
  }
}
