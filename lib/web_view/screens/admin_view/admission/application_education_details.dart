import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationEducationDetails extends StatefulWidget {
  const ApplicationEducationDetails({super.key});

  @override
  State<ApplicationEducationDetails> createState() =>
      _ApplicationEducationDetailsState();
}

class _ApplicationEducationDetailsState
    extends State<ApplicationEducationDetails> {
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
                title: "Education History",
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
                    title: "Course",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AppRichTextView(
                    title: "Institution",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AppRichTextView(
                    title: "Date Commenced",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AppRichTextView(
                    title: "Date Completed",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: admissionConsumer
                    .admissionDetailModel.data!.educationDetails!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: AppRichTextView(
                            title: "${index + 1}",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: AppRichTextView(
                            title: admissionConsumer.admissionDetailModel.data!
                                .educationDetails![index].courseName!,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: AppRichTextView(
                            title: admissionConsumer.admissionDetailModel.data!
                                .educationDetails![index].highSchoolName!,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: AppRichTextView(
                            title: admissionConsumer.admissionDetailModel.data!
                                .educationDetails![index].startDate!,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: AppRichTextView(
                            title: admissionConsumer.admissionDetailModel.data!
                                .educationDetails![index].endDate!,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  );
                }),
            AppRichTextView(
              title: "Documents",
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 15.h,
            ),
          admissionConsumer
                    .admissionDetailModel.data!.educationDetails!.isEmpty?Container():  ListView.builder(
                shrinkWrap: true,
                itemCount: admissionConsumer
                    .admissionDetailModel.data!.educationDetails!.length,
                itemBuilder: (context, index) {
                  Uint8List memoryImageData = base64Decode(admissionConsumer
                      .admissionDetailModel
                      .data!
                      .educationDetails![index]
                      .document!);
                  // File tempPdfFile = File.fromRawPath(memoryImageData);
                  return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () {
                          final blob =
                              html.Blob([memoryImageData], 'application/pdf');
                          final url = html.Url.createObjectUrlFromBlob(blob);

                          // Open the blob URL in a new tab
                          html.window.open(url, '_blank');
                        },
                        child: Card(
                          child: ListTile(
                            title: AppRichTextView(
                              title: admissionConsumer.admissionDetailModel
                                  .data!.educationDetails![index].courseName!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            trailing: const Icon(Icons.visibility,color: AppColors.colorc7e,),
                          ),
                        ),
                      ));
                }),
                 SizedBox(
              height: 15.h,
            ),
          ],
        ),
      );
    });
  }
}
