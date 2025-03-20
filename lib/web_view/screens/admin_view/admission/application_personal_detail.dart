import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicantPersonalDetail extends StatelessWidget {
  const ApplicantPersonalDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdmissionProvider>(
        builder: (context, admissionConsumer, child) {
      var memoryImagedata =
          base64Decode(admissionConsumer.admissionDetailModel.data!.photo!);
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 150.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AppRichTextView(
                title: "Personal Details",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: AppRichTextView(
                textColor: AppColors.colora2f,
                title: "As they Appears in the Passport where applicable",
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              color: AppColors.colorBlack,
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Card(
                elevation: 5.0,
                child: Container(
                  height: 150.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                     
                      image: DecorationImage(
                          image: MemoryImage(memoryImagedata),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "Title",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title:
                            admissionConsumer.admissionDetailModel.data!.title!,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "First Name",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title: admissionConsumer
                            .admissionDetailModel.data!.firstName!,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "Last Name",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title: admissionConsumer
                            .admissionDetailModel.data!.lastName!,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
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
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "Gender",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title: admissionConsumer
                                    .admissionDetailModel.data!.gender! ==
                                "GenderEnum.male"
                            ? "Male"
                            : "Female",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "Date of Birth",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title:
                            admissionConsumer.admissionDetailModel.data!.dob!,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "Passport ",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title: admissionConsumer
                            .admissionDetailModel.data!.passportNumber!,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
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
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "Country of Birth",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title: admissionConsumer
                            .admissionDetailModel.data!.birthCountry!,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "Country of Citizenship",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppRichTextView(
                        title: admissionConsumer
                            .admissionDetailModel.data!.citizenship!,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "Residing Country",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppRichTextView(
                        title: admissionConsumer
                            .admissionDetailModel.data!.residingCountry!,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            AppRichTextView(
              title: "Will you be Studying on a student Visa?",
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 5.h,
            ),
            AppRichTextView(
              title: admissionConsumer.admissionDetailModel.data!.studentVisa ==
                      true
                  ? "Yes"
                  : "No",
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
             SizedBox(
              height: 15.h,
            ),
            AppRichTextView(
              title: "Will you be speak any language other than English?",
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 5.h,
            ),
            admissionConsumer.admissionDetailModel.data!.otherLanguages!.isEmpty
                ? AppRichTextView(
                    title: "No",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  )
                : Wrap(
                    children: admissionConsumer
                        .admissionDetailModel.data!.otherLanguages!
                        .map((item) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Chip(
                                  label: AppRichTextView(
                                title: item.langName!,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              )),
                        ))
                        .toList(),
                  ),
                  SizedBox(
              height: 15.h,
            ),
            AppRichTextView(
              title: "Will you have a disability for which additional assistance may be required?",
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 5.h,
            ),
            AppRichTextView(
              title: admissionConsumer.admissionDetailModel.data!.disabilty!,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
             SizedBox(
              height: 15.h,
            ),
            admissionConsumer.admissionDetailModel.data!.disabilty! == "Yes"?  AppRichTextView(
              title: admissionConsumer.admissionDetailModel.data!.disablityDetails!,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ): Container(),
          ],
        ),
      );
    });
  }
}
