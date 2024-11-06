  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/provider/fees_provider.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_page_tabs/invoice/add_new_invoice_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';


   
  showAddInvoiceDialog(BuildContext context,  StudentDetail? studentData) {
   

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
          Consumer<FeesProvider>(
            builder: (context, feesConsumer ,child) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context);
                  feesConsumer.setSemFeeId(null);
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.colorRed,
                ),
              );
            }
          )
        ],
      ),
      content:  AddNewInvoiceView(studentData:studentData)
     
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

