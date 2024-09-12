  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
   
  showPendingInvoiceDialog(BuildContext context) {
    // set up the button
    Widget approveButton = AppElevatedButon(
      title: "Approve",
      buttonColor: AppColors.colorf85,
      textColor: AppColors.colorWhite,
      height: 50.h,
      width: 120.w,
      onPressed: (context) {},
    );
    Widget denyButton = AppElevatedButon(
      title: "Deny",
      buttonColor: AppColors.colorRed,
      textColor: AppColors.colorWhite,
      height: 50.h,
      width: 110.w,
      onPressed: (context) {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Receipt_0234"),
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
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            AppRichTextView(
                title: "From Account No: 12345678930",
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                textColor: AppColors.colorc7e),
            AppRichTextView(
                title: "Bank Name:XYZ Bank",
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                textColor: AppColors.colorc7e),
            AppRichTextView(
                title: "Amount: \$1000",
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

