import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/model/student/student_invoice_model.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

showPendingInvoiceDialog(
    BuildContext context, InvoiceList? data, StudentDetail? studentData) {
  // set up the button
  Widget approveButton =
      Consumer<InvoiceProvider>(builder: (context, invoiceConsumer, child) {
    return AppElevatedButon(
      loading: invoiceConsumer.isLoading,
      title: "Approve",
      buttonColor: AppColors.colorf85,
      textColor: AppColors.colorWhite,
      height: 50.h,
      width: 120.w,
      onPressed: (context) async {
        //     showDialog(
        //   barrierDismissible: false,
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //        title: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text("Generated Invoice"),
        //       InkWell(
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //         child: const Icon(
        //           Icons.close,
        //           color: AppColors.colorRed,
        //         ),
        //       )

        //     ],
        //   ),
        //   content: SizedBox(
        //     width: MediaQuery.sizeOf(context).width/2,
        //     child:  GenerateStudentFeeInvoice(studentData: studentData,)),
        //     );
        //   },
        // );

        var token = await getTokenAndUseIt();
        if (token == null) {
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        } else if (token == "Token Expired") {
          ToastHelper().errorToast("Session Expired Please Login Again");

          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        } else {
          var result = await invoiceConsumer.updateStudentInvoiceStatus(
              token, data!.iD!, data.studentId!, "Approved");
          if (result == "Invalid Token") {
            ToastHelper().errorToast("Session Expired Please Login Again");
            if (context.mounted) {
              Navigator.pushNamed(context, RouteNames.login);
            }
          } else if (result == 200) {
            ToastHelper().sucessToast("Invoice Approved");
            if (context.mounted) {
              Navigator.pop(context);
            }
          }
        }
      },
    );
  });
  Widget denyButton =
      Consumer<InvoiceProvider>(builder: (context, invoiceConsumer, child) {
    return AppElevatedButon(
        title: "Deny",
        buttonColor: AppColors.colorRed,
        textColor: AppColors.colorWhite,
        height: 50.h,
        width: 110.w,
        onPressed: (context) async {
          var token = await getTokenAndUseIt();
          if (token == null) {
            if (context.mounted) {
              Navigator.pushNamed(context, RouteNames.login);
            }
          } else if (token == "Token Expired") {
            ToastHelper().errorToast("Session Expired Please Login Again");

            if (context.mounted) {
              Navigator.pushNamed(context, RouteNames.login);
            }
          } else {
            var result = await invoiceConsumer.updateStudentInvoiceStatus(
                token, data!.iD!, data.studentId!, "Cancelled");
            if (result == "Invalid Token") {
              ToastHelper().errorToast("Session Expired Please Login Again");
              if (context.mounted) {
                Navigator.pushNamed(context, RouteNames.login);
              }
            } else if (result == 200) {
              ToastHelper().sucessToast("Invoice Approved");
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          }
        });
  });
  
  var memoryPdfData = base64Decode(data!.invoiceData!);
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(data.invoiceName!),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            color: AppColors.colorRed,
          ),
        )
      ],
    ),
    content: IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 300.h,
              width: 300.w,
              decoration: BoxDecoration(border: Border.all()),
              child: PdfViewer.openData(memoryPdfData),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          AppRichTextView(
              title: "From Account No: ${data.fromAccountNumber}",
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              textColor: AppColors.colorc7e),
          AppRichTextView(
              title: "Bank Name: ${data.bankName}",
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              textColor: AppColors.colorc7e),
          AppRichTextView(
              title: "Amount: \$${data.amountInUsd}",
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              textColor: AppColors.colorc7e),
        ],
      ),
    ),
    actions: [approveButton, denyButton],
  );

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
