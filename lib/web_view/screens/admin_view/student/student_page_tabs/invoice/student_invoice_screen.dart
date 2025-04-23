import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/invoice/alerts/fee_type_alert.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/invoice/pdf_generate/student_invoice_generate.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:html' as html;

class Studentinvoicescreen extends StatefulWidget {
  final StudentDetail? studentData;

  const Studentinvoicescreen({super.key, required this.studentData});

  @override
  State<Studentinvoicescreen> createState() => _StudentinvoicescreenState();
}

class _StudentinvoicescreenState extends State<Studentinvoicescreen> {
  getInvoiceRecord(
      InvoiceProvider invoiceConsumer, BuildContext context) async {
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
      await invoiceConsumer.getFeeInvoice(
        token,
        widget.studentData!.iD!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var invoiceProvider = Provider.of<InvoiceProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
          future: getInvoiceRecord(invoiceProvider, context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitSpinningLines(color: AppColors.color446),
              );
            } else {
              return invoiceProvider
                          .invoiceResponseModel.invoiceData!.isEmpty &&
                      invoiceProvider.invoiceResponseModel.miscData!.isEmpty
                  ? const Center(
                      child: Text("No Invoice Found"),
                    )
                  : Consumer<InvoiceProvider>(
                    builder: (context, invoiceConsumer, child) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: AppRichTextView(
                                              title: "Tution Invoices",
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: invoiceProvider
                                            .invoiceResponseModel
                                            .invoiceData!
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(right: 18),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      var result =
                                                          await generateNewInvoice(
                                                        PdfPageFormat.a4,
                                                        widget.studentData!,
                                                        invoiceProvider
                                                            .invoiceResponseModel
                                                            .invoiceData![index],
                                                      );
                                                      final blob = html.Blob(
                                                          [result],
                                                          'application/pdf');
                                                      final url = html.Url
                                                          .createObjectUrlFromBlob(
                                                              blob);
                      
                                                      // Open the blob URL in a new tab
                                                      html.window
                                                          .open(url, '_blank');
                                                    },
                                                    child: Card(
                                                      elevation: 5.0,
                                                      child: ListTile(
                                                        dense: true,
                                                        trailing: const Icon(
                                                          Icons.visibility,
                                                          color: AppColors.color446,
                                                        ),
                                                        isThreeLine: true,
                                                        title: Row(
                                                          children: [
                                                            AppRichTextView(
                                                                title:
                                                                    "Invoice Date: ",
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            AppRichTextView(
                                                                title: DateFormat(
                                                                        'yyyy-MM-dd – kk:mm')
                                                                    .format(DateTime.parse(invoiceProvider
                                                                        .invoiceResponseModel
                                                                        .invoiceData![
                                                                            index]
                                                                        .createdAt!)),
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight.w500)
                                                          ],
                                                        ),
                                                        subtitle: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                AppRichTextView(
                                                                    title:
                                                                        "Invoice Amount(USD): ",
                                                                    fontSize: 15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                AppRichTextView(
                                                                    title: invoiceProvider
                                                                        .invoiceResponseModel
                                                                        .invoiceData![
                                                                            index]
                                                                        .amountInUsd
                                                                        .toString(),
                                                                    fontSize: 14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                AppRichTextView(
                                                                    title:
                                                                        "Invoice Type: ",
                                                                    fontSize: 15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                AppRichTextView(
                                                                    title: invoiceProvider
                                                                        .invoiceResponseModel
                                                                        .invoiceData![
                                                                            index]
                                                                        .invoiceType!
                                                                        .toUpperCase(),
                                                                    fontSize: 14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                               InkWell(
                                                    onTap: () async {
                                                      var token =
                                                          await getTokenAndUseIt();
                                                      if (token == null) {
                                                        if (context.mounted) {
                                                          Navigator.pushNamed(
                                                              context,
                                                              RouteNames.login);
                                                        }
                                                      } else if (token ==
                                                          "Token Expired") {
                                                        ToastHelper().errorToast(
                                                            "Session Expired Please Login Again");
                      
                                                        if (context.mounted) {
                                                          Navigator.pushNamed(
                                                              context,
                                                              RouteNames.login);
                                                        }
                                                      } else {
                                                        await invoiceConsumer
                                                            .deleteTutionInvoice(
                                                          invoiceProvider
                                                              .invoiceResponseModel
                                                              .invoiceData![index]
                                                              .iD!,
                                                          token,
                                                          widget.studentData!.iD!,
                                                        );
                                                      }
                                                    },
                                                    child: const Icon(Icons.delete,
                                                        color: AppColors.colorRed),
                                                  
                                               )
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const VerticalDivider(),
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: AppRichTextView(
                                              title: "Miscellaneous  Invoices",
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: invoiceProvider
                                            .invoiceResponseModel.miscData!.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(right: 18),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      // var result = await generateNewInvoice(
                                                      //   PdfPageFormat.a4,
                                                      //   widget.studentData!,
                                                      //   invoiceProvider.invoiceResponseModel
                                                      //       .invoiceData![index],
                                                      // );
                                                      // final blob = html.Blob(
                                                      //     [result], 'application/pdf');
                                                      // final url =
                                                      //     html.Url.createObjectUrlFromBlob(
                                                      //         blob);
                      
                                                      // // Open the blob URL in a new tab
                                                      // html.window.open(url, '_blank');
                                                    },
                                                    child: Card(
                                                      elevation: 5.0,
                                                      child: ListTile(
                                                        dense: true,
                                                        trailing: const Icon(
                                                          Icons.visibility,
                                                          color: AppColors.color446,
                                                        ),
                                                        isThreeLine: true,
                                                        title: Row(
                                                          children: [
                                                            AppRichTextView(
                                                                title:
                                                                    "Invoice Date: ",
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            AppRichTextView(
                                                                title: DateFormat(
                                                                        'yyyy-MM-dd – kk:mm')
                                                                    .format(DateTime.parse(invoiceProvider
                                                                        .invoiceResponseModel
                                                                        .miscData![
                                                                            index]
                                                                        .createdAt!)),
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight.w500)
                                                          ],
                                                        ),
                                                        subtitle: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                AppRichTextView(
                                                                    title:
                                                                        "Invoice Amount(USD): ",
                                                                    fontSize: 15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                AppRichTextView(
                                                                    title: invoiceProvider
                                                                        .invoiceResponseModel
                                                                        .miscData![
                                                                            index]
                                                                        .amountInUsd
                                                                        .toString(),
                                                                    fontSize: 14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                AppRichTextView(
                                                                    title:
                                                                        "Invoice Type: ",
                                                                    fontSize: 15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                AppRichTextView(
                                                                    title: invoiceProvider
                                                                        .invoiceResponseModel
                                                                        .miscData![
                                                                            index]
                                                                        .miscInvoiceDescription!
                                                                        .toUpperCase(),
                                                                    fontSize: 14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                InkWell(
                                                  onTap: () async{
                                                        var token =
                                                          await getTokenAndUseIt();
                                                      if (token == null) {
                                                        if (context.mounted) {
                                                          Navigator.pushNamed(
                                                              context,
                                                              RouteNames.login);
                                                        }
                                                      } else if (token ==
                                                          "Token Expired") {
                                                        ToastHelper().errorToast(
                                                            "Session Expired Please Login Again");
                      
                                                        if (context.mounted) {
                                                          Navigator.pushNamed(
                                                              context,
                                                              RouteNames.login);
                                                        }
                                                      } else {
                                                        await invoiceConsumer
                                                            .deleteMiscInvoice(
                                                          invoiceProvider
                                                              .invoiceResponseModel
                                                              .miscData![index]
                                                              .iD!,
                                                          token,
                                                          widget.studentData!.iD!,
                                                        );
                                                      }
                                                  },
                                                  child: const Icon(Icons.delete,
                                                      color: AppColors.colorRed),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                    }
                  );
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.color446,
        onPressed: () {
          showInvoiceTypeAlert(context, widget.studentData);
        },
        child: const Icon(
          Icons.attach_money,
          color: AppColors.colorWhite,
        ),
      ),
    );
  }
}
