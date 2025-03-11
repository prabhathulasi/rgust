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

class ApplicationJobDetails extends StatefulWidget {
  const ApplicationJobDetails({super.key});

  @override
  State<ApplicationJobDetails> createState() => _ApplicationJobDetailsState();
}

class _ApplicationJobDetailsState extends State<ApplicationJobDetails> {
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
                title: "Employment History",
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
                    title: "Type of Work",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AppRichTextView(
                    title: "Employer",
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
              height: 15.h,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: admissionConsumer
                    .admissionDetailModel.data!.jobDetails!.length,
                itemBuilder: (context, index) {
                  if (admissionConsumer.admissionDetailModel.data!
                          .jobDetails![index].previousExp ==
                      false) {
                    return Center(
                      child: AppRichTextView(
                          title: "No Job Details",
                          textColor: AppColors.colorRed,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    );
                  } else {
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
                              title: admissionConsumer.admissionDetailModel
                                  .data!.jobDetails![index].role!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: admissionConsumer.admissionDetailModel
                                  .data!.jobDetails![index].employername!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: admissionConsumer.admissionDetailModel
                                  .data!.jobDetails![index].startDate!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: admissionConsumer.admissionDetailModel
                                  .data!.jobDetails![index].endDate!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }),
            admissionConsumer.admissionDetailModel.data!.jobDetails!.isEmpty
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "Documents",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: admissionConsumer
                              .admissionDetailModel.data!.jobDetails!.length,
                          itemBuilder: (context, index) {
                            if (admissionConsumer.admissionDetailModel.data!
                                    .jobDetails![index].previousExp ==
                                true) {
                              Uint8List memoryImageData = base64Decode(
                                  admissionConsumer.admissionDetailModel.data!
                                      .jobDetails![index].document!);
                           
                              return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      final blob = html.Blob(
                                          [memoryImageData], 'application/pdf');
                                      final url =
                                          html.Url.createObjectUrlFromBlob(
                                              blob);

                                      // Open the blob URL in a new tab
                                      html.window.open(url, '_blank');
                                    },
                                    child: Card(
                                      child: ListTile(
                                        title: AppRichTextView(
                                          title: admissionConsumer
                                              .admissionDetailModel
                                              .data!
                                              .jobDetails![index]
                                              .employername!,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        trailing: const Icon(
                                          Icons.visibility,
                                          color: AppColors.colorc7e,
                                        ),
                                      ),
                                    ),
                                  ));
                            } else {
                              return Container();
                            }
                          }),
                    ],
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
