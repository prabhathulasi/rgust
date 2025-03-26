import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';

import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

showRejectedInvoiceDialog(BuildContext context) {
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
          Row(
            children: [
              AppRichTextView(
                  title: "Status: ",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.colorc7e),
              AppRichTextView(
                  title: "Rejected",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.colorRed),
                    
            ],
          ),
          AppRichTextView(
              title: "Rejected at : 17th Nov 2023",
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              textColor: AppColors.colorc7e),
              AppRichTextView(
              title: "Rejected by : Finance Department",
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              textColor: AppColors.colorc7e),
        ],
      ),
    ),
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
