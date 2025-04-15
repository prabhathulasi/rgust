import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/invoice/invoice_model.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvoiceButtonComponent extends StatelessWidget {
  final int studentId;
  const InvoiceButtonComponent({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgramProvider>(
        builder: (context, programConsumer, child) {
      return Consumer<InvoiceProvider>(
          builder: (context, invoiceConsumer, child) {
        return Row(
          children: [
           invoiceConsumer.invoiceList.isNotEmpty
                ? Container():  AppElevatedButon(
              title: "Add",
              buttonColor: AppColors.colorWhite,
              textColor: AppColors.color582,
              borderColor: AppColors.color582,
              height: 50.h,
              width: 100.w,
              onPressed: (context) async {
                if (invoiceConsumer.feeType == "tution") {
                  if (programConsumer.selectedDept == null) {
                    ToastHelper().errorToast("Please Select Program");
                  } else if (invoiceConsumer
                      .invoiceDescriptionController.text.isEmpty) {
                    ToastHelper()
                        .errorToast("Please Enter Invoice Description");
                  } else if (invoiceConsumer.usdAmountController.text.isEmpty) {
                    ToastHelper().errorToast("Please Enter Amount in USD");
                  } else if (invoiceConsumer
                      .conversionRateController.text.isEmpty) {
                    ToastHelper().errorToast("Please Enter Conversion Rate");
                  } else {
                    invoiceConsumer.addInvoice(
                      InvoiceModel(
                          regularTuitionFee: invoiceConsumer
                                  .regularTuitionFeeController.text.isEmpty
                              ? 0
                              : int.parse(invoiceConsumer
                                  .regularTuitionFeeController.text),
                          scholarshipType:
                              invoiceConsumer.selectedScholarshipItem!,
                          scholarshipAmount: invoiceConsumer
                                      .selectedScholarshipItem ==
                                  "N/A"
                              ? 0
                              : int.parse(
                                  invoiceConsumer.scholarshipController.text),
                          title: programConsumer.selectedDept!,
                          description:
                              invoiceConsumer.invoiceDescriptionController.text,
                          usd: invoiceConsumer.usdAmountController.text.isEmpty
                              ? 0
                              : int.parse(
                                  invoiceConsumer.usdAmountController.text),
                          gyd: invoiceConsumer.gydAmountController.text.isEmpty
                              ? 0
                              : int.parse(
                                  invoiceConsumer.gydAmountController.text),
                          studentId: studentId),
                    );
                  }
                } else if (invoiceConsumer.feeType == "misc") {
                  if (programConsumer.selectedDept == null) {
                    ToastHelper().errorToast("Please Select Program");
                  } else if (invoiceConsumer.selectedMiscItem == null) {
                    ToastHelper()
                        .errorToast("Please Enter Invoice Description");
                  } else if (invoiceConsumer.usdAmountController.text.isEmpty) {
                    ToastHelper().errorToast("Please Enter Amount in USD");
                  } else if (invoiceConsumer
                      .conversionRateController.text.isEmpty) {
                    ToastHelper().errorToast("Please Enter Conversion Rate");
                  } else {
                    invoiceConsumer.addMiscInvoice(
                      MiscInvoiceModel(
                        conversionrate: invoiceConsumer
                                .conversionRateController.text.isEmpty
                            ? 0
                            : int.parse(
                                invoiceConsumer.conversionRateController.text),
                        description: invoiceConsumer.selectedMiscItem!,
                        usd: invoiceConsumer.usdAmountController.text.isEmpty
                            ? 0
                            : int.parse(
                                invoiceConsumer.usdAmountController.text),
                        studentId: studentId,
                        year: programConsumer.selectedYear.toString(),
                      ),
                    );
                  }
                } else {}
              },
            ),
            SizedBox(
              width: 10.w,
            ),
            invoiceConsumer.invoiceList.isEmpty
                ? Container()
                : AppElevatedButon(
                    title: "Clear",
                    buttonColor: AppColors.colorWhite,
                    textColor: AppColors.colorRed,
                    borderColor: AppColors.colorRed,
                    height: 50.h,
                    width: 100.w,
                    onPressed: (context) async {
                      invoiceConsumer.clearInvoiceList();
                    },
                  ),
          ],
        );
      });
    });
  }
}
