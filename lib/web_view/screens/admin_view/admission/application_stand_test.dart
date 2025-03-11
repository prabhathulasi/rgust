import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationEngStandView extends StatefulWidget {
  const ApplicationEngStandView({super.key});

  @override
  State<ApplicationEngStandView> createState() =>
      _ApplicationEngStandViewState();
}

class _ApplicationEngStandViewState extends State<ApplicationEngStandView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdmissionProvider>(
        builder: (context, admissionConsumer, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 150.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AppRichTextView(
                title: "Standardized Test",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              color: AppColors.colorBlack,
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: AppRichTextView(
                    title: "#",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AppRichTextView(
                    title: "Test",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AppRichTextView(
                    title: "Location",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AppRichTextView(
                    title: "Date",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AppRichTextView(
                    title: "Attempts",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AppRichTextView(
                    title: "Highest Score",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            admissionConsumer.admissionDetailModel.data!.testTaken == true
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AppRichTextView(
                          title: "1",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AppRichTextView(
                          title: admissionConsumer
                              .admissionDetailModel.data!.testName!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AppRichTextView(
                          title: admissionConsumer
                              .admissionDetailModel.data!.testLocation!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AppRichTextView(
                          title: admissionConsumer
                              .admissionDetailModel.data!.testDate!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AppRichTextView(
                          title: admissionConsumer
                              .admissionDetailModel.data!.testAttempts!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AppRichTextView(
                          title: admissionConsumer
                              .admissionDetailModel.data!.testScore!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  )
                : Center(
                    child: AppRichTextView(
                      title: "No Test Taken",
                      fontSize: 15.sp,
                      textColor: AppColors.colorRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      );
    });
  }
}
