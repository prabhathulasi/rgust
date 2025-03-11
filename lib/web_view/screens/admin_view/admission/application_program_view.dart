import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationProgramView extends StatefulWidget {
  const ApplicationProgramView({super.key});

  @override
  State<ApplicationProgramView> createState() => _ApplicationProgramViewState();
}

class _ApplicationProgramViewState extends State<ApplicationProgramView> {
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
                title: "Program Details",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              color: AppColors.colorBlack,
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
                        title: "Student Type",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title: admissionConsumer
                            .admissionDetailModel.data!.studentType!,
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
                        title: "Program",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title: admissionConsumer
                            .admissionDetailModel.data!.programName!,
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
                        title: "Semester",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title: admissionConsumer
                            .admissionDetailModel.data!.semester!,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppRichTextView(
                  title: "Previous Enrollment",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 5.h,
                ),
                AppRichTextView(
                  title: admissionConsumer
                              .admissionDetailModel.data!.alreadyEnrolled! ==
                          true
                      ? "Yes"
                      : "No",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            admissionConsumer.admissionDetailModel.data!.alreadyEnrolled! ==
                    false
                ? Container()
                : Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppRichTextView(
                              title: "Enrolled Program Name",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            AppRichTextView(
                              title: admissionConsumer.admissionDetailModel
                                  .data!.enrolledProgramName!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppRichTextView(
                              title: "University Name",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            AppRichTextView(
                              title: admissionConsumer
                                  .admissionDetailModel.data!.universityName!,
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
            admissionConsumer.admissionDetailModel.data!.alreadyEnrolled! ==
                    false
                ? Container()
                : AppRichTextView(
                    title: "Documents",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
            SizedBox(
              height: 15.h,
            ),
            admissionConsumer.admissionDetailModel.data!.alreadyEnrolled! ==
                    false
                ? Container()
                : InkWell(
                    onTap: () {
                      Uint8List memoryImageData = base64Decode(admissionConsumer
                          .admissionDetailModel.data!.transferDocument!);
                      final blob =
                          html.Blob([memoryImageData], 'application/pdf');
                      final url = html.Url.createObjectUrlFromBlob(blob);

                      // Open the blob URL in a new tab
                      html.window.open(url, '_blank');
                    },
                    child: Card(
                      child: ListTile(
                        title: AppRichTextView(
                          title: "Transfer Document",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        trailing: const Icon(
                          Icons.visibility,
                          color: AppColors.colorc7e,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      );
    });
  }
}
