import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/invoice/alerts/misc_invoice_alert.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/invoice/alerts/new_invoice_alert.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class FeeTypeAlert extends StatelessWidget {
  final StudentDetail? studentData;
  const FeeTypeAlert({super.key, this.studentData});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<InvoiceProvider>(
        builder: (context, invoiceConsumer, child) {
      return Container(
        height: size.height * 0.42,
        width: size.width * 0.4,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25.r)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Card(
                      color: AppColors.colorWhite,
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: SizedBox(
                        height: 200.h,
                        child: Column(
                          children: [
                            Icon(
                              Icons.school_outlined,
                              size: 100.sp,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            AppRichTextView(
                                title: "Tution Fee",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.colorBlack),
                            SizedBox(
                              height: 10.h,
                            ),
                            Radio(
                              activeColor: AppColors.color446,
                              value: "tution",
                              groupValue: invoiceConsumer.feeType,
                              onChanged: (value) {
                                invoiceConsumer.setFeeType(value!);
                              },
                              focusNode: FocusNode(),
                              autofocus:
                                  true, // Autofocus is optional, depending on the app's needs.
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: Card(
                      color: AppColors.colorWhite,
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: SizedBox(
                        height: 200.h,
                        child: Column(
                          children: [
                            Icon(
                              Icons.miscellaneous_services,
                              size: 100.sp,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            AppRichTextView(
                                title: "Miscellaneous Fee",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.colorBlack),
                            SizedBox(
                              height: 10.h,
                            ),
                            Radio(
                              activeColor: AppColors.color446,
                              value: "misc",
                              groupValue: invoiceConsumer.feeType,
                              onChanged: (value) {
                                invoiceConsumer.setFeeType(value!);
                              },
                              focusNode: FocusNode(),
                              autofocus:
                                  true, // Autofocus is optional, depending on the app's needs.
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                 
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              AppElevatedButon(
                title: "Next",
                borderColor: AppColors.color446,
                buttonColor: AppColors.colorWhite,
                height: 50.h,
                width: 100.w,
                textColor: AppColors.color446,
                onPressed: (context) {
                  if (invoiceConsumer.feeType == "tution") {
                    showAddInvoiceAlert(context, studentData);
                  } else  {
                    showMiscInvoiceAlert(context, studentData);
                  }
                  
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

showInvoiceTypeAlert(BuildContext context, StudentDetail? studentData) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      backgroundColor: AppColors.colorWhite,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppRichTextView(
              title: "Select Invoice Type",
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
      content: FeeTypeAlert(studentData: studentData));

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
