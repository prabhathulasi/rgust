import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rugst_alliance_academia/data/model/exam_result_model.dart'
    as prefix;
import 'package:rugst_alliance_academia/data/model/student_detail_model.dart';
import 'package:rugst_alliance_academia/web_view/screens/pdf_generate/testing.dart';

class StudentResultSummary extends StatefulWidget {
  final List<prefix.Result>? result;
  final StudentDetail? studentData;
  const StudentResultSummary({super.key, this.result, this.studentData});

  @override
  State<StudentResultSummary> createState() => _StudentPersonalProfileState();
}

class _StudentPersonalProfileState extends State<StudentResultSummary> {
  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(
        pageMode: PdfPageMode.outlines,
        version: PdfVersion.pdf_1_5,
        compress: true);

    final img = await rootBundle.load('assets/rgust.png');
    final imageBytes = img.buffer.asUint8List();
    pw.Image image1 = pw.Image(pw.MemoryImage(imageBytes));
    final fontData = await rootBundle.load('fonts/Helvetica-Bold-Font.ttf');
    final pw.Font primaryFont = pw.Font.ttf(fontData.buffer.asByteData());

    var decodedImage = base64Decode(widget.studentData!.userImage!);

    Uint8List imageData = decodedImage;
    // Embedding the image into the PDF
    pw.MemoryImage image = pw.MemoryImage(
      imageData,
    );

    var data = widget.result;

    pdf.addPage(
      pw.MultiPage(
          // header: _buildHeader(),
          pageFormat: PdfPageFormat.a4.copyWith(
            width: PdfPageFormat.a4.height,
            height: PdfPageFormat.a4.width,
          ),
          build: (context) => [
                pw.Stack(children: [
                  pw.Center(
                    child: pw.Container(
                      child: pw.Transform.rotate(
                        angle: -0.5,
                        child: pw.Text(
                          'Watermark Text',
                          style: pw.TextStyle(
                            font: primaryFont,
                            color: PdfColor.fromHex(
                                "#CCCCCC"), // Set watermark color
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                  pw.Column(children: [
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.ListView.builder(
                      itemCount: _getCategories(data!).length,
                      itemBuilder: (context, index) {
                        final category = _getCategories(data)[index];
                        // final categoryItems = _getItemsForCategory(category, data);
                        return pw.Column(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(
                              category,
                              style: pw.TextStyle(
                                fontSize: 18,
                                fontWeight: pw.FontWeight.bold,
                                font: primaryFont,
                              ),
                            ),
                          ),
                          pw.Table(children: [
                            pw.TableRow(children: [
                              pw.Text("Course Name",
                                  style: pw.TextStyle(
                                    font: primaryFont,
                                  )),
                              pw.Text("Course Code",
                                  style: pw.TextStyle(
                                    font: primaryFont,
                                  )),
                              pw.Text("Batch",
                                  style: pw.TextStyle(
                                    font: primaryFont,
                                  )),
                              pw.Text("CW1",
                                  style: pw.TextStyle(
                                    font: primaryFont,
                                  )),
                              pw.Text("CW2",
                                  style: pw.TextStyle(
                                    font: primaryFont,
                                  )),
                              pw.Text("CW3",
                                  style: pw.TextStyle(
                                    font: primaryFont,
                                  )),
                              pw.Text("CW4",
                                  style: pw.TextStyle(
                                    font: primaryFont,
                                  )),
                              pw.Text("Final mark",
                                  style: pw.TextStyle(
                                    font: primaryFont,
                                  )),
                              pw.Text("Grade",
                                  style: pw.TextStyle(
                                    font: primaryFont,
                                  ))
                            ])
                          ])
                        ]);
                      },
                    ),
                  ]),
                ])
              ]),
    );
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
                      font: primaryFont,
                      color: PdfColor.fromHex("#800020"),
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 20)),
              pw.Text("A Brand for Quality Education",
                  style: pw.TextStyle(
                      font: primaryFont,
                      color: PdfColor.fromHex("#808080"),
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 15)),
            ]))
      ]);
    }

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        build: (format) => generateInvoice(
            format,
            const CustomData(name: "Computer Generated PDF"),
            widget.studentData!,
            widget.result!),
      ),
    );
  }

  List<String> _getCategories(List<prefix.Result>? data) {
    return data!.map((item) => item.className!).toSet().toList();
  }

  List<prefix.Result> _getItemsForCategory(
      String category, List<prefix.Result>? data) {
    return data!.where((item) => item.className! == category).toList();
  }
}
