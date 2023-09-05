import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rugst_alliance_academia/routes/app_router.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  bool butonloading = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Image.asset(
              ImagePath.logiLogo,
              height: 220.h,
              width: size.width,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: AppTextFormFieldWidget(
                textStyle: GoogleFonts.oswald(
                    color: AppColors.colorPurple, fontSize: 20.sp),
                inputDecoration: InputDecoration(
                    hintText: "Email Address",
                    hintStyle: GoogleFonts.oswald(
                        color: AppColors.colorGrey, fontSize: 20.sp)),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: AppTextFormFieldWidget(
                obscureText: true,
                textStyle: GoogleFonts.oswald(
                    color: AppColors.colorPurple, fontSize: 20.sp),
                inputDecoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: GoogleFonts.oswald(
                        color: AppColors.colorGrey, fontSize: 20.sp)),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            AppElevatedButon(
              title: "Login",
              height: 50.h,
              width: 200.w,
              textColor: AppColors.colorWhite,
              buttonColor: AppColors.colorPurple,
              loading: butonloading,
              onPressed: (context) {
                Navigator.of(context).push(AppRouter.mobileRequestData());
              },
            )
          ],
        ));
  }
}
