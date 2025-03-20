import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_criminal_check_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/admission/pdf_generate/admission_pdf_print.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'dart:html' as html;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationPaymentDetails extends StatefulWidget {
  final int applicationId;

  const ApplicationPaymentDetails({super.key, required this.applicationId});

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
            admissionConsumer.admissionDetailModel.data!.signature!.isEmpty
                ? Container()
                : Container(
                    height: 100.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.colorBlack)),
                    child: Center(
                      child: Image.memory(
                        base64Decode(admissionConsumer
                            .admissionDetailModel.data!.signature!),
                        errorBuilder: (context, error, stackTrace) {
                          // Handle the error by displaying a fallback widget
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, color: Colors.red),
                              SizedBox(height: 10),
                              Text('Failed to load signature image',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          );
                        },
                      ),
                    ),
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
            Row(
              children: [
                AppElevatedButon(
                  title: "Accept",
                  borderColor: AppColors.colorGreen,
                  buttonColor: AppColors.colorWhite,
                  height: 50.h,
                  width: 120.w,
                  onPressed: (context) async {
                    var token = await getTokenAndUseIt();
                    if (token == null) {
                      if (context.mounted) {
                        Navigator.pushNamed(context, RouteNames.login);
                      }
                    } else if (token == "Token Expired") {
                      ToastHelper()
                          .errorToast("Session Expired Please Login Again");

                      if (context.mounted) {
                        Navigator.pushNamed(context, RouteNames.login);
                      }
                    } else {
                      admissionConsumer.updateApplicationApprovalStatus(
                          widget.applicationId, token, "Accepted");
                    }
                  },
                  textColor: AppColors.colorGreen,
                ),
                SizedBox(
                  width: 20.w,
                ),
                AppElevatedButon(
                  title: "Reject",
                  borderColor: AppColors.colorRed,
                  buttonColor: AppColors.colorWhite,
                  height: 50.h,
                  width: 120.w,
                  onPressed: (context) async {
                    var token = await getTokenAndUseIt();
                    if (token == null) {
                      if (context.mounted) {
                        Navigator.pushNamed(context, RouteNames.login);
                      }
                    } else if (token == "Token Expired") {
                      ToastHelper()
                          .errorToast("Session Expired Please Login Again");

                      if (context.mounted) {
                        Navigator.pushNamed(context, RouteNames.login);
                      }
                    } else {
                      admissionConsumer.updateApplicationApprovalStatus(
                          widget.applicationId, token, "Rejected");
                    }
                  },
                  textColor: AppColors.colorRed,
                ),
                Spacer(),
                Consumer<AdmissionCriminalCheckProvider>(
                    builder: (context, admissionCriminalCheckProvider, child) {
                  return AppElevatedButon(
                    title: "Print",
                    borderColor: AppColors.color446,
                    buttonColor: AppColors.colorWhite,
                    height: 50.h,
                    width: 120.w,
                    onPressed: (context) {
                      printApplication(
                          admissionConsumer, admissionCriminalCheckProvider);
                    },
                    textColor: AppColors.color446,
                  );
                }),
              ],
            )
          ],
        ),
      );
    });
  }
}
