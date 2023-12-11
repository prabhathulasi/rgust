
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;
import 'package:rugst_alliance_academia/data/model/media_file_model.dart';
import 'package:rugst_alliance_academia/data/model/student_detail_model.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class StudentPersonalProfile extends StatefulWidget {
  final List<Files>? files;
  final StudentDetail? studentData;
  const StudentPersonalProfile({super.key, this.files, this.studentData});

  @override
  State<StudentPersonalProfile> createState() => _StudentPersonalProfileState();
}

class _StudentPersonalProfileState extends State<StudentPersonalProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  ImagePath.webrgustLogo,
                  width: 120.w,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: AppRichTextView(
                      maxLines: 2,
                      title:
                          "Rajiv Gandhi University of Science and Technology",
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            AppRichTextView(
                maxLines: 2,
                title: "Student's Personal File".toUpperCase(),
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
            SizedBox(
              height: 10.h,
            ),
            AppRichTextView(
                maxLines: 2,
                title: "Personal Information".toUpperCase(),
                fontSize: 15.sp,
                fontWeight: FontWeight.bold),
            SizedBox(
              height: 30.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 400.w,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppRichTextView(
                          title: "Student's Name:",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      flex: 2,
                      child: AppRichTextView(
                          title: widget.studentData!.firstName! +
                              widget.studentData!.lastName!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 400.w,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppRichTextView(
                          title: "Date of Birth:",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      flex: 2,
                      child: AppRichTextView(
                          title: widget.studentData!.dOB!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 400.w,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppRichTextView(
                          title: "Date of Admission:",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      flex: 2,
                      child: AppRichTextView(
                          title: widget.studentData!.admissionDate!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 400.w,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppRichTextView(
                          title: "Program",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      flex: 2,
                      child: AppRichTextView(
                          title: widget.studentData!.currentProgramName!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 400.w,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppRichTextView(
                          title: "Class",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      flex: 2,
                      child: AppRichTextView(
                          title: widget.studentData!.currentClassName!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            AppRichTextView(
                maxLines: 2,
                title: "Submitted Documents".toUpperCase(),
                fontSize: 15.sp,
                fontWeight: FontWeight.bold),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.files!.length,
                itemBuilder: (context, index) {
                  var data = widget.files![index];
                  return Card(
                    child: ListTile(
                      title: AppRichTextView(
                          title: data.name!,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.colorBlack),
                      trailing: const Icon(
                        Icons.check_circle_outline,
                        color: AppColors.colorGreen,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.picture_as_pdf),
        onPressed: () async {
          final img = await rootBundle.load('assets/rgust.png');
          final imageBytes = img.buffer.asUint8List();
          pw.Image image1 = pw.Image(pw.MemoryImage(imageBytes));
          final fontData =
              await rootBundle.load('fonts/Helvetica-Bold-Font.ttf');
          final pw.Font primaryFont = pw.Font.ttf(fontData.buffer.asByteData());
          
     
          final pdf = pw.Document();

          pdf.addPage(
            pw.Page(
              build: (pw.Context context) => 
              
              pw.Stack(
                children: [
                   pw.Center(
          child: pw.Container(
            child: pw.Transform.rotate(
              angle: -0.5,
              child: pw.Text(
                'Watermark Text',
                style: pw.TextStyle(
                  font: primaryFont,
                  color: PdfColor.fromHex("#CCCCCC"), // Set watermark color
                  fontSize: 50,
                ),
              ),
            ),
          ),
        ),
   pw.Column(children: [
                pw.Row(children: [
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
                        pw.Text(
                            "Rajiv Gandhi University of Science and Technology",
                            style: pw.TextStyle(
                                font: primaryFont,
                                color: PdfColor.fromHex("#800020"),
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 15)),
                        pw.Text("A Brand for Quality Education",
                            style: pw.TextStyle(
                                font: primaryFont,
                                color: PdfColor.fromHex("#808080"),
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 10)),
                      ]))
                ]),
                pw.Text("Student's Personal File".toUpperCase(),
                    style: pw.TextStyle(
                        font: primaryFont,
                        color: PdfColor.fromHex("#000000"),
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 15)),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Text("Personal Information".toUpperCase(),
                    style: pw.TextStyle(
                        font: primaryFont,
                        color: PdfColor.fromHex("#000000"),
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12)),
                pw.SizedBox(
                  height: 15,
                ),
             
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.SizedBox(
                    width: 400,
                    child: pw.Row(
                      children: [
                        pw.Text("Student's Name :",
                            style: pw.TextStyle(
                                font: primaryFont,
                                color: PdfColor.fromHex("#000000"),
                                fontSize: 13,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text(
                            " ${widget.studentData!.firstName!} ${widget.studentData!.lastName!}",
                            style: pw.TextStyle(
                                font: primaryFont,
                                color: PdfColor.fromHex("#000000"),
                                fontSize: 13))
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
                                font: primaryFont,
                                color: PdfColor.fromHex("#000000"),
                                fontSize: 13,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text("${widget.studentData!.dOB}",
                            style: pw.TextStyle(
                                font: primaryFont,
                                color: PdfColor.fromHex("#000000"),
                                fontSize: 13))
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
                                font: primaryFont,
                                color: PdfColor.fromHex("#000000"),
                                fontSize: 13,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text("${widget.studentData!.admissionDate}",
                            style: pw.TextStyle(
                                font: primaryFont,
                                color: PdfColor.fromHex("#000000"),
                                fontSize: 13))
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
                                font: primaryFont,
                                color: PdfColor.fromHex("#000000"),
                                fontSize: 13,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text("${widget.studentData!.currentProgramName}",
                            style: pw.TextStyle(
                                font: primaryFont,
                                color: PdfColor.fromHex("#000000"),
                                fontSize: 13))
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
                                font: primaryFont,
                                color: PdfColor.fromHex("#000000"),
                                fontSize: 13,
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text("${widget.studentData!.currentClassName}",
                            style: pw.TextStyle(
                                font: primaryFont,
                                color: PdfColor.fromHex("#000000"),
                                fontSize: 13))
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.Text("Submitted Documents".toUpperCase(),
                    style: pw.TextStyle(
                        font: primaryFont,
                        color: PdfColor.fromHex("#000000"),
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 15)),
                pw.Expanded(
                    child: pw.ListView.builder(
                  itemCount: widget.files!.length,
                  itemBuilder: (context, index) {
                    var data = widget.files![index];
                    return
                    
                    pw.Align(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child:pw.Text("${index +1}. ${data.name}",
                        style: pw.TextStyle(
                            font: primaryFont,
                            color: PdfColor.fromHex("#000000"),
                            fontSize: 13))));
                  },
                )),
                pw.Divider(),
                  pw.Text("Third Street, Cummingslodge, Greater Georgetown, Guyana South America.",
                            style: pw.TextStyle(
                                font: primaryFont,
                                color: PdfColor.fromHex("#4169e1"),
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold)),
                                 pw.Text("Telephone#: +(592) 222-6080",
                            style: pw.TextStyle(
                                font: primaryFont,
                                color: PdfColor.fromHex("#4169e1"),
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold)),
                                 pw.Text("Website: www.rgust.edu.gy",
                            style: pw.TextStyle(
                                font: primaryFont,
                                color: PdfColor.fromHex("#4169e1"),
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold)),
              ]),
              
                ]
              )
           
            ),
          );

          final List<int> pdfBytes = await pdf.save();
          final blob = html.Blob([pdfBytes], 'application/pdf');
          final url = html.Url.createObjectUrlFromBlob(blob);

          // Open the blob URL in a new tab
          html.window.open(url, '_blank');
        },
      ),
    );
  }
}
