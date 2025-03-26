  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/pdf_generate/testing.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/payment/generate_invoice/generate_invoice.dart';

import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
   
  showApprovedInvoiceDialog(BuildContext context,  StudentDetail? studentData) {
   

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
                child: GenerateStudentFeeInvoice(studentData: studentData),
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
                  title: "Approved",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.colorGreen),
                    
            ],
          ),
          AppRichTextView(
              title: "Approved at : 17th Nov 2023",
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              textColor: AppColors.colorc7e),
              AppRichTextView(
              title: "Approved by : Finance Department",
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

