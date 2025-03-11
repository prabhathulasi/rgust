/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rugst_alliance_academia/data/model/exam_result_model.dart'
    as prefix;
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';



Future<Uint8List> generateInvoice(PdfPageFormat pageFormat,
    StudentDetail studentData, List<prefix.Result> resultData) async {
  final invoice = Invoice(
    baseColor: PdfColors.teal,
    accentColor: PdfColors.blueGrey900,
  );

  return await invoice.buildPdf(pageFormat, studentData, resultData);
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

  PdfColor get _accentTextColor => baseColor.isLight ? _lightColor : _darkColor;

  pw.Image? image1;
  pw.MemoryImage? image;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat,
      StudentDetail studentDetail, List<prefix.Result> data) async {
    // Create a PDF document.
    final doc = pw.Document();

    // _logo = await rootBundle.loadString('assets/logo.svg');
    // _bgShape = await rootBundle.loadString('assets/invoice.svg');
    final img = await rootBundle.load('assets/rgust.png');
    final imageBytes = img.buffer.asUint8List();
    image1 = pw.Image(pw.MemoryImage(imageBytes));

    var decodedImage = base64Decode(studentDetail.userImage!);

    Uint8List imageData = decodedImage;
    // Embedding the image into the PDF
    image = pw.MemoryImage(
      imageData,
    );
    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          PdfPageFormat.a4.copyWith(
            width: PdfPageFormat.a4.height,
            height: PdfPageFormat.a4.width,
          ),
          await PdfGoogleFonts.robotoRegular(),
          await PdfGoogleFonts.robotoBold(),
          await PdfGoogleFonts.robotoItalic(),
        ),
        header: (context){
          return _buildHeader(context, studentDetail);
        },
    
        footer: _buildFooter,
        build: (context) => [
          pw.Center(
            child: _contentHeader(context, studentDetail),
          ),
          pw.SizedBox(height: 10),
          _contentTable(context, data, studentDetail.studentId!),

          // _contentFooter(context),
          // _termsAndConditions(context),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context,StudentDetail studentDetail) {
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
    return pw.Column(children: [
      pw.Text("Student's Personal File".toUpperCase(),
          style: pw.TextStyle(
              color: PdfColor.fromHex("#000000"),
              fontWeight: pw.FontWeight.bold,
              fontSize: 15)),
      pw.SizedBox(
        height: 15,
      ),
      pw.Text("Personal Information".toUpperCase(),
          style: pw.TextStyle(
              color: PdfColor.fromHex("#000000"),
              fontWeight: pw.FontWeight.bold,
              fontSize: 12)),
      pw.SizedBox(
        height: 15,
      ),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Column(children: [
          pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.SizedBox(
              width: 400,
              child: pw.Row(
                children: [
                  pw.Text("Student's Name :",
                      style: pw.TextStyle(
                          color: PdfColor.fromHex("#000000"),
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold)),
                  pw.Text(
                      " ${studentDetail.firstName!} ${studentDetail.lastName!}",
                      style: pw.TextStyle(
                          color: PdfColor.fromHex("#000000"), fontSize: 13))
                ],
              ),
            ),
          ),
          pw.SizedBox(
            height: 10,
          ),
                 pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.SizedBox(
              width: 400,
              child: pw.Row(
                children: [
                  pw.Text("Student Reg :",
                      style: pw.TextStyle(
                          color: PdfColor.fromHex("#000000"),
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold)),
                  pw.Text(
                      " ${studentDetail.studentId!}",
                      style: pw.TextStyle(
                          color: PdfColor.fromHex("#000000"), fontSize: 13))
                ],
              ),
            ),
          ),
          pw.SizedBox(
            height: 10,
          ),
          pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.SizedBox(
              width: 400,
              child: pw.Row(
                children: [
                  pw.Text("Date of Birth :",
                      style: pw.TextStyle(
                          color: PdfColor.fromHex("#000000"),
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold)),
                  pw.Text("${studentDetail.dOB}",
                      style: pw.TextStyle(
                          color: PdfColor.fromHex("#000000"), fontSize: 13))
                ],
              ),
            ),
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.SizedBox(
              width: 400,
              child: pw.Row(
                children: [
                  pw.Text("Date of Admission :",
                      style: pw.TextStyle(
                          color: PdfColor.fromHex("#000000"),
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold)),
                  pw.Text("${studentDetail.admissionDate}",
                      style: pw.TextStyle(
                          color: PdfColor.fromHex("#000000"), fontSize: 13))
                ],
              ),
            ),
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.SizedBox(
              width: 400,
              child: pw.Row(
                children: [
                  pw.Text("Program :",
                      style: pw.TextStyle(
                          color: PdfColor.fromHex("#000000"),
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold)),
                  pw.Text("${studentDetail.currentProgramName}",
                      style: pw.TextStyle(
                          color: PdfColor.fromHex("#000000"), fontSize: 13))
                ],
              ),
            ),
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.SizedBox(
              width: 400,
              child: pw.Row(
                children: [
                  pw.Text("Class :",
                      style: pw.TextStyle(
                          color: PdfColor.fromHex("#000000"),
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold)),
                  pw.Text("${studentDetail.currentClassName}",
                      style: pw.TextStyle(
                          color: PdfColor.fromHex("#000000"), fontSize: 13))
                ],
              ),
            ),
          ),
        ]),
        pw.Container(
            height: 100,
            width: 100,
            decoration: pw.BoxDecoration(
                border: pw.Border.all(),
                image: pw.DecorationImage(image: image!, fit: pw.BoxFit.cover)))
      ]),
    ]);
  }

  List<String> _getCategories(List<prefix.Result>? data) {
    return data!.map((item) => item.className!).toSet().toList();
  }

  List<prefix.Result> _getItemsForCategory(
      String category, List<prefix.Result>? data) {
    return data!
        .where((item) => item.className! == category && item.isRepeat != true)
        .toList();
  }

  pw.Widget _contentTable(pw.Context context, List<prefix.Result> data, String studentId) {
    const tableHeaders = [
      "Course Name",
      "Course Code",
      "Credit",
      "CW1",
      "CW2",
      "CW3",
      "CW4",
      "Final mark",
      "Grade",
    ];
    return pw.ListView.builder(
      itemCount: _getCategories(data).length,
      itemBuilder: (context, index) {
        final category = _getCategories(data)[index];
        final categoryItems = _getItemsForCategory(category, data);
        return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
pw.Center(
  child:  pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text(
              category,
              style: pw.TextStyle(
                fontSize: 15,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
),
         
          pw.Text(
              "Batch: ${categoryItems[0].batch!}",
              style: pw.TextStyle(
                fontSize: 13,
                fontWeight: pw.FontWeight.normal,
              ),
            ),
           pw.Text(
              "Registration No: $studentId",
              style: pw.TextStyle(
                fontSize: 13,
                fontWeight: pw.FontWeight.normal,
              ),
            ),
         
          
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
            headers: List<String>.generate(
              tableHeaders.length,
              (col) => tableHeaders[col],
            ),
            data: List<List<dynamic>>.generate(
                categoryItems.length,
                (row) => [
                      pw.Text(categoryItems[row].courseName!),
                      pw.Text(categoryItems[row].courseCode!),
                      pw.Text(categoryItems[row].courseCredits!.toString()),
                      pw.Text(categoryItems[row].cw1.toString()),
                      pw.Text(categoryItems[row].cw2.toString()),
                      pw.Text(categoryItems[row].cw3.toString()),
                      pw.Text(categoryItems[row].cw4.toString()),
                      pw.Text(categoryItems[row].finalMark.toString()),
                      pw.Text(categoryItems[row].grade!),
                    ]),
          ),
        ]);
      },
    );
  }
}
