  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_page_tabs/invoice/add_new_invoice_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';


   
  showAddInvoiceDialog(BuildContext context,  int ?studentid) {
   

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        AppRichTextView(
              title: "Add New Invoice",
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              textColor: AppColors.colorBlack),
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
      content:  AddNewInvoiceView(studentId: studentid!,)
     
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

