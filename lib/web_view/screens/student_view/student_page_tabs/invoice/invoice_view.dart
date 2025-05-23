import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/model/student/student_invoice_model.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/payment/generate_invoice/generate_invoice.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/payment/payment_alerts/add_new_payment_alert.dart';

import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/payment/payment_alerts/pending_invoice_alert.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/payment/payment_alerts/rejected_invoice_alert.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';
import 'dart:html' as html;

class StudentInvoiceView extends StatelessWidget {
  final StudentDetail? studentData;
  const StudentInvoiceView({super.key, required this.studentData});

  @override
  Widget build(BuildContext context) {
    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);

    Future getInvoiceLIst() async {
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
        var result = await invoiceProvider.getStudentInvoiceList(
            token, studentData!.iD!);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    return Scaffold(
      
      body: studentData!.studentFees!.isEmpty
          ? Center(
              child: AppRichTextView(
                  title:
                      "Please Update Semester Tution Details to upload Invoice",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.colorRed),
            )
          : FutureBuilder(
              future: getInvoiceLIst(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitSpinningLines(
                      color: AppColors.colorc7e,
                      size: 60.sp,
                    ),
                  );
                } else {
                  return Consumer<InvoiceProvider>(
                      builder: (context, invoiceConsumer, child) {
                    var data =
                        invoiceConsumer.studentInvoiceListModel.invoiceList;
                    return data == null
                        ? Center(
                            child: AppRichTextView(
                                title: "No Invoice Records Found",
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.colorc7e),
                          )
                        : Container(
                            margin: EdgeInsets.all(20.sp),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        AppRichTextView(
                                            title: "Approved Payments",
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.bold,
                                            textColor: AppColors.colorc7e),
                                        data
                                                .where((element) =>
                                                    element.status ==
                                                    "Approved")
                                                .isEmpty
                                            ? Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 150.h),
                                                  child: AppRichTextView(
                                                      title:
                                                          "No Approved Payments Record Available",
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      textColor:
                                                          AppColors.colorc7e),
                                                ),
                                              )
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: data
                                                    .where((element) =>
                                                        element.status ==
                                                        "Approved")
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: InkWell(
                                                      onTap: () async{
                                                       var result = await generateStudentInvoice(PdfPageFormat.a4, studentData, data[index]);
                                                             final blob = html.Blob(
                                                [result], 'application/pdf');
                                            final url = html.Url
                                                .createObjectUrlFromBlob(blob);

                                            // Open the blob URL in a new tab
                                            html.window.open(url, '_blank');
                                                      },
                                                      child: Card(
                                                          elevation: 10.0,
                                                          child: ListTile(
                                                            isThreeLine: true,
                                                          
                                                            title: AppRichTextView(
                                                                title: data[
                                                                        index]
                                                                    .invoiceName!,
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                textColor:
                                                                    AppColors
                                                                        .colorc7e),
                                                            subtitle: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                AppRichTextView(
                                                                    title: DateFormat(
                                                                            'dd MMMM yyyy')
                                                                        .format(DateTime.parse(
                                                                            data[index]
                                                                                .createdAt!)),
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    textColor:
                                                                        AppColors
                                                                            .colorGrey),
                                                                Row(
                                                                  children: [
                                                                    AppRichTextView(
                                                                        title:
                                                                            "Status: ",
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        textColor:
                                                                            AppColors.colorBlack),
                                                                    AppRichTextView(
                                                                        title: data[index]
                                                                            .status!,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        textColor:
                                                                            AppColors.colorGreen),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                            trailing:
                                                                IntrinsicHeight(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  AppRichTextView(
                                                                      title:
                                                                          "Amount: \$${data[index].amountInUsd}",
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      textColor:
                                                                          AppColors
                                                                              .colorc7e),
                                                                  AppRichTextView(
                                                                      title:
                                                                          "Approved Date: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(data[index].updatedAt!))}",
                                                                      fontSize:
                                                                          10.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      textColor:
                                                                          AppColors
                                                                              .colorc7e),
                                                                  AppRichTextView(
                                                                      title:
                                                                          "Approved By: ${data[index].updatedBy}",
                                                                      fontSize:
                                                                          10.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      textColor:
                                                                          AppColors
                                                                              .colorc7e),
                                                                ],
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  );
                                                },
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                const VerticalDivider(),
                                Expanded(
                                  flex: 1,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppRichTextView(
                                            title: "Pending Payments",
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.bold,
                                            textColor: AppColors.colorc7e),
                                        data
                                                .where((element) =>
                                                    element.status == "Pending")
                                                .isEmpty
                                            ? Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 150.h),
                                                  child: AppRichTextView(
                                                      title:
                                                          "No Pending Payments Record Available",
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      textColor:
                                                          AppColors.colorc7e),
                                                ),
                                              )
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: data
                                                    .where((element) =>
                                                        element.status ==
                                                        "Pending")
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  List<InvoiceList>
                                                      pendingData = data
                                                          .where((element) =>
                                                              element.status ==
                                                              "Pending")
                                                          .toList();
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Card(
                                                        elevation: 10.0,
                                                        child: ListTile(
                                                          isThreeLine: true,
                                                          leading: const Icon(
                                                            Icons
                                                                .receipt_long_outlined,
                                                            color: AppColors
                                                                .colorc7e,
                                                          ),
                                                          title: AppRichTextView(
                                                              title: pendingData[
                                                                      index]
                                                                  .invoiceName!,
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              textColor:
                                                                  AppColors
                                                                      .colorc7e),
                                                          subtitle: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              AppRichTextView(
                                                                  title:
                                                                      "Amount: \$${pendingData[index].amountInUsd}",
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  textColor:
                                                                      AppColors
                                                                          .colorc7e),
                                                              AppRichTextView(
                                                                  title: DateFormat(
                                                                          'dd MMMM yyyy')
                                                                      .format(DateTime.parse(pendingData[index]
                                                                          .createdAt!)),
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  textColor:
                                                                      AppColors
                                                                          .colorGrey),
                                                              Row(
                                                                children: [
                                                                  AppRichTextView(
                                                                      title:
                                                                          "Status: ",
                                                                      fontSize:
                                                                          15.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      textColor:
                                                                          AppColors
                                                                              .colorBlack),
                                                                  AppRichTextView(
                                                                      title:
                                                                          "${pendingData[index].status}",
                                                                      fontSize:
                                                                          15.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      textColor:
                                                                          AppColors
                                                                              .contentColorOrange),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          trailing:
                                                              AppElevatedButon(
                                                            title: "View",
                                                            buttonColor:
                                                                AppColors
                                                                    .colorc7e,
                                                            textColor: AppColors
                                                                .colorWhite,
                                                            height: 50.h,
                                                            width: 120.w,
                                                            onPressed:
                                                                (context) {
                                                              showPendingInvoiceDialog(
                                                                  context,
                                                                  pendingData[
                                                                      index],
                                                                  studentData);
                                                            },
                                                          ),
                                                        )),
                                                  );
                                                },
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                const VerticalDivider(),
                                Expanded(
                                  flex: 1,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppRichTextView(
                                            title: "Rejected Payments",
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.bold,
                                            textColor: AppColors.colorc7e),
                                        data
                                                .where((element) =>
                                                    element.status ==
                                                    "Cancelled")
                                                .isEmpty
                                            ? Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 150.h),
                                                  child: AppRichTextView(
                                                      title:
                                                          "No Rejected Payments Record Available",
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      textColor:
                                                          AppColors.colorc7e),
                                                ),
                                              )
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: data
                                                    .where((element) =>
                                                        element.status ==
                                                        "Cancelled")
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  List<InvoiceList>
                                                      cancelledData = data
                                                          .where((element) =>
                                                              element.status ==
                                                              "Cancelled")
                                                          .toList();
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Card(
                                                        elevation: 10.0,
                                                        child: ListTile(
                                                          isThreeLine: true,
                                                          leading: const Icon(
                                                            Icons
                                                                .receipt_long_outlined,
                                                            color: AppColors
                                                                .colorc7e,
                                                          ),
                                                          title: AppRichTextView(
                                                              title: cancelledData[
                                                                      index]
                                                                  .invoiceName!,
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              textColor:
                                                                  AppColors
                                                                      .colorc7e),
                                                          subtitle: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              AppRichTextView(
                                                                  title:
                                                                      "Amount: \$${cancelledData[index].amountInUsd}",
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  textColor:
                                                                      AppColors
                                                                          .colorc7e),
                                                              AppRichTextView(
                                                                  title: DateFormat(
                                                                          'dd MMMM yyyy')
                                                                      .format(DateTime.parse(cancelledData[index]
                                                                          .createdAt!)),
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  textColor:
                                                                      AppColors
                                                                          .colorGrey),
                                                              Row(
                                                                children: [
                                                                  AppRichTextView(
                                                                      title:
                                                                          "Status: ",
                                                                      fontSize:
                                                                          15.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      textColor:
                                                                          AppColors
                                                                              .colorBlack),
                                                                  AppRichTextView(
                                                                      title:
                                                                          "${cancelledData[index].status}",
                                                                      fontSize:
                                                                          15.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      textColor:
                                                                          AppColors
                                                                              .colorRed),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          trailing:
                                                              AppElevatedButon(
                                                            title: "View",
                                                            buttonColor:
                                                                AppColors
                                                                    .colorc7e,
                                                            textColor: AppColors
                                                                .colorWhite,
                                                            height: 50.h,
                                                            width: 120.w,
                                                            onPressed:
                                                                (context) {
                                                              showRejectedInvoiceDialog(
                                                                  context);
                                                            },
                                                          ),
                                                        )),
                                                  );
                                                },
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                  });
                }
              }),
      floatingActionButton: studentData!.studentFees!.isEmpty
          ? Container()
          : FloatingActionButton(
              backgroundColor: AppColors.colorc7e,
              child: const Icon(
                Icons.file_upload,
                color: AppColors.colorWhite,
              ),
              onPressed: () async {
                showAddPaymentDialog(context, studentData);
              },
            ),
    );
  }
}
