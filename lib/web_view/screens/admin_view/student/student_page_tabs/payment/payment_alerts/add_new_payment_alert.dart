import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/payment/add_new_payment_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

showAddPaymentDialog(BuildContext context, StudentDetail? studentData, {bool isMisc = false,}) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppRichTextView(
              title: "Add New Payment",
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
      content: AddNewPaymentView(studentData: studentData, isMisc: isMisc),);

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
