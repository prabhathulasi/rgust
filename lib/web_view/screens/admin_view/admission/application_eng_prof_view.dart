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

class ApplicationEngProfView extends StatefulWidget {
  const ApplicationEngProfView({super.key});

  @override
  State<ApplicationEngProfView> createState() => _ApplicationEngProfViewState();
}

class _ApplicationEngProfViewState extends State<ApplicationEngProfView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdmissionProvider>(
        builder: (context, admissionConsumer, child) {
      if (admissionConsumer.admissionDetailModel.data!.internationalStudent ==
          false) {
        return Padding(
     padding: EdgeInsets.symmetric(horizontal: 150.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AppRichTextView(
                  title: "English Proficiency",
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
              AppRichTextView(
                  title: "How long have you been studying English?",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 5.h,
                ),
                AppRichTextView(
                  title: "Native Speaker",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 15.h,
                ),
                AppRichTextView(
                  title: "What is your present level of English?",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 5.h,
                ),
                AppRichTextView(
                  title: "Native Speaker",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
               
                SizedBox(
                  height: 15.h,
                ),
            ],
          ),
        );
      } else {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 150.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AppRichTextView(
                  title: "English Proficiency",
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
              AppRichTextView(
                title: "How long have you been studying English?",
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 5.h,
              ),
              AppRichTextView(
                title: admissionConsumer.admissionDetailModel.data!.engExp!,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 15.h,
              ),
              AppRichTextView(
                title: "What is your present level of English?",
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 5.h,
              ),
              AppRichTextView(
                title: admissionConsumer.admissionDetailModel.data!.engLevel!,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 15.h,
              ),
              AppRichTextView(
                title: "Have you taken any english proficiency examinations?",
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 5.h,
              ),
              AppRichTextView(
                title:
                    admissionConsumer.admissionDetailModel.data!.examTaken! ==
                            true
                        ? "Yes"
                        : "No",
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 15.h,
              ),
              admissionConsumer.admissionDetailModel.data!.examTaken! == false
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
                        InkWell(
                          onTap: () {
                            Uint8List memoryImageData = base64Decode(
                                admissionConsumer
                                    .admissionDetailModel.data!.document!);
                           

                            final blob =
                                html.Blob([memoryImageData], 'application/pdf');
                            final url = html.Url.createObjectUrlFromBlob(blob);

                            // Open the blob URL in a new tab
                            html.window.open(url, '_blank');
                          },
                          child: Card(
                            child: ListTile(
                              title: AppRichTextView(
                                title: "English Proficiency Document",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              trailing: const Icon(
                                Icons.visibility,
                                color: AppColors.colorc7e,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                     SizedBox(
                          height: 15.h,
                        ),
            ],
          ),
        );
      }
    });
  }
}
