import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/payment/payment_alerts/add_new_invoice_alert.dart';

import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class StudentPaymentView extends StatelessWidget {
  final StudentDetail? studentData;
  const StudentPaymentView({super.key, required this.studentData});

  @override
  Widget build(BuildContext context) {
;

  final List<Map<String, dynamic>> dummyInvoices = [
    {
      'date': '2025-03-01',
      'invoiceAmount': 100.00,
      'paidAmount': 50.00,
      'payableAmount': 50.00,
      'action': 'View'
    },
    {
      'date': '2025-03-02',
      'invoiceAmount': 200.00,
      'paidAmount': 150.00,
      'payableAmount': 50.00,
      'action': 'View'
    },
    {
      'date': '2025-03-03',
      'invoiceAmount': 300.00,
      'paidAmount': 300.00,
      'payableAmount': 0.00,
      'action': 'View'
    },
  ];

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppRichTextView(
                      title: "Raised Invoices",
                      fontSize: 20.sp,
                      textColor: AppColors.colorBlack,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          color:index == 0? AppColors.color446: AppColors.colorWhite,
                          elevation: 5.0,
                          child: ListTile(
                            trailing: Icon(Icons.chevron_right,size: 30.sp,color:index ==0 ? AppColors.colorWhite: AppColors.color446,),
                            title: AppRichTextView(
                                title:
                                    "Rgust/${DateFormat("yyyy/MMM").format(DateTime.now())}/11",
                                fontSize: 17.sp,
                                textColor:index == 0?AppColors.colorWhite: AppColors.color446,
                                fontWeight: FontWeight.bold),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppRichTextView(
                                    title: DateFormat('yyyy-MM-dd – kk:mm')
                                        .format(DateTime.now())
                                        .toString(),
                                    fontSize: 15.sp,
                                    textColor:index == 0?AppColors.colorWhite: AppColors.color446,
                                    fontWeight: FontWeight.w500),
                                AppRichTextView(
                                    textColor: index == 0?AppColors.colorWhite: AppColors.color446,
                                    title: "Pre-Medicine",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ],
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
            color: AppColors.colorWhite,
            width: 1,
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   AppRichTextView(
                      title: "Payment Records",
                      fontSize: 20.sp,
                      textColor: AppColors.colorBlack,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
              DataTable(
             border: TableBorder.all(),
            headingRowColor: WidgetStateProperty.all(AppColors.color446),
                columnSpacing: 16.0,
                headingTextStyle: TextStyle(
                  color: AppColors.colorWhite,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                columns: const [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Invoice Amount')),
                  DataColumn(label: Text('Paid Amount')),
                  DataColumn(label: Text('Payable Amount')),
                  DataColumn(label: Text('Action')),
                ],
                rows: dummyInvoices
                    .map(
                      (invoice) => DataRow(
                        cells: [
                          DataCell(Text(invoice['date'])),
                          DataCell(Text('${invoice['invoiceAmount']}')),
                          DataCell(Text('${invoice['paidAmount']}')),
                          DataCell(Text('${invoice['payableAmount']}')),
                          DataCell(
              ElevatedButton(
                onPressed: () {
                  // // Define action (e.g., navigate or show more details)
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text('View action for ${invoice['date']}')),
                  // );
                },
                child: Text(invoice['action']),
              ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: studentData!.studentFees!.isEmpty
          ? Container()
          : FloatingActionButton(
              backgroundColor: AppColors.colorc7e,
              child: const Icon(
                Icons.file_upload,
                color: AppColors.colorWhite,
              ),
              onPressed: () async {
                showAddInvoiceDialog(context, studentData);
              },
            ),
    );
  }
}
