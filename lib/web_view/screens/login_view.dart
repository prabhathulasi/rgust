
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
  var colorizeColors = [
    AppColors.colorc7e,
    AppColors.color582,
    AppColors.colorWhite,
    AppColors.colorRed,
  ];
  var colorizeTextStyle =
      GoogleFonts.londrinaSketch(fontSize: 35.sp, fontWeight: FontWeight.w600);
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
      backgroundColor: AppColors.colorWhite,
      appBar: AppBar(
        toolbarHeight: 150.h,
        leadingWidth: 80.h,
        backgroundColor: AppColors.colorWhite,
        leading:  Image.asset(ImagePath.rgustLogo,width: 60.w,),
        title: AppRichTextView(
            title: "Rgust Alliance academia",
            textColor: AppColors.colorc7e,
            fontSize: 35.sp,
            fontWeight: FontWeight.bold),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Row(
          children: [
            Container(
             
              height: size.height,
              width: size.width * 0.53,
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(30.sp)),
                border: Border.all(color: AppColors.colorc7e,width: 3.w)
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0.sp),
                child: Lottie.asset(LottiePath.overViewLottie,repeat: false)
              ),
            ),
            Expanded(
                child: Container(
                  height: size.height,
              margin: EdgeInsets.only(left: 40.w, right: 40.w, top: 10.h),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppRichTextView(
                          title: "Login",
                          textColor: AppColors.colorc7e,
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w400),
                      AnimatedTextKit(totalRepeatCount: 100, animatedTexts: [
                        ColorizeAnimatedText(
                          'Welcome to Our University Portal',
                          textStyle: colorizeTextStyle,
                          colors: colorizeColors,
                        ),
                      ]),
                      DefaultTextStyle(
                        style: GoogleFonts.oswald(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.colorPurple,
                        ),
                        child: AnimatedTextKit(
                          isRepeatingAnimation: false,
                          pause: const Duration(seconds: 10),
                          animatedTexts: [
                            TypewriterAnimatedText(
                                'Thank you for get back to Univeristy Management System,\nlets access your account'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.colorc7e,width: 3.w),
                            borderRadius: BorderRadius.circular(18.sp)),
                        child: AppTextFormFieldWidget(
                          textStyle: GoogleFonts.poppins(
                            color: AppColors.colorc7e,
                          ),
                          validator: (value) {
                            return EmailFormFieldValidator.validate(value!);
                          },
                          onSaved: (p0) => userName = p0,
                          obscureText: false,
                          inputDecoration: InputDecoration(
                              errorStyle: GoogleFonts.oswald(
                                  color: AppColors.colorRed,
                                  fontWeight: FontWeight.bold),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: "Enter Username",
                              hintStyle:
                                  GoogleFonts.poppins(color: AppColors.colorGrey),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0.h, horizontal: 10.0.w),
                              border: InputBorder.none),
                              onFieldSubmitted: (p0) {
                                 FocusScope.of(context).requestFocus(passwordFocus);
                              },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Consumer<LoginProvider>(
                        builder: (context, authProvider, child) {
                          return Container(
                            decoration: BoxDecoration(
                             border: Border.all(color: AppColors.colorc7e,width: 3.w),
                                borderRadius: BorderRadius.circular(18.sp)),
                            child: AppTextFormFieldWidget(
                              focusNode: passwordFocus,
                              textStyle: GoogleFonts.poppins(
                                color: AppColors.colorc7e,
                              ),
                              onSaved: (p0) => password = p0,
                              validator: (value) {
                                return PasswordFormFieldValidator.validate(value!);
                              },
                              obscureText: authProvider.passwordVisibility,
                              inputDecoration: InputDecoration(
                                suffixIcon:  InkWell(
                                  onTap: () {
                                    authProvider.setPasswordVisibility();
                                  },
                                  child:  Icon(authProvider.passwordVisibility == true? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppColors.colorc7e,)),
                                errorStyle: GoogleFonts.oswald(
                                    color: AppColors.colorRed,
                                    fontWeight: FontWeight.bold),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                hintText: "Enter Password",
                                hintStyle:
                                    GoogleFonts.poppins(color: AppColors.colorGrey),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0.h, horizontal: 10.0.w),
                                border: InputBorder.none,
                              ),
                              onFieldSubmitted: (p0) async{
                                if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                   var result = await authProvider.login(userName!, password!);
                                    var decodedData = json.decode(result.body);
                                    if (result.statusCode == 200) {
                                      _formKey.currentState!.reset();
                                      await prefs.setString(
                                          'Token', decodedData["token"]);
                                          
                                          await prefs.setString(
                                      "username", decodedData["userName"]);
                                      
                                      if (context.mounted) {
                                        Navigator.pushNamed(
                                            context, RouteNames.welcome);
                                        ToastHelper().sucessToast("Login Success");
                                      }
                                    } else {
                                      ToastHelper()
                                          .errorToast(decodedData["Message"]);
                                    }
                                  }
                              },
                            ),
                          );
                        }
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Center(
                        child: Consumer<LoginProvider>(
                            builder: (context, authProvider, child) {
                          return AppElevatedButon(
                            loading: authProvider.isLoading,
                            borderColor: AppColors.colorc7e,
                            title: "Login",
                            buttonColor: AppColors.colorWhite,
                            height: 50.h,
                            width: size.width * 0.15,
                            onPressed: (context) async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                               var result = await authProvider.login(userName!, password!);
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
                              }
                            },
                            textColor: AppColors.colorc7e,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
