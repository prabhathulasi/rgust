import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_login_provider.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/admission_form/admission_form_pages.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class AdmissionFormView extends StatefulWidget {
  const AdmissionFormView({super.key});

  @override
  State<AdmissionFormView> createState() => _AdmissionFormViewState();
}

class _AdmissionFormViewState extends State<AdmissionFormView> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: Consumer<AdmissionLoginProvider>(
            builder: (context, admissionLoginConsumer, child) {
          if (admissionLoginConsumer.changePage == false) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImagePath.webrgustLogo,
                            width: size.width * 0.08),
                        SizedBox(
                          width: 15.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppRichTextView(
                                title:
                                    "Rajiv Gandhi University of Science and Technology"
                                        .toUpperCase(),
                                fontSize: size.width * 0.02,
                                fontWeight: FontWeight.bold),
                            AppRichTextView(
                              fontStyle: FontStyle.italic,
                              title: "A Brand for Quality Eduation",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: AppRichTextView(
                          title: "application form".toUpperCase(),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppRichTextView(
                          textColor: AppColors.colorRed,
                          title:
                              "We encourage you to use our secure electronic application form and submit it through our website ",
                          fontSize: size.width * 0.013,
                          fontWeight: FontWeight.w500,
                        ),
                        AppRichTextView(
                          textDecoration: TextDecoration.underline,
                          textColor: AppColors.color4ff,
                          title: "www.rgust.edu.gy",
                          fontSize: size.width * 0.013,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppRichTextView(
                      maxLines: 4,
                      title:
                          "By using the electronic application form you will be able to save and change your application easily and as often as you like before submitting it.\nYou will also be able to save and print your application and be sure we have received it. You will be able to track the status of your application and\nsave generic information about yourself and your qualifications, which will save you time if you want to apply for more than one program. To submit\nyour online application, you will need to provide scanned copies of your qualifications.",
                      fontSize: size.width * 0.012,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    // Login Form
                    Center(
                      child: Card(
                        color: AppColors.colorWhite,
                        elevation: 10.0,
                        child: SizedBox(
                          width: size.width * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: AppRichTextView(
                                      textColor: AppColors.colorBlack,
                                      title:
                                          "Enter Email to Fill Application Form",
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  AppTextFormFieldWidget(
                                    textStyle: GoogleFonts.poppins(
                                      color: AppColors.colorc7e,
                                    ),
                                    validator: (value) {
                                      return EmailFormFieldValidator.validate(
                                          value!);
                                    },
                                    onSaved: (p0) =>
                                        admissionLoginConsumer.email = p0,
                                    obscureText: false,
                                    inputDecoration: InputDecoration(
                                      errorStyle: GoogleFonts.oswald(
                                          color: AppColors.colorRed,
                                          fontWeight: FontWeight.bold),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: "Enter Email",
                                      hintStyle: GoogleFonts.poppins(
                                          color: AppColors.colorGrey),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 20.0.h, horizontal: 10.0.w),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: AppColors.colorc7e,
                                            width: 3),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: AppColors.colorBlack,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Center(
                                    child: AppElevatedButon(
                                      loading: admissionLoginConsumer.isLoading,
                                      borderColor: AppColors.colorc7e,
                                      title: "Continue",
                                      buttonColor: AppColors.colorWhite,
                                      height: 50.h,
                                      width: size.width * 0.15,
                                      onPressed: (context) async {
                                        if (formKey.currentState!.validate()) {
                                          formKey.currentState!.save();
                                          var result =
                                              await admissionLoginConsumer
                                                  .postAdmissionLogin();

                                          if (result.statusCode == 200) {
                                            var decodedData =
                                                json.decode(result.body);
                                            log(decodedData.toString());
                                            admissionLoginConsumer
                                                .setApplicationStatus(
                                                    decodedData["Status"]
                                                        .toString(),
                                                    decodedData["ApplicationId"]
                                                        .toString());
                                            if (decodedData["Status"] == 10) {
                                              admissionLoginConsumer
                                                  .setPage(false);
                                              ToastHelper().errorToast(
                                                  "Application already submitted");
                                            } else {
                                              admissionLoginConsumer
                                                  .setPage(true);
                                            }
                                          }
                                        }
                                      },
                                      textColor: AppColors.colorc7e,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const AdmissionFormPages();
          }
        }));
  }
}
