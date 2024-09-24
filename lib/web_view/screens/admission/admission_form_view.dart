import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_pages/agent_details_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_pages/education_details_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_pages/eng_proficiency_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_pages/job_details_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_pages/personal_detail_form.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class AdmissionFormView extends StatefulWidget {
  const AdmissionFormView({super.key});

  @override
  State<AdmissionFormView> createState() => _AdmissionFormViewState();
}

final _pageController = PageController(
  initialPage: 2,
  viewportFraction: 0.8,
);

class _AdmissionFormViewState extends State<AdmissionFormView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Consumer<AdmissionProvider>(
          builder: (context, admissionConsumer, child) {
        return Padding(
          padding: EdgeInsets.all(28.0.sp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.07,
                    ),
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
                admissionConsumer.isPersonalCompleted == false
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppRichTextView(
                              title: "Personal Details",
                              textColor: AppColors.colorc7e,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            width: size.width * 0.2,
                            child: LinearProgressIndicator(
                              backgroundColor:
                                  AppColors.colorGrey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.sp),
                              color: AppColors.colorc7e,
                              minHeight: 15.sp,
                              value: 0.1,
                            ),
                          )
                        ],
                      )
                    : InkWell(
                        onTap: () {
                          admissionConsumer.setPersonalSectionValue(false);
                        },
                        child: Card(
                          color: AppColors.colorWhite,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                AppRichTextView(
                                    title: "Personal Details",
                                    textColor: AppColors.colorc7e,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                                const Spacer(),
                                AppRichTextView(
                                  title: "Saved",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  textColor: AppColors.color582,
                                ),
                                const Icon(
                                  Icons.check_circle_outline_outlined,
                                  color: AppColors.color582,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  size: 30.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                admissionConsumer.isPersonalCompleted == false
                    ? SizedBox(
                        height: 20.h,
                      )
                    : Container(),
                admissionConsumer.isPersonalCompleted == false
                    ? const PersonalDetailForm()
                    : Container(),
                SizedBox(
                  height: 20.h,
                ),
                admissionConsumer.isPersonalCompleted == false
                    ? Container()
                    : IntrinsicHeight(
                        child: Column(
                          children: [
                            admissionConsumer.isAgentCompleted == true
                                ? InkWell(
                                    onTap: () {
                                      admissionConsumer
                                          .setAgentSectionValue(false);
                                      admissionConsumer.setAgentRadioValue("");
                                    },
                                    child: Card(
                                      color: AppColors.colorWhite,
                                      elevation: 5.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            AppRichTextView(
                                                title: "Agent Details",
                                                textColor: AppColors.colorc7e,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                            const Spacer(),
                                            AppRichTextView(
                                              title: "Saved",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.color582,
                                            ),
                                            const Icon(
                                              Icons
                                                  .check_circle_outline_outlined,
                                              color: AppColors.color582,
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Icon(
                                              Icons
                                                  .keyboard_arrow_down_outlined,
                                              size: 30.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppRichTextView(
                                          title: "Agent Details",
                                          textColor: AppColors.colorc7e,
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold),
                                      SizedBox(
                                        width: size.width * 0.2,
                                        child: LinearProgressIndicator(
                                          backgroundColor: AppColors.colorGrey
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          color: AppColors.colorc7e,
                                          minHeight: 15.sp,
                                          value: 0.4,
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 20.h,
                            ),
                            admissionConsumer.isAgentCompleted == false
                                ? const AgentDetailsForm()
                                : Container()
                          ],
                        ),
                      ),
                admissionConsumer.isAgentCompleted == false
                    ? Container()
                    : Column(
                      children: [
                        admissionConsumer.isEduCompleted == true
                            ? InkWell(
                                onTap: () {
                                  admissionConsumer
                                      .setEduSectionValue(false);
                                },
                                child: Card(
                                  color: AppColors.colorWhite,
                                  elevation: 5.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        AppRichTextView(
                                            title: "Education History",
                                            textColor: AppColors.colorc7e,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                        const Spacer(),
                                        AppRichTextView(
                                          title: "Saved",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.color582,
                                        ),
                                        const Icon(
                                          Icons
                                              .check_circle_outline_outlined,
                                          color: AppColors.color582,
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Icon(
                                          Icons
                                              .keyboard_arrow_down_outlined,
                                          size: 30.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppRichTextView(
                                      title: "Education History",
                                      textColor: AppColors.colorc7e,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    width: size.width * 0.2,
                                    child: LinearProgressIndicator(
                                      backgroundColor: AppColors.colorGrey
                                          .withOpacity(0.2),
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      color: AppColors.colorc7e,
                                      minHeight: 15.sp,
                                      value: 0.6,
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 20.h,
                        ),
                        admissionConsumer.isEduCompleted == false
                            ? const EducationDetailsForm()
                            : Container()
                      ],
                    ),
                    



                        admissionConsumer.isEduCompleted == false
                    ? Container()
                    : Column(
                      children: [
                        admissionConsumer.isjobCompleted == true
                            ? InkWell(
                                onTap: () {
                                  admissionConsumer
                                      .setjobSectionValue(false);
                                },
                                child: Card(
                                  color: AppColors.colorWhite,
                                  elevation: 5.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        AppRichTextView(
                                            title: "Employment History",
                                            textColor: AppColors.colorc7e,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                        const Spacer(),
                                        AppRichTextView(
                                          title: "Saved",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.color582,
                                        ),
                                        const Icon(
                                          Icons
                                              .check_circle_outline_outlined,
                                          color: AppColors.color582,
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Icon(
                                          Icons
                                              .keyboard_arrow_down_outlined,
                                          size: 30.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppRichTextView(
                                      title: "Employment History",
                                      textColor: AppColors.colorc7e,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    width: size.width * 0.2,
                                    child: LinearProgressIndicator(
                                      backgroundColor: AppColors.colorGrey
                                          .withOpacity(0.2),
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      color: AppColors.colorc7e,
                                      minHeight: 15.sp,
                                      value: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 20.h,
                        ),
                        admissionConsumer.isjobCompleted == false
                            ? const JobDetailsForm()
                            : Container()
                      ],
                    ),




                       admissionConsumer.isjobCompleted == false
                    ? Container()
                    : Column(
                      children: [
                        admissionConsumer.isEngProfiencyCompleted == true
                            ? InkWell(
                                onTap: () {
                                  admissionConsumer
                                      .setEngProficiencySectionValue (false);
                                      admissionConsumer.setEngProficiencyValue("");
                                },
                                child: Card(
                                  color: AppColors.colorWhite,
                                  elevation: 5.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        AppRichTextView(
                                            title: "English Proficiency",
                                            textColor: AppColors.colorc7e,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                        const Spacer(),
                                        AppRichTextView(
                                          title: "Saved",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.color582,
                                        ),
                                        const Icon(
                                          Icons
                                              .check_circle_outline_outlined,
                                          color: AppColors.color582,
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Icon(
                                          Icons
                                              .keyboard_arrow_down_outlined,
                                          size: 30.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppRichTextView(
                                      title: "English Proficiency",
                                      textColor: AppColors.colorc7e,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    width: size.width * 0.2,
                                    child: LinearProgressIndicator(
                                      backgroundColor: AppColors.colorGrey
                                          .withOpacity(0.2),
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      color: AppColors.colorc7e,
                                      minHeight: 15.sp,
                                      value: 0.85,
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 20.h,
                        ),
                        admissionConsumer.isEngProfiencyCompleted == false
                            ? const EngProficiencyForm()
                            : Container()
                      ],
                    ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
