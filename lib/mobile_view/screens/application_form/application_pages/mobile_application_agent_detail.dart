import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_agent_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_login_provider.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MobileApplicationAgentDetail extends StatelessWidget {
  final PageController pageController;
  const MobileApplicationAgentDetail({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var size = MediaQuery.sizeOf(context);
    return Consumer<AdmissionAgentProvider>(
        builder: (context, admissionAgentConsumer, child) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImagePath.webrgustLogo, width: 80.w),
                  SizedBox(
                    width: 15.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                          title:
                              "Rajiv Gandhi University of Science and Technology",
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold),
                      AppRichTextView(
                        textColor: AppColors.colorRed,
                        title: "A Brand for Quality Eduation",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppRichTextView(
                      title: "Agent Details",
                      textColor: AppColors.colorc7e,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                  const Spacer(),
                  SizedBox(
                    width: size.width / 4,
                    child: LinearProgressIndicator(
                      backgroundColor: AppColors.colorGrey,
                      borderRadius: BorderRadius.circular(20.sp),
                      color: AppColors.colorc7e,
                      minHeight: 15.sp,
                      value: 0.3,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
          
                    child: AppRichTextView(
                        title:
                            "Are you applying through an RGUST-authorized agent?",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  AppRichTextView(
                      textColor: AppColors.colorRed,
                      title: "*",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Radio(
                    activeColor: AppColors.colorc7e,
                    value: "Yes",
                    groupValue: admissionAgentConsumer.agentRadioValue,
                    onChanged: (String? value) {
                      admissionAgentConsumer.setAgentRadioValue(value!);
                    },
                  ),
                  AppRichTextView(
                      title: "Yes",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold),
                  Radio(
                    activeColor: AppColors.colorc7e,
                    value: "No",
                    groupValue: admissionAgentConsumer.agentRadioValue,
                    onChanged: (String? value) {
                      admissionAgentConsumer.setAgentRadioValue(value!);
                    },
                  ),
                  AppRichTextView(
                      title: "No",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold),
                ],
              ),
              SizedBox(
                height: 15.sp,
              ),
              admissionAgentConsumer.agentRadioValue == "Yes"
                  ? IntrinsicHeight(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Agent Name",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      AppTextFormFieldWidget(
                                        onSaved: (p0) => admissionAgentConsumer
                                            .agentName = p0,
                                        validator: (p0) => p0!.isEmpty
                                            ? "Agent Name is required"
                                            : null,
                                        obscureText: false,
                                        inputDecoration: InputDecoration(
                                            border: const OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors.colorc7e,
                                                    width: 2.w)),
                                            prefixIcon: const Icon(
                                                Icons.person_outline),
                                            hintText: "Enter Agent Name",
                                            hintStyle: GoogleFonts.roboto(
                                                fontSize: 12.sp,
                                                color: AppColors.colorGrey)),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Branch Name",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      AppTextFormFieldWidget(
                                        onSaved: (p0) => admissionAgentConsumer
                                            .agentAddress = p0,
                                        validator: (p0) => p0!.isEmpty
                                            ? "Branch Name is required"
                                            : null,
                                        obscureText: false,
                                        inputDecoration: InputDecoration(
                                            border: const OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors.colorc7e,
                                                    width: 2.w)),
                                            prefixIcon:
                                                const Icon(Icons.outlined_flag),
                                            hintText: "Enter Branch Name",
                                            hintStyle: GoogleFonts.roboto(
                                                fontSize: 12.sp,
                                                color: AppColors.colorGrey)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Counselor Name",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      AppTextFormFieldWidget(
                                        onSaved: (p0) => admissionAgentConsumer
                                            .counselorName = p0,
                                        validator: (p0) => p0!.isEmpty
                                            ? "Counselor Name is required"
                                            : null,
                                        obscureText: false,
                                        inputDecoration: InputDecoration(
                                            border: const OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors.colorc7e,
                                                    width: 2.w)),
                                            prefixIcon: const Icon(
                                                Icons.person_outline),
                                            hintText: "Enter Counselor Name",
                                            hintStyle: GoogleFonts.roboto(
                                                fontSize: 12.sp,
                                                color: AppColors.colorGrey)),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Phone Number",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      AppTextFormFieldWidget(
                                        onSaved: (p0) => admissionAgentConsumer
                                            .agentContact = p0,
                                        validator: (p0) =>
                                            MobileNumberValidator.validate(p0),
                                        obscureText: false,
                                        inputDecoration: InputDecoration(
                                            border: const OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors.colorc7e,
                                                    width: 2.w)),
                                            prefixIcon: const Icon(
                                                Icons.phone_outlined),
                                            hintText: "Enter Phone Number",
                                            hintStyle: GoogleFonts.roboto(
                                                fontSize: 12.sp,
                                                color: AppColors.colorGrey)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Email Address",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      AppTextFormFieldWidget(
                                        onSaved: (p0) => admissionAgentConsumer
                                            .agentEmail = p0,
                                        validator: (p0) =>
                                            EmailFormFieldValidator.validate(
                                                p0),
                                        obscureText: false,
                                        inputDecoration: InputDecoration(
                                            border: const OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors.colorc7e,
                                                    width: 2.w)),
                                            prefixIcon: const Icon(
                                                Icons.email_outlined),
                                            hintText: "Enter Email Address",
                                            hintStyle: GoogleFonts.roboto(
                                                fontSize: 12.sp,
                                                color: AppColors.colorGrey)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 10.h,
              ),
              admissionAgentConsumer.agentRadioValue == null
                  ? Container()
                  : Center(
                    child: Consumer<AdmissionLoginProvider>(
                        builder: (context, admissionLoginConsumer, child) {
                      return AppElevatedButon(
                        title: "Save & Continue",
                        loading: admissionAgentConsumer.isLoading,
                        buttonColor: AppColors.colorc7e,
                        onPressed: (context) async {
                          var applicationId =
                              admissionLoginConsumer.applicationId;
                          if (admissionAgentConsumer.agentRadioValue ==
                              "Yes") {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              var response = await admissionAgentConsumer
                                  .postAdmissionAgentDetails(
                                      int.parse(applicationId!));
                              if (response.statusCode == 201) {
                                pageController.nextPage(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.easeIn);
                              } else {
                                ToastHelper()
                                    .errorToast(response.body.toString());
                              }
                            }
                          } else {
                            var response = await admissionAgentConsumer
                                .postAdmissionAgentDetails(
                                    int.parse(applicationId!));
                            if (response.statusCode == 201) {
                              pageController.nextPage(
                                  duration:
                                      const Duration(milliseconds: 1000),
                                  curve: Curves.easeIn);
                            } else {
                              ToastHelper()
                                  .errorToast(response.body.toString());
                            }
                          }
                        },
                        textColor: AppColors.colorWhite,
                        height: 50.h,
                        width: 200.w,
                      );
                    }),
                  )
            ],
          ),
        ),
      );
    });
  }
}
