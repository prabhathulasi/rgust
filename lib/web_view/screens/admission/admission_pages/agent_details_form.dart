import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_agent_provider.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgentDetailsForm extends StatelessWidget {
  final PageController pageController;
  const AgentDetailsForm({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<AdmissionAgentProvider>(
        builder: (context, admissionAgentConsumer, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppRichTextView(
                    title: "Agent Details",
                    textColor: AppColors.colorc7e,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
                SizedBox(
                  width: size.width * 0.2,
                  child: LinearProgressIndicator(
                    backgroundColor: AppColors.colorGrey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.sp),
                    color: AppColors.colorc7e,
                    minHeight: 15.sp,
                    value: 0.2,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: AppRichTextView(
                      title:
                          "Are you applying through an RGUST-authorized agent?",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Radio(
                  activeColor: AppColors.colorc7e,
                  value: "Yes",
                  groupValue: admissionAgentConsumer.agentRadioValue,
                  onChanged: (String? value) {
                    admissionAgentConsumer.setAgentRadioValue(value!);
                  },
                ),
                AppRichTextView(
                    title: "Yes", fontSize: 12.sp, fontWeight: FontWeight.bold),
                Radio(
                  activeColor: AppColors.colorc7e,
                  value: "No",
                  groupValue: admissionAgentConsumer.agentRadioValue,
                  onChanged: (String? value) {
                    admissionAgentConsumer.setAgentRadioValue(value!);
                    admissionAgentConsumer.setAgentSectionValue(true);
                  },
                ),
                AppRichTextView(
                    title: "No", fontSize: 12.sp, fontWeight: FontWeight.bold),
              ],
            ),
            SizedBox(
              height: 15.sp,
            ),
            admissionAgentConsumer.agentRadioValue == "Yes"
                ? IntrinsicHeight(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppRichTextView(
                                      title: "Agent Name",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  AppTextFormFieldWidget(
                                    obscureText: false,
                                    inputDecoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.colorc7e,
                                                width: 2.w)),
                                        prefixIcon:
                                            const Icon(Icons.person_outline),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppRichTextView(
                                      title: "Branch Name",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  AppTextFormFieldWidget(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppRichTextView(
                                      title: "Counselor Name",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  AppTextFormFieldWidget(
                                    obscureText: false,
                                    inputDecoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.colorc7e,
                                                width: 2.w)),
                                        prefixIcon:
                                            const Icon(Icons.person_outline),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppRichTextView(
                                      title: "Phone Number",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  AppTextFormFieldWidget(
                                    obscureText: false,
                                    inputDecoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.colorc7e,
                                                width: 2.w)),
                                        prefixIcon:
                                            const Icon(Icons.phone_outlined),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppRichTextView(
                                      title: "Email Address",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  AppTextFormFieldWidget(
                                    obscureText: false,
                                    inputDecoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.colorc7e,
                                                width: 2.w)),
                                        prefixIcon:
                                            const Icon(Icons.email_outlined),
                                        hintText: "Enter Email Address",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppRichTextView(
                                      title: "Fax Number",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  AppTextFormFieldWidget(
                                    obscureText: false,
                                    inputDecoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.colorc7e,
                                                width: 2.w)),
                                        prefixIcon:
                                            const Icon(Icons.fax_outlined),
                                        hintText: "Enter Fax Number",
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
                      ],
                    ),
                  )
                : Container(),
             
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppElevatedButon(
                  borderColor: AppColors.colorc7e,
                  title: "Back",
                  buttonColor: AppColors.colorWhite,
                  onPressed: (context) {
                    admissionAgentConsumer.setAgentSectionValue(true);
                    pageController.previousPage(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeOut);
                  },
                  textColor: AppColors.colorc7e,
                  height: 50.h,
                  width: 120.w,
                ),
                AppElevatedButon(
                  title: "Save & Continue",
                  buttonColor: AppColors.colorc7e,
                  onPressed: (context) {
                    admissionAgentConsumer.setAgentSectionValue(true);
                    pageController.nextPage(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeIn);
                  },
                  textColor: AppColors.colorWhite,
                  height: 50.h,
                  width: 200.w,
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
