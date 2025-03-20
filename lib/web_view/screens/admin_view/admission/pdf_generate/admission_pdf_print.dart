import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_criminal_check_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> printApplication(AdmissionProvider admissionProvider,
    AdmissionCriminalCheckProvider admissionCriminalCheckProvider) async {
  final pdf = pw.Document();
  // Load the image data
  final imageData =
      (await rootBundle.load(ImagePath.webrgustLogo)).buffer.asUint8List();
// Load the image data
  final photoData =
      base64Decode(admissionProvider.admissionDetailModel.data!.photo!);
  final educationDetails =
      admissionProvider.admissionDetailModel.data!.educationDetails!;
  final jobDetails = admissionProvider.admissionDetailModel.data!.jobDetails!;

  pdf.addPage(
    pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Image(
                          pw.MemoryImage(imageData),
                          width: 50.w,
                        ),
                        pw.SizedBox(width: 10.w),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Rajiv Gandhi University of Science and Technology"
                                  .toUpperCase(),
                              style: pw.TextStyle(
                                fontSize: 15.sp,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              "A Brand for Quality Education",
                              style: pw.TextStyle(
                                color: PdfColors.red,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 15.h),
                    pw.Center(
                      child: pw.Text(
                        "Application Form",
                        style: pw.TextStyle(
                          fontStyle: pw.FontStyle.italic,
                          fontSize: 18.sp,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 15),
                    pw.Center(
                      child: pw.Text(
                        "Personal Details",
                        style: pw.TextStyle(
                          fontSize: 15.sp,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Center(
                      child: pw.Text(
                        "As they Appears in the Passport where applicable",
                        style: pw.TextStyle(
                          fontSize: 10.sp,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.brown,
                        ),
                      ),
                    ),
                    pw.Divider(color: PdfColors.black),
                    pw.SizedBox(height: 10.h),
                    pw.Align(
                      alignment: pw.Alignment.topRight,
                      child: pw.Container(
                        height: 100.h,
                        width: 80.w,
                        decoration: pw.BoxDecoration(
                          
                          image: pw.DecorationImage(
                            image: pw.MemoryImage(photoData),
                            fit: pw.BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 10.h),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Title",
                                style: pw.TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5.h),
                              pw.Text(
                                admissionProvider
                                    .admissionDetailModel.data!.title!,
                                style: pw.TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "First Name",
                                style: pw.TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5.h),
                              pw.Text(
                                admissionProvider
                                    .admissionDetailModel.data!.firstName!,
                                style: pw.TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Last Name",
                                style: pw.TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5.h),
                              pw.Text(
                                admissionProvider
                                    .admissionDetailModel.data!.lastName!,
                                style: pw.TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 10.h),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Gender",
                                style: pw.TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5.h),
                              pw.Text(
                                admissionProvider.admissionDetailModel.data!
                                            .gender! ==
                                        "GenderEnum.male"
                                    ? "Male"
                                    : "Female",
                                style: pw.TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Date of Birth",
                                style: pw.TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5.h),
                              pw.Text(
                                admissionProvider
                                    .admissionDetailModel.data!.dob!,
                                style: pw.TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Passport ",
                                style: pw.TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5.h),
                              pw.Text(
                                admissionProvider
                                    .admissionDetailModel.data!.passportNumber!,
                                style: pw.TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 15),
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Country of Birth",
                                style: pw.TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5.h),
                              pw.Text(
                                admissionProvider
                                    .admissionDetailModel.data!.birthCountry!,
                                style: pw.TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Country of Citizenship",
                                style: pw.TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5.h),
                              pw.Text(
                                admissionProvider
                                    .admissionDetailModel.data!.citizenship!,
                                style: pw.TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Residing Country",
                                style: pw.TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5.h),
                              pw.Text(
                                admissionProvider.admissionDetailModel.data!
                                    .residingCountry!,
                                style: pw.TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 15.h),
                    pw.Text(
                      "Will you be Studying on a student Visa?",
                      style: pw.TextStyle(
                        fontSize: 13.sp,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      admissionProvider
                                  .admissionDetailModel.data!.studentVisa ==
                              true
                          ? "Yes"
                          : "No",
                      style: pw.TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                    pw.SizedBox(height: 10.h),
                    pw.Text(
                      "Will you be speak any language other than English?",
                      style: pw.TextStyle(
                        fontSize: 13.sp,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    admissionProvider
                            .admissionDetailModel.data!.otherLanguages!.isEmpty
                        ? pw.Text(
                            "No",
                            style: pw.TextStyle(
                              fontSize: 12.sp,
                            ),
                          )
                        : pw.Wrap(
                            children: admissionProvider
                                .admissionDetailModel.data!.otherLanguages!
                                .map((item) => pw.Container(
                                    padding: const pw.EdgeInsets.all(8),
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    child: pw.Text(item.langName!,
                                        style: pw.TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: pw.FontWeight.bold,
                                        ))))
                                .toList(),
                          ),
                    pw.SizedBox(height: 15.h),
                    pw.Text(
                      "Will you have a disability for which additional assistance may be required?",
                      style: pw.TextStyle(
                        fontSize: 13.sp,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(
                      height: 5.h,
                    ),
                    pw.Text(
                      admissionProvider.admissionDetailModel.data!.disabilty!,
                      style: pw.TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                    pw.SizedBox(
                      height: 15.h,
                    ),
                    admissionProvider.admissionDetailModel.data!.disabilty! ==
                            "Yes"
                        ? pw.Text(
                            admissionProvider
                                .admissionDetailModel.data!.disablityDetails!,
                            style: pw.TextStyle(
                              fontSize: 12.sp,
                            ),
                          )
                        : pw.Container(),
                    pw.SizedBox(
                      height: 15.h,
                    ),
                    pw.Center(
                      child: pw.Text(
                        "Program Details",
                        style: pw.TextStyle(
                          fontSize: 15.sp,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Divider(
                      color: PdfColors.black,
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        // Student Type Column
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Student Type",
                                style: pw.TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5.h),
                              pw.Text(
                                admissionProvider
                                    .admissionDetailModel.data!.studentType!,
                                style: pw.TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Program Column
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Program",
                                style: pw.TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5.h),
                              pw.Text(
                                admissionProvider
                                    .admissionDetailModel.data!.programName!,
                                style: pw.TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Semester Column
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Semester",
                                style: pw.TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5.h),
                              pw.Text(
                                admissionProvider
                                    .admissionDetailModel.data!.semester!,
                                style: pw.TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 15.h,
                    ),
                    pw.Text(
                      "Previous Enrollment",
                      style: pw.TextStyle(
                        fontSize: 13.sp,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(
                        height: 5.h), // Equivalent to SizedBox(height: 5.h)
                    pw.Text(
                      admissionProvider.admissionDetailModel.data!
                                  .alreadyEnrolled! ==
                              true
                          ? "Yes"
                          : "No",
                      style: pw.TextStyle(
                        fontSize: 12.sp,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                    pw.SizedBox(height: 15.h),
                    // Conditionally show the Row based on alreadyEnrolled value
                    admissionProvider
                                .admissionDetailModel.data!.alreadyEnrolled! ==
                            false
                        ? pw.Container()
                        : pw.Row(
                            children: [
                              // Enrolled Program Name Column
                              pw.Expanded(
                                flex: 1,
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      "Enrolled Program Name",
                                      style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.SizedBox(
                                        height:
                                            5), // Equivalent to SizedBox(height: 5.h)
                                    pw.Text(
                                      admissionProvider.admissionDetailModel
                                          .data!.enrolledProgramName!,
                                      style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // University Name Column
                              pw.Expanded(
                                flex: 2,
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      "University Name",
                                      style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.SizedBox(
                                        height:
                                            5), // Equivalent to SizedBox(height: 5.h)
                                    pw.Text(
                                      admissionProvider.admissionDetailModel
                                          .data!.universityName!,
                                      style: pw.TextStyle(
                                        fontSize: 15,
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    pw.SizedBox(
                      height: 15.h,
                    ),
                    pw.Center(
                      child: pw.Text(
                        "Contact Details",
                        style: pw.TextStyle(
                          fontSize: 15.sp,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Divider(
                      color: PdfColors.black,
                    ),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // Column for Email (flex: 1)
                        pw.Expanded(
                          flex: 2,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              // Title for Email
                              pw.Text(
                                "Email",
                                style: pw.TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5.h),
                              // Email Address
                              pw.Text(
                                admissionProvider
                                    .admissionDetailModel.data!.emailAddress!,
                                style: pw.TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Column for Telephone (flex: 2)
                        pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              // Title for Telephone
                              pw.Text(
                                "Telephone",
                                style: pw.TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 5.h),
                              // Telephone Number
                              pw.Text(
                                admissionProvider
                                    .admissionDetailModel.data!.contactNumber!,
                                style: pw.TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // SizedBox for spacing (equivalent to SizedBox(height: 15.h))
                    pw.SizedBox(height: 15.h),

                    // Permanent Address Section
                    pw.Text(
                      "Permanent Address",
                      style: pw.TextStyle(
                        fontSize: 13.sp,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      admissionProvider.admissionDetailModel.data!.homeAddress!,
                      style: pw.TextStyle(
                        fontSize: 12.sp,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                    pw.SizedBox(height: 15.h),

                    // Mailing Address Section
                    pw.Text(
                      "Mailing Address",
                      style: pw.TextStyle(
                        fontSize: 13.sp,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      admissionProvider
                          .admissionDetailModel.data!.mailingAddress!,
                      style: pw.TextStyle(
                        fontSize: 12.sp,
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                    pw.SizedBox(height: 15.h),
                    pw.Center(
                      child: pw.Text(
                        'Agent Details',
                        style: pw.TextStyle(
                            fontSize: 15.sp, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Divider(color: PdfColors.black),
                    pw.SizedBox(height: 10.h),

                    pw.Text(
                      'Are you applying through an RGUST authorized agent?',
                      style: pw.TextStyle(
                          fontSize: 13.sp, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      admissionProvider
                              .admissionDetailModel.data!.agentName!.isEmpty
                          ? "No"
                          : "Yes",
                      style: pw.TextStyle(
                          fontSize: 12.sp, fontWeight: pw.FontWeight.normal),
                    ),
                    pw.SizedBox(height: 10.h),
                    if (admissionProvider
                        .admissionDetailModel.data!.agentName!.isNotEmpty) ...[
                      pw.Row(
                        children: [
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Agent Name',
                                  style: pw.TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                                pw.SizedBox(height: 5.h),
                                pw.Text(
                                  admissionProvider
                                      .admissionDetailModel.data!.agentName!,
                                  style: pw.TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: pw.FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Agent Email',
                                  style: pw.TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                                pw.SizedBox(height: 5.h),
                                pw.Text(
                                  admissionProvider
                                      .admissionDetailModel.data!.agentEmail!,
                                  style: pw.TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: pw.FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Counselor Name',
                                  style: pw.TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: pw.FontWeight.bold),
                                ),
                                pw.SizedBox(height: 5.h),
                                pw.Text(
                                  admissionProvider.admissionDetailModel.data!
                                      .counselorName!,
                                  style: pw.TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: pw.FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10.h),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Agent Address',
                            style: pw.TextStyle(
                                fontSize: 13.sp,
                                fontWeight: pw.FontWeight.bold),
                          ),
                          pw.SizedBox(height: 5.h),
                          pw.Text(
                            admissionProvider
                                .admissionDetailModel.data!.agentAddress!,
                            style: pw.TextStyle(
                                fontSize: 12.sp,
                                fontWeight: pw.FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                    pw.SizedBox(height: 15.h),
                    pw.Center(
                      child: pw.Text(
                        'Education History',
                        style: pw.TextStyle(
                            fontSize: 15.sp, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Divider(color: PdfColors.black),
                    pw.SizedBox(height: 10.h),
                    // Table headers
                    pw.Row(
                      children: [
                        pw.Expanded(
                            flex: 1,
                            child: pw.Text("#", style: _headerTextStyle)),
                        pw.Expanded(
                            flex: 1,
                            child: pw.Text("Course", style: _headerTextStyle)),
                        pw.Expanded(
                            flex: 1,
                            child: pw.Text("Institution",
                                style: _headerTextStyle)),
                        pw.Expanded(
                            flex: 1,
                            child: pw.Text("Start Date",
                                style: _headerTextStyle)),
                        pw.Expanded(
                            flex: 1,
                            child: pw.Text("End Date",
                                style: _headerTextStyle)),
                                  pw.Expanded(
                            flex: 1,
                            child: pw.Text("Document ",
                                style: _headerTextStyle)),
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    // Education details list
                    for (int i = 0; i < educationDetails.length; i++)
                      pw.Row(
                        children: [
                          pw.Expanded(
                              flex: 1,
                              child:
                                  pw.Text("${i + 1}", style: _bodyTextStyle)),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Text(educationDetails[i].courseName!,
                                  style: _bodyTextStyle)),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Text(
                                  educationDetails[i].highSchoolName!,
                                  style: _bodyTextStyle)),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Text(educationDetails[i].startDate!,
                                  style: _bodyTextStyle)),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Text(educationDetails[i].endDate!,
                                  style: _bodyTextStyle)),
                                           pw.Expanded(
                              flex: 1,
                              child: pw.Text("Yes",
                                  style: _bodyTextStyle)),
                        ],
                      ),

                    pw.SizedBox(height: 15.sp),
                    pw.Center(
                      child: pw.Text(
                        'Job History',
                        style: pw.TextStyle(
                            fontSize: 15.sp, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Divider(color: PdfColors.black),
                    pw.SizedBox(height: 10.h),
                    // Check if there are job details
                    if (jobDetails.isEmpty ||
                        jobDetails.every((job) => job.previousExp == false))
                      pw.Center(
                        child: pw.Text(
                          'No Job Details',
                          style: pw.TextStyle(
                              fontSize: 12.sp,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.red),
                        ),
                      )
                    else
                      // Table headers
                      pw.Row(
                        children: [
                          pw.Expanded(
                              flex: 1,
                              child: pw.Text("#", style: _headerTextStyle)),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Text("Role", style: _headerTextStyle)),
                          pw.Expanded(
                              flex: 1,
                              child:
                                  pw.Text("Employer", style: _headerTextStyle)),
                          pw.Expanded(
                              flex: 1,
                              child: pw.Text("Start Date",
                                  style: _headerTextStyle)),
                          pw.Expanded(
                              flex: 1,
                              child:
                                  pw.Text("End Date", style: _headerTextStyle)),
                        ],
                      ),
                    pw.SizedBox(height: 5.h),
                    // Job details list
                    for (int i = 0; i < jobDetails.length; i++)
                      if (jobDetails[i].previousExp == true)
                        pw.Row(
                          children: [
                            pw.Expanded(
                                flex: 1,
                                child:
                                    pw.Text("${i + 1}", style: _bodyTextStyle)),
                            pw.Expanded(
                                flex: 1,
                                child: pw.Text(jobDetails[i].role!,
                                    style: _bodyTextStyle)),
                            pw.Expanded(
                                flex: 1,
                                child: pw.Text(jobDetails[i].employername!,
                                    style: _bodyTextStyle)),
                            pw.Expanded(
                                flex: 1,
                                child: pw.Text(jobDetails[i].startDate!,
                                    style: _bodyTextStyle)),
                            pw.Expanded(
                                flex: 1,
                                child: pw.Text(jobDetails[i].endDate!,
                                    style: _bodyTextStyle)),
                          ],
                        ),

                    pw.Center(
                      child: pw.Text(
                        'English Proficiency',
                        style: pw.TextStyle(
                            fontSize: 15.sp, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Divider(color: PdfColors.black),
                    pw.SizedBox(height: 10.h),

                    // "How long have you been studying English?"
                    pw.Text(
                      'How long have you been studying English?',
                      style: pw.TextStyle(
                          fontSize: 13.sp, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      admissionProvider.admissionDetailModel.data!
                                  .internationalStudent ==
                              true
                          ? admissionProvider.admissionDetailModel.data!.engExp!
                          : "Native Speaker",
                      style: pw.TextStyle(
                          fontSize: 12.sp, fontWeight: pw.FontWeight.normal),
                    ),
                    pw.SizedBox(height: 10.h),

                    // "What is your present level of English?"
                    pw.Text(
                      'What is your present level of English?',
                      style: pw.TextStyle(
                          fontSize: 13.sp, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      admissionProvider.admissionDetailModel.data!
                                  .internationalStudent ==
                              true
                          ? admissionProvider
                              .admissionDetailModel.data!.engLevel!
                          : "Native Speaker",
                      style: pw.TextStyle(
                          fontSize: 12.sp, fontWeight: pw.FontWeight.normal),
                    ),
                    pw.SizedBox(height: 10.h),

                    // "Have you taken any English proficiency examinations?"
                    pw.Text(
                      'Have you taken any English proficiency examinations?',
                      style: pw.TextStyle(
                          fontSize: 13.sp, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      admissionProvider.admissionDetailModel.data!.examTaken!
                          ? "Yes"
                          : "No",
                      style: pw.TextStyle(
                          fontSize: 12.sp, fontWeight: pw.FontWeight.normal),
                    ),
                    pw.SizedBox(height: 15.h),
                    pw.Center(
                      child: pw.Text(
                        'Standardized Test',
                        style: pw.TextStyle(
                            fontSize: 15.sp, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Divider(color: PdfColors.black),
                    pw.SizedBox(height: 10.h),
                    // Table Header
                    pw.Row(
                      children: [
                        _buildTableCell('#', fontWeight: pw.FontWeight.bold),
                        _buildTableCell('Test', fontWeight: pw.FontWeight.bold),
                        _buildTableCell('Location',
                            fontWeight: pw.FontWeight.bold),
                        _buildTableCell('Date', fontWeight: pw.FontWeight.bold),
                        _buildTableCell('Attempts',
                            fontWeight: pw.FontWeight.bold),
                        _buildTableCell('Highest Score',
                            fontWeight: pw.FontWeight.bold),
                      ],
                    ),
                    pw.SizedBox(height: 10.h),

                    // Data Row (if test is taken)
                    admissionProvider.admissionDetailModel.data!.testTaken ==
                            true
                        ? pw.Row(
                            children: [
                              _buildTableCell('1'),
                              _buildTableCell(admissionProvider
                                  .admissionDetailModel.data!.testName!),
                              _buildTableCell(admissionProvider
                                  .admissionDetailModel.data!.testLocation!),
                              _buildTableCell(admissionProvider
                                  .admissionDetailModel.data!.testDate!),
                              _buildTableCell(admissionProvider
                                  .admissionDetailModel.data!.testAttempts!),
                              _buildTableCell(admissionProvider
                                  .admissionDetailModel.data!.testScore!),
                            ],
                          )
                        : pw.Center(
                            child: pw.Text(
                              "No Test Taken",
                              style: pw.TextStyle(
                                fontSize: 12.sp,
                                color: PdfColors.red,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),

                    pw.SizedBox(height: 15.h),

                    pw.Center(
                      child: pw.Text(
                        'Letter of Recommendation',
                        style: pw.TextStyle(
                            fontSize: 15.sp, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Divider(color: PdfColors.black),
                    pw.SizedBox(height: 15),
                    // Table Header
                    pw.Row(
                      children: [
                        _buildTableCell('#', fontWeight: pw.FontWeight.bold),
                        _buildTableCell('Profession',
                            fontWeight: pw.FontWeight.bold),
                        _buildTableCell('Position',
                            fontWeight: pw.FontWeight.bold),
                        _buildTableCell('Work Phone',
                            fontWeight: pw.FontWeight.bold),
                        _buildTableCell('Email',
                            fontWeight: pw.FontWeight.bold),
                      ],
                    ),

                    pw.SizedBox(height: 15),

                    // Table Data (filled with actual data)
                    pw.Row(
                      children: [
                        _buildTableCell('1'),
                        _buildTableCell(admissionProvider
                            .admissionDetailModel.data!.referenceName!),
                        _buildTableCell(admissionProvider
                            .admissionDetailModel.data!.referenceProfession!),
                        _buildTableCell(admissionProvider
                            .admissionDetailModel.data!.referencePhone!),
                        _buildTableCell(admissionProvider
                            .admissionDetailModel.data!.referenceEmail!),
                      ],
                    ),

                    pw.SizedBox(height: 15.h),

                    pw.Center(
                      child: pw.Text(
                        'Background Check',
                        style: pw.TextStyle(
                            fontSize: 15.sp, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Divider(color: PdfColors.black),
                    // SizedBox Equivalent: Space between elements
                    pw.SizedBox(height: 15),

                    // Iterating over the dataList and creating checkboxes in the PDF
                    for (var item in admissionCriminalCheckProvider.dataList)
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Row(
                          children: [
                            // Simulating checkbox

                            pw.Expanded(
                              child: pw.Text(
                                item["title"],
                                style: pw.TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: pw.FontWeight.normal,
                                  color: PdfColors.black,
                                ),
                              ),
                            ),
                            pw.SizedBox(width: 10.w),
                            pw.Checkbox(
                              activeColor: PdfColors.grey,
                              name: "",
                              value: true,
                            ),
                          ],
                        ),
                      ),

                    // SizedBox Equivalent: Space between elements
                    pw.SizedBox(height: 15),

                    pw.Center(
                      child: pw.Text(
                        'Payment Details',
                        style: pw.TextStyle(
                            fontSize: 15.sp, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Divider(color: PdfColors.black),
                    // SizedBox Equivalent: Space between elements
                    pw.SizedBox(height: 15),
                    // Payment Method Section
                    pw.Text("Payment Method",
                        style: pw.TextStyle(
                            fontSize: 15, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 5),
                    admissionProvider
                            .admissionDetailModel.data!.paymentDate!.isEmpty
                        ? pw.Container()
                        : pw.Text("Bank Transfer",
                            style: pw.TextStyle(
                                fontSize: 15,
                                fontWeight: pw.FontWeight.normal)),
                    pw.SizedBox(height: 15),

                    // Payment Date Section
                    pw.Text("Payment Date",
                        style: pw.TextStyle(
                            fontSize: 15, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 5),
                    pw.Text(
                        admissionProvider
                            .admissionDetailModel.data!.paymentDate!,
                        style: pw.TextStyle(
                            fontSize: 15, fontWeight: pw.FontWeight.normal)),
                    pw.SizedBox(height: 15),

                    // Signature Section
                    admissionProvider
                            .admissionDetailModel.data!.signature!.isEmpty
                        ? pw.Container()
                        : pw.Container(
                            height: 100,
                            width: 200,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(color: PdfColors.black)),
                            child: pw.Center(
                              child: pw.Image(
                                pw.MemoryImage(base64Decode(admissionProvider
                                    .admissionDetailModel.data!.signature!)),
                              ),
                            ),
                          ),
                    pw.SizedBox(height: 15),
                  
                  ])
            ]),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

pw.TextStyle get _headerTextStyle {
  return pw.TextStyle(fontSize: 13.sp, fontWeight: pw.FontWeight.bold);
}

pw.TextStyle get _bodyTextStyle {
  return pw.TextStyle(fontSize: 12.sp, fontWeight: pw.FontWeight.normal);
}

// Helper method to build each table cell
pw.Widget _buildTableCell(String text,
    {pw.FontWeight fontWeight = pw.FontWeight.normal}) {
  return pw.Expanded(
    child: pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 13.sp,
        fontWeight: fontWeight,
      ),
    ),
  );
}
