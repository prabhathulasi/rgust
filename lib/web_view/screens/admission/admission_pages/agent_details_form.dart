import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgentDetailsForm extends StatelessWidget {
  const AgentDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdmissionProvider>(
        builder: (context, admissionConsumer, child) {
      return Column(
        children: [
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
                groupValue: admissionConsumer.agentRadioValue,
                onChanged: (String? value) {
                  admissionConsumer.setAgentRadioValue(value!);
                },
              ),
              AppRichTextView(
                  title: "Yes", fontSize: 12.sp, fontWeight: FontWeight.bold),
              Radio(
                activeColor: AppColors.colorc7e,
                value: "No",
                groupValue: admissionConsumer.agentRadioValue,
                onChanged: (String? value) {
                  admissionConsumer.setAgentRadioValue(value!);
                  admissionConsumer.setAgentSectionValue(true);
                },
              ),
              AppRichTextView(
                  title: "No", fontSize: 12.sp, fontWeight: FontWeight.bold),
            ],
          ),
          SizedBox(
            height: 15.sp,
          ),
          admissionConsumer.agentRadioValue == "Yes"
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
                      Align(
                        alignment: Alignment.bottomRight,
                        child: AppElevatedButon(
                          title: "Save & Continue",
                          buttonColor: AppColors.colorc7e,
                          onPressed: (context) {
                            admissionConsumer.setAgentSectionValue(true);
                          },
                          textColor: AppColors.colorWhite,
                          height: 50.h,
                          width: 200.w,
                        ),
                      )
                    ],
                  ),
                )
              : Container()
        ],
      );
    });
  }
}
