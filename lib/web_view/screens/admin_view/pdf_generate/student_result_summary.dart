import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rugst_alliance_academia/data/model/exam_result_model.dart'
    as prefix;
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';

import 'package:rugst_alliance_academia/web_view/screens/admin_view/pdf_generate/testing.dart';

class StudentResultSummary extends StatefulWidget {
  final List<prefix.Result>? result;
  final StudentDetail? studentData;
  const StudentResultSummary({super.key, this.result, this.studentData});

  @override
  State<StudentResultSummary> createState() => _StudentPersonalProfileState();
}

class _StudentPersonalProfileState extends State<StudentResultSummary> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        build: (format) => generateInvoice(
            format,
            widget.studentData!,
            widget.result!),
      ),
    );
  }

 
}
