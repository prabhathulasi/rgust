import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/payment_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/payment/payment_alerts/add_new_payment_alert.dart';

import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class StudentPaymentView extends StatefulWidget {
  final StudentDetail? studentData;
  const StudentPaymentView({super.key, required this.studentData});

  @override
  State<StudentPaymentView> createState() => _StudentPaymentViewState();
}

class _StudentPaymentViewState extends State<StudentPaymentView> {
  @override
  Widget build(BuildContext context) {
    var invoiceProvider = Provider.of<InvoiceProvider>(context, listen: false);

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

    return Scaffold(
      body: FutureBuilder(
          future: getInvoiceRecord(invoiceProvider, context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Consumer<InvoiceProvider>(
                  builder: (context, invoiceConsumer, child) {
                return invoiceConsumer
                            .invoiceResponseModel.invoiceData!.isEmpty &&
                        invoiceConsumer.invoiceResponseModel.miscData!.isEmpty
                    ? const Center(
                        child: Text("No Invoice Found"),
                      )
                    : Consumer<PaymentProvider>(
                        builder: (context, paymentConsumer, child) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: AppRichTextView(
                                          title: "Generated Invoices",
                                          fontSize: 20.sp,
                                          textColor: AppColors.colorBlack,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AppRichTextView(
                                        title: "Tution Invoices",
                                        fontSize: 20.sp,
                                        textColor: AppColors.colorBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      ListView.builder(
                                        itemCount: invoiceConsumer
                                            .invoiceResponseModel
                                            .invoiceData!
                                            .length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () async {
                                              invoiceConsumer.setInvoiceIndex(
                                                index,
                                                invoiceConsumer
                                                    .invoiceResponseModel
                                                    .invoiceData![index]
                                                    .iD!,
                                              );

                                              var token =
                                                  await getTokenAndUseIt();
                                              if (token == null) {
                                                if (context.mounted) {
                                                  Navigator.pushNamed(context,
                                                      RouteNames.login);
                                                }
                                              } else if (token ==
                                                  "Token Expired") {
                                                ToastHelper().errorToast(
                                                    "Session Expired Please Login Again");

                                                if (context.mounted) {
                                                  Navigator.pushNamed(context,
                                                      RouteNames.login);
                                                }
                                              } else {
                                                paymentConsumer
                                                    .getPaymentReceipts(
                                                        token,
                                                        invoiceConsumer
                                                            .invoiceResponseModel
                                                            .invoiceData![index]
                                                            .iD!,
                                                        false);
                                              }
                                            },
                                            child: Card(
                                              color: invoiceConsumer
                                                          .selectedInvoiceIndex ==
                                                      index
                                                  ? AppColors.color446
                                                  : AppColors.colorWhite,
                                              elevation: 5.0,
                                              child: ListTile(
                                                
                                                trailing: Icon(
                                                  Icons.chevron_right,
                                                  size: 30.sp,
                                                  color: invoiceConsumer
                                                              .selectedInvoiceIndex ==
                                                          index
                                                      ? AppColors.colorWhite
                                                      : AppColors.color446,
                                                ),
                                                title: AppRichTextView(
                                                    title: invoiceConsumer
                                                        .invoiceResponseModel
                                                        .invoiceData![index]
                                                        .invoiceNumber!,
                                                    fontSize: 17.sp,
                                                    textColor: invoiceConsumer
                                                                .selectedInvoiceIndex ==
                                                            index
                                                        ? AppColors.colorWhite
                                                        : AppColors.color446,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AppRichTextView(
                                                        title: DateFormat(
                                                                'yyyy-MM-dd – kk:mm')
                                                            .format(DateTime.parse(
                                                                invoiceConsumer
                                                                    .invoiceResponseModel
                                                                    .invoiceData![
                                                                        index]
                                                                    .createdAt!)),
                                                        fontSize: 15.sp,
                                                        textColor: invoiceConsumer
                                                                    .selectedInvoiceIndex ==
                                                                index
                                                            ? AppColors
                                                                .colorWhite
                                                            : AppColors
                                                                .color446,
                                                        fontWeight:
                                                            FontWeight.w500),

                                                           AppRichTextView(
                                                        title: "Total Amount: ${invoiceConsumer.invoiceResponseModel.invoiceData![index].amountInUsd}",
                                                        fontSize: 15.sp,
                                                        textColor: invoiceConsumer
                                                                    .selectedInvoiceIndex ==
                                                                index
                                                            ? AppColors
                                                                .colorWhite
                                                            : AppColors
                                                                .color446,
                                                        fontWeight:
                                                            FontWeight.w500),   
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AppRichTextView(
                                        title: "Misc Invoices",
                                        fontSize: 20.sp,
                                        textColor: AppColors.colorBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      ListView.builder(
                                        itemCount: invoiceConsumer
                                            .invoiceResponseModel
                                            .miscData!
                                            .length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () async {
                                              invoiceConsumer.setMiscIndex(
                                                index,
                                                invoiceConsumer
                                                    .invoiceResponseModel
                                                    .miscData![index]
                                                    .iD!,
                                              );
                                              var token =
                                                  await getTokenAndUseIt();
                                              if (token == null) {
                                                if (context.mounted) {
                                                  Navigator.pushNamed(context,
                                                      RouteNames.login);
                                                }
                                              } else if (token ==
                                                  "Token Expired") {
                                                ToastHelper().errorToast(
                                                    "Session Expired Please Login Again");

                                                if (context.mounted) {
                                                  Navigator.pushNamed(context,
                                                      RouteNames.login);
                                                }
                                              } else {
                                                paymentConsumer
                                                    .getPaymentReceipts(
                                                        token,
                                                        invoiceConsumer
                                                            .invoiceResponseModel
                                                            .miscData![index]
                                                            .iD!,
                                                        true);
                                              }
                                            },
                                            child: Card(
                                              color: invoiceConsumer
                                                          .selectedMiscIndex ==
                                                      index
                                                  ? AppColors.color446
                                                  : AppColors.colorWhite,
                                              elevation: 5.0,
                                              child: ListTile(
                                                trailing: Icon(
                                                  Icons.chevron_right,
                                                  size: 30.sp,
                                                  color: invoiceConsumer
                                                              .selectedMiscIndex ==
                                                          index
                                                      ? AppColors.colorWhite
                                                      : AppColors.color446,
                                                ),
                                                title: AppRichTextView(
                                                    title: invoiceProvider
                                                        .invoiceResponseModel
                                                        .miscData![index]
                                                        .invoiceNumber!,
                                                    fontSize: 17.sp,
                                                    textColor: invoiceConsumer
                                                                .selectedMiscIndex ==
                                                            index
                                                        ? AppColors.colorWhite
                                                        : AppColors.color446,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AppRichTextView(
                                                        title: DateFormat(
                                                                'yyyy-MM-dd – kk:mm')
                                                            .format(DateTime.parse(
                                                                invoiceProvider
                                                                    .invoiceResponseModel
                                                                    .miscData![
                                                                        index]
                                                                    .createdAt!)),
                                                        fontSize: 15.sp,
                                                        textColor: invoiceConsumer
                                                                    .selectedMiscIndex ==
                                                                index
                                                            ? AppColors
                                                                .colorWhite
                                                            : AppColors
                                                                .color446,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const VerticalDivider(
                              color: AppColors.color446,
                              width: 1,
                            ),
                            Expanded(
                              flex: 2,
                              child:
                                  invoiceConsumer.selectedMiscIndex == null &&
                                          invoiceConsumer
                                                  .selectedInvoiceIndex ==
                                              null
                                      ? Center(
                                          child: AppRichTextView(
                                            title:
                                                "Please Select An Invoice To View  Payment Records",
                                            fontSize: 20.sp,
                                            textColor: AppColors.colorBlack,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : paymentConsumer.isLoading == true
                                          ? const Center(
                                              child: SpinKitSpinningLines(
                                                  color: AppColors.color446),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        AppRichTextView(
                                                          title:
                                                              "Payment Records",
                                                          fontSize: 20.sp,
                                                          textColor: AppColors
                                                              .colorBlack,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            if (invoiceConsumer
                                                                    .selectedInvoiceIndex ==
                                                                null) {
                                                              showAddPaymentDialog(
                                                                  context,
                                                                  widget
                                                                      .studentData,
                                                                  isMisc: true);
                                                            } else {
                                                              showAddPaymentDialog(
                                                                  context,
                                                                  widget
                                                                      .studentData,
                                                                  isMisc:
                                                                      false);
                                                            }
                                                          },
                                                          child: Icon(
                                                              Icons
                                                                  .add_circle_outline,
                                                              size: 30.sp,
                                                              color: AppColors
                                                                  .color446),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    paymentConsumer
                                                            .paymentReceiptModel
                                                            .paymentdata == null
                                                        ? Center(
                                                            child:
                                                                AppRichTextView(
                                                              title:
                                                                  "No Payment Records",
                                                              fontSize: 20.sp,
                                                              textColor:
                                                                  AppColors
                                                                      .colorRed,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          )
                                                        : Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    DataTable(
                                                                  border:
                                                                      TableBorder
                                                                          .all(),
                                                                  headingRowColor:
                                                                      WidgetStateProperty.all(
                                                                          AppColors
                                                                              .color446),
                                                                  columnSpacing:
                                                                      16.0,
                                                                  headingTextStyle:
                                                                      TextStyle(
                                                                    color: AppColors
                                                                        .colorWhite,
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  columns: const [
                                                                    DataColumn(
                                                                        label: Text(
                                                                            'Date')),
                                                                    DataColumn(
                                                                        label: Text(
                                                                            'Invoice Amount')),
                                                                    DataColumn(
                                                                        label: Text(
                                                                            'Paid Amount')),
                                                                    DataColumn(
                                                                        label: Text(
                                                                            'Action')),
                                                                  ],
                                                                  rows: paymentConsumer
                                                                      .paymentReceiptModel
                                                                      .paymentdata!
                                                                      .map(
                                                                        (payment) =>
                                                                            DataRow(
                                                                          cells: [
                                                                            DataCell(Text(DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(payment.createdAt!)))),
                                                                            DataCell(Text(paymentConsumer.paymentReceiptModel.totalAmount.toString())),
                                                                            DataCell(Text('${payment.amountInUsd}')),
                                                                            DataCell(
                                                                              ElevatedButton(
                                                                                onPressed: () {},
                                                                                child: const Text("view"),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                      .toList(),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: SfRadialGauge(
                                                                    animationDuration: 2000,
                                                                    enableLoadingAnimation: true,
                                                                      axes: <RadialAxis>[
                                                                        RadialAxis(
                                                                            minimum:
                                                                                0,
                                                                            maximum:
                                                                                double.parse(paymentConsumer.paymentReceiptModel.totalAmount!.toString()), // Make sure this matches your "total"
                                                                            ranges: <GaugeRange>[
                                                                              GaugeRange(startValue: 0, endValue: (paymentConsumer.paymentReceiptModel.totalAmount! * 0.6), color: Colors.red),
                                                                              GaugeRange(startValue: (paymentConsumer.paymentReceiptModel.totalAmount! * 0.6), endValue: (paymentConsumer.paymentReceiptModel.totalAmount! * 0.9), color: Colors.orange),
                                                                              GaugeRange(startValue: (paymentConsumer.paymentReceiptModel.totalAmount! * 0.9), endValue: double.parse(paymentConsumer.paymentReceiptModel.totalAmount!.toString()), color: Colors.green)
                                                                            ],
                                                                            pointers:  <GaugePointer>[
                                                                              NeedlePointer(value: double.parse((paymentConsumer.paymentReceiptModel.paymentdata!.fold(0, (sum, item) => sum + item.amountInUsd!).clamp(0,paymentConsumer.paymentReceiptModel.totalAmount!).toString() ))),
                                                                            ],
                                                                            annotations:  <GaugeAnnotation>[
                                                                              GaugeAnnotation(widget: Text((paymentConsumer.paymentReceiptModel.paymentdata!.fold(0, (sum, item) => sum + item.amountInUsd!).toString()) , style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)), angle: 90, positionFactor: 0.5)
                                                                            ])
                                                                      ]))
                                                            ],
                                                          )
                                                  ],
                                                ),
                                              ),
                                            ),
                            )
                          ],
                        );
                      });
              });
            }
          }),
    );
  }
}
