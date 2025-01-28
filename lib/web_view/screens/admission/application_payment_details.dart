import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_provider.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'dart:html' as html;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationPaymentDetails extends StatefulWidget {
  const ApplicationPaymentDetails({super.key});

  @override
  State<ApplicationPaymentDetails> createState() =>
      _ApplicationPaymentDetailsState();
}

class _ApplicationPaymentDetailsState extends State<ApplicationPaymentDetails> {
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
                title: "Payment Details",
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
              title: "Payment Method",
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 5.h,
            ),
            admissionConsumer.admissionDetailModel.data!.paymentDate!.isEmpty
                ? Container()
                : AppRichTextView(
                    title: "Bank Transfer",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
            SizedBox(
              height: 15.h,
            ),
            AppRichTextView(
              title: "Payment Date",
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 5.h,
            ),
            AppRichTextView(
              title: admissionConsumer.admissionDetailModel.data!.paymentDate!,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: 15.h,
            ),
            admissionConsumer.admissionDetailModel.data!.documents!.isEmpty
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
                                  .admissionDetailModel.data!.documents!);
                      

                          final blob =
                              html.Blob([memoryImageData], 'application/pdf');
                          final url = html.Url.createObjectUrlFromBlob(blob);

                          // Open the blob URL in a new tab
                          html.window.open(url, '_blank');
                        },
                        child: Card(
                          child: ListTile(
                            title: AppRichTextView(
                              title: "Payment Document",
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
    });
  }
}
