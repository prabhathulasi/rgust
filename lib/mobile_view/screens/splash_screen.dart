import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/routes/app_router.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loadLoginPage();
    super.initState();
  }

  loadLoginPage() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(AppRouter.mobileLogin());
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.colorBlack,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(ImagePath.splashLogo),
        )),
      ),
    );
  }
}
