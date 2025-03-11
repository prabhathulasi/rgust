import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/login_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebLoginView extends StatefulWidget {
  const WebLoginView({super.key});

  @override
  State<WebLoginView> createState() => _WebLoginViewState();
}

class _WebLoginViewState extends State<WebLoginView> {
  String? userName;
  String? password;

  final _formKey = GlobalKey<FormState>();

  final FocusNode passwordFocus = FocusNode();
  @override
  void dispose() {
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Consumer<LoginProvider>(builder: (context, loginConsumer, child) {
        return Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagePath.webLoginLogo),
                  fit: BoxFit.cover)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              color: AppColors.colorWhite.withOpacity(0.5),
              width: size.width / 2,
              height: size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Image.asset(
                          ImagePath.rgustLogo,
                          width: 150.w,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        AppRichTextView(
                            title: "Rgust Management System",
                            textColor: AppColors.color446,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  loginConsumer.setIsStudent(false);
                                },
                                child: Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.sp),
                                          bottomLeft: Radius.circular(20.sp)),
                                      color: loginConsumer.isStudent == false
                                          ? AppColors.color446
                                          : AppColors.colorWhite,
                                    ),
                                    height: 50.h,
                                    child: Center(
                                      child: AppRichTextView(
                                          title: "Admin Login",
                                          textColor:
                                              loginConsumer.isStudent == false
                                                  ? AppColors.colorWhite
                                                  : AppColors.color446,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                loginConsumer.setIsStudent(true);
                              },
                              child: Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20.sp),
                                        topRight: Radius.circular(20.sp)),
                                    color: loginConsumer.isStudent == true
                                        ? AppColors.color446
                                        : AppColors.colorWhite,
                                  ),
                                  height: 50.h,
                                  child: Center(
                                    child: AppRichTextView(
                                        title: "Student Login",
                                        textColor:
                                            loginConsumer.isStudent == true
                                                ? AppColors.colorWhite
                                                : AppColors.color446,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
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
                          onFieldSubmitted: (p0) {
                            FocusScope.of(context).requestFocus(passwordFocus);
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AppTextFormFieldWidget(
                          focusNode: passwordFocus,
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
                        SizedBox(
                          height: 20.h,
                        ),
                        loginConsumer.isStudent == true
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: AppRichTextView(
                                                title: "Reset Password",
                                                textColor: AppColors.color446,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold),
                                            content:
                                                Builder(builder: (context) {
                                              return SizedBox(
                                                height: 300.h,
                                                width: 300.w,
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
                            hintText: "Enter Email",
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
                          onFieldSubmitted: (p0) {
                            FocusScope.of(context).requestFocus(passwordFocus);
                          },
                        ),

                                                  ],
                                                ),
                                              );
                                            }),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: const Text("Generate OTP"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: AppRichTextView(
                                          title: "Forget Password ?",
                                          textColor: AppColors.color446,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                        AppElevatedButon(
                          loading: loginConsumer.isLoading,
                          borderColor: AppColors.color446,
                          title: "Login",
                          buttonColor: AppColors.colorWhite,
                          height: 50.h,
                          width: size.width * 0.15,
                          onPressed: (context) async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              if (loginConsumer.isStudent == false) {
                                var result = await loginConsumer.login(
                                    userName!, password!);
                                var decodedData = json.decode(result.body);
                                if (result.statusCode == 200) {
                                  await prefs.setString(
                                      'Token', decodedData["token"]);
                                  await prefs.setString(
                                      "username", decodedData["userName"]);
                                  // await prefs.setInt("userId", decodedData["user"]);
                                  if (context.mounted) {
                                    Navigator.pushNamed(
                                        context, RouteNames.welcome);
                                    ToastHelper().sucessToast("Login Success");
                                  }
                                } else {
                                  ToastHelper()
                                      .errorToast(decodedData["Message"]);
                                }
                              } else {
                                var result = await loginConsumer.studentLogin(
                                    userName!, password!);
                                var decodedData = json.decode(result.body);
                              
                                if (result.statusCode == 200) {
                                  await prefs.setString(
                                      'Token', decodedData["token"]);
                                  await prefs.setString(
                                      "username", decodedData["userName"]);
                                  await prefs.setInt(
                                      "userId", decodedData["user"]);
                                  if (context.mounted) {
                                    Navigator.pushNamed(
                                        context, RouteNames.studentDetail);
                                    ToastHelper().sucessToast("Login Success");
                                  }
                                } else {
                                  ToastHelper()
                                      .errorToast(decodedData["Message"]);
                                }
                              }
                            }
                          },
                          textColor: AppColors.color446,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
