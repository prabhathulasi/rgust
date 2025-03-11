
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/login_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {


  String? userName;
  String? password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Consumer<LoginProvider>(builder: (context, loginConsumer, child) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: size.height * 0.3,
                  width: size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagePath.webLoginLogo),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      ImagePath.rgustLogo,
                      width: 200.w,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppRichTextView(
                    title: "Rgust Student Login",
                    textColor: AppColors.color446,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    children: [
                      AppTextFormFieldWidget(
                        textStyle: GoogleFonts.poppins(
                          color: AppColors.color446,
                        ),
                        validator: (value) {
                          return EmailFormFieldValidator.validate(value!);
                        },
                        onSaved: (p0) => userName = p0,
                        obscureText: false,
                        inputDecoration: InputDecoration(
                          fillColor: AppColors.colorWhite,
                          filled: true,
                          errorStyle: GoogleFonts.oswald(
                              color: AppColors.colorRed,
                              fontWeight: FontWeight.bold),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "Enter Username",
                          hintStyle:
                              GoogleFonts.poppins(color: AppColors.colorGrey),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0.h, horizontal: 10.0.w),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.color446, width: 3.w),
                              borderRadius: BorderRadius.circular(18.sp)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.color446, width: 2.w),
                              borderRadius: BorderRadius.circular(18.sp)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.color446, width: 3.w),
                              borderRadius: BorderRadius.circular(18.sp)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.colorRed, width: 3.w),
                              borderRadius: BorderRadius.circular(18.sp)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.colorRed, width: 3.w),
                              borderRadius: BorderRadius.circular(18.sp)),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextFormFieldWidget(
                        textStyle: GoogleFonts.poppins(
                          color: AppColors.color446,
                        ),
                        onSaved: (p0) => password = p0,
                        validator: (value) {
                          return PasswordFormFieldValidator.validate(value!);
                        },
                        obscureText: loginConsumer.passwordVisibility,
                        inputDecoration: InputDecoration(
                          fillColor: AppColors.colorWhite,
                          filled: true,
                          suffixIcon: InkWell(
                              onTap: () {
                                loginConsumer.setPasswordVisibility();
                              },
                              child: Icon(
                                loginConsumer.passwordVisibility == true
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.color446,
                              )),
                          errorStyle: GoogleFonts.oswald(
                              color: AppColors.colorRed,
                              fontWeight: FontWeight.bold),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "Enter Password",
                          hintStyle:
                              GoogleFonts.poppins(color: AppColors.colorGrey),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0.h, horizontal: 10.0.w),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.color446, width: 3.w),
                              borderRadius: BorderRadius.circular(18.sp)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.color446, width: 2.w),
                              borderRadius: BorderRadius.circular(18.sp)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.color446, width: 3.w),
                              borderRadius: BorderRadius.circular(18.sp)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.colorRed, width: 3.w),
                              borderRadius: BorderRadius.circular(18.sp)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.colorRed, width: 3.w),
                              borderRadius: BorderRadius.circular(18.sp)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppElevatedButon(
                  loading: loginConsumer.isLoading,
                  borderColor: AppColors.color446,
                  title: "Login",
                  buttonColor: AppColors.colorWhite,
                  height: 50.h,
                  width: 150.w,
                  onPressed: (context) async {
                     
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var result =
                          await loginConsumer.studentLogin(userName!, password!);
                      var decodedData = json.decode(result.body);
                      if (result.statusCode == 200) {
                        await prefs.setString('Token', decodedData["token"]);
                        await prefs.setString(
                            "username", decodedData["userName"]);
                        await prefs.setInt("userId", decodedData["user"]);
                        if (context.mounted) {
                          Navigator.pushNamed(context, RouteNames.studentDetail);
                          ToastHelper().sucessToast("Login Success");
                        }
                      } else {
                        ToastHelper().errorToast(decodedData["Message"]);
                      }
                    }
                  },
                  textColor: AppColors.color446,
                )
              ],
            ),
          );
        }));
  }
}
