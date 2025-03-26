import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rugst_alliance_academia/data/model/invoice/invoice_model.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';

Future<Uint8List> generateNewInvoice(PdfPageFormat pageFormat,
    StudentDetail? studentData, List<InvoiceModel> invoiceData) async {
  final invoice = Invoice(
    baseColor: PdfColors.teal,
    accentColor: PdfColors.blueGrey900,
  );

  return await invoice.buildPdf(pageFormat, studentData, invoiceData);
}

class Invoice {
  Invoice({
    required this.baseColor,
    required this.accentColor,
  });

  final PdfColor baseColor;
  final PdfColor accentColor;
  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;
  PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;
  pw.Image? image1;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat,
      StudentDetail? studentData, List<InvoiceModel> invoiceData) async {
    // Create a PDF document.
    final doc = pw.Document();

    final img = await rootBundle.load('assets/rgust.png');
    final imageBytes = img.buffer.asUint8List();
    image1 = pw.Image(pw.MemoryImage(imageBytes));

    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          PdfPageFormat.a4.copyWith(
            width: PdfPageFormat.a4.width,
            height: PdfPageFormat.a4.height,
          ),
          await PdfGoogleFonts.robotoRegular(),
          await PdfGoogleFonts.robotoBold(),
          await PdfGoogleFonts.robotoItalic(),
        ),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          pw.Align(
              alignment: pw.Alignment.topRight,
              child: pw.Text("Receipt No:Rgust/${DateFormat("yyyy/MMM").format(DateTime.now())}/${Random().nextInt(10000) + 1}",
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(
                    color: PdfColor.fromHex("#000000"),
                    fontSize: 10.sp,
                  ))),
          pw.Align(
              alignment: pw.Alignment.topRight,
              child: pw.Text("Receipt Date: ${DateFormat(
                                                      'yyyy-MM-dd – kk:mm')
                                                  .format(DateTime.now())
                                                  .toString()}",
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(
                    color: PdfColor.fromHex("#000000"),
                    fontSize: 10.sp,
                  ))),
          pw.SizedBox(height: 10.h),
          pw.Center(
              child: pw.Text("Department of Finance",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 15.sp))),
          pw.SizedBox(height: 10.h),
          pw.Center(
            child: pw.Text("Student Invoice",
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, fontSize: 13.sp)),
          ),
          _contentHeader(context, studentData!),
          pw.SizedBox(height: 20.h),
          pw.TableHelper.fromTextArray(
              border: pw.TableBorder.all(),
              cellAlignment: pw.Alignment.centerLeft,
              headerDecoration: pw.BoxDecoration(
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
                color: baseColor,
              ),
              headerHeight: 25,
              cellHeight: 40,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
                2: pw.Alignment.centerLeft,
                3: pw.Alignment.centerLeft,
                4: pw.Alignment.centerLeft,
              },
              headerStyle: pw.TextStyle(
                color: _baseTextColor,
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
              ),
              cellStyle: const pw.TextStyle(
                color: _darkColor,
                fontSize: 10,
              ),
              rowDecoration: pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(
                    color: accentColor,
                    width: .5,
                  ),
                ),
              ),
              headers: [
                "Details",
                "Scholarship Amount\n(USD)",
                "Total Amount (USD)",
              ],
              data: invoiceData
                  .map((e) => [
                        e.description,
                        e.scholarshipAmount.toString(),
                        e.usd.toString(),
                      ])
                  .toList()),
          pw.SizedBox(height: 10.h),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text("Total Amount: ",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 12.sp)),
              pw.SizedBox(width: 5.w),
              pw.Text(
                  invoiceData.fold(0, (sum, item) => sum + item.usd).toString(),
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.normal, fontSize: 12.sp)),
            ],
          ),
         pw.Row(
           mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text("Scholarship Amount: ",
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, fontSize: 12.sp)),
            pw.SizedBox(width: 5.w),
            pw.Text(invoiceData[0].scholarshipAmount.toString(),
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.normal, fontSize: 12.sp)),
          ],
         ),
         pw.Row(
           mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text("Payable Amount: ",
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, fontSize: 12.sp)),
            pw.SizedBox(width: 5.w),
            pw.Text(
                (invoiceData.fold(0, (sum, item) => sum + item.usd) -
                        invoiceData[0].scholarshipAmount)
                    .toString(),
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.normal, fontSize: 12.sp)),
          ]
         ),
         
          pw.SizedBox(height: 5.h),
          pw.Align(
            alignment: pw.Alignment.topRight,
            child: pw.Text(
                "RGUST has a fixed exchange rate of GYD218 to USD1.00",
                style: pw.TextStyle(fontSize: 10.sp)),
          ),
          pw.SizedBox(height: 10.h),
          pw.Text("Important:",
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 11.sp,
                  decoration: pw.TextDecoration.underline)),
          pw.SizedBox(height: 10.h),
          pw.Text(
              "1. This digital invoice is provided for record-keeping purposes only and is not intended to serve as an official or legal document.",
              style: pw.TextStyle(fontSize: 10.sp)),
          pw.Text(
              "2. Submit a hard copy of you deposit slip to the Administrative Office for record keeping.",
              style: pw.TextStyle(fontSize: 10.sp)),
          pw.Text(
              "3. This invoice reflects the annual tuition breakdown under the university's partial scholarship program.",
              style: pw.TextStyle(fontSize: 10.sp)),
          pw.Text(
              "4. Students can download the digital invoice for their payment from the student app once the finance department has confirmed the payment.",
              style: pw.TextStyle(fontSize: 10.sp)),
          pw.SizedBox(height: 10.h),
          pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text("Important: ",
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 11.sp,
                    decoration: pw.TextDecoration.underline)),
            pw.Text(
                "RGUST reserves the right to the change its tuition and fee structure per circumstances and needs under the\nrecommendation of its Board.",
                style: pw.TextStyle(
                  fontStyle: pw.FontStyle.italic,
                  fontSize: 9.sp,
                )),
          ]),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Row(children: [
      pw.Container(
        alignment: pw.Alignment.center,
        height: 100,
        width: 100,
        child: image1,
      ),
      pw.SizedBox(width: 10),
      pw.Expanded(
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
            pw.Text("Rajiv Gandhi University of Science and Technology",
                style: pw.TextStyle(
                    color: PdfColor.fromHex("#800020"),
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 15)),
            pw.Text("A Brand for Quality Education",
                style: pw.TextStyle(
                    color: PdfColor.fromHex("#808080"),
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 13)),
          ]))
    ]);
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Column(children: [
      pw.Divider(),
      pw.Text(
          "Third Street, Cummingslodge, Greater Georgetown, Guyana South America.",
          style: pw.TextStyle(
              color: PdfColor.fromHex("#4169e1"),
              fontSize: 10,
              fontWeight: pw.FontWeight.bold)),
      pw.Text("Telephone#: +(592) 222-6080",
          style: pw.TextStyle(
              color: PdfColor.fromHex("#4169e1"),
              fontSize: 10,
              fontWeight: pw.FontWeight.bold)),
      pw.Text("Website: www.rgust.edu.gy",
          style: pw.TextStyle(
              color: PdfColor.fromHex("#4169e1"),
              fontSize: 10,
              fontWeight: pw.FontWeight.bold)),
    ]);
  }

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        // child: pw.SvgImage(svg: _bgShape!),
      ),
    );
  }

  pw.Widget _contentHeader(pw.Context context, StudentDetail studentDetail) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            height: 10.h,
          ),
          pw.Text("To",
              textAlign: pw.TextAlign.right,
              style: pw.TextStyle(
                  color: PdfColor.fromHex("#000000"),
                  fontSize: 13.sp,
                  fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10.h),
          pw.Text("${studentDetail.firstName!} ${studentDetail.lastName!}",
              style: pw.TextStyle(
                  color: PdfColor.fromHex("#000000"), fontSize: 10.sp)),
          pw.SizedBox(
            height: 5.h,
          ),
          pw.Text("${studentDetail.studentId}",
              style: pw.TextStyle(
                  color: PdfColor.fromHex("#000000"), fontSize: 10.sp)),
          pw.SizedBox(
            height: 5.h,
          ),
          pw.Text("${studentDetail.currentProgramName}",
              style: pw.TextStyle(
                  color: PdfColor.fromHex("#000000"), fontSize: 10.sp)),
          pw.SizedBox(
            height: 5.h,
          ),
          pw.Text("${studentDetail.email}",
              style: pw.TextStyle(
                  color: PdfColor.fromHex("#000000"), fontSize: 10.sp)),
          pw.SizedBox(
            height: 5.h,
          ),
          pw.Text("${studentDetail.address}",
              style: pw.TextStyle(
                  color: PdfColor.fromHex("#000000"), fontSize: 10.sp)),
        ]);
  }
}
