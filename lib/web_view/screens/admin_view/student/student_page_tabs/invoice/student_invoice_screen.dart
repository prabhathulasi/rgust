import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/invoice/alerts/fee_type_alert.dart';


class Studentinvoicescreen extends StatefulWidget {
    final StudentDetail? studentData;

  const Studentinvoicescreen({super.key,required this.studentData});

  @override
  State<Studentinvoicescreen> createState() => _StudentinvoicescreenState();
}

class _StudentinvoicescreenState extends State<Studentinvoicescreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      body: const Center(
        child: Text("Student Invoice Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.color446,
        onPressed: () {
       showInvoiceTypeAlert(context, widget.studentData);
        },
        child: const Icon(Icons.attach_money,color: AppColors.colorWhite,),
      ),
    );
  }
}