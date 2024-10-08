import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/exam_result_model.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';

import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/pdf_generate/student_result_summary.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_page_tabs/result/update_result_view.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class ExamResult extends StatefulWidget {
  final StudentDetail? studentData;
  const ExamResult({super.key, this.studentData});

  @override
  State<ExamResult> createState() => _ExamResultState();
}

class _ExamResultState extends State<ExamResult> {
  updateResultAlert(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Card(
        elevation: 5.0,
        child: UpdateResultView(studenId: widget.studentData!.iD),
      ),
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);

    Future getStudentResult() async {
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
        var result = await studentProvider.getStudentResult(
            token, widget.studentData!.iD!);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    return Scaffold(
      body: FutureBuilder(
        future: getStudentResult(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitSpinningLines(
                color: AppColors.colorc7e,
              ),
            );
          } else {
            var data = studentProvider.examResultModel.result;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: SizedBox(
                                    height: MediaQuery.sizeOf(context).height,
                                    width: 1200.w,
                                    child: Stack(
                                      children: [
                                        StudentResultSummary(
                                          result: data,
                                          studentData: widget.studentData,
                                        ),
                                        Transform.translate(
                                          offset: Offset(10.w, -13.h),
                                          child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Align(
                                                alignment: Alignment.topRight,
                                                child: CircleAvatar(
                                                  radius: 14.0,
                                                  backgroundColor:
                                                      AppColors.colorc7e,
                                                  child: Icon(Icons.close,
                                                      color:
                                                          AppColors.color0ec),
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.summarize_outlined,
                            color: AppColors.colorc7e,
                          ))),
                ),
                Consumer<StudentProvider>(
                    builder: (context, studentConsumer, child) {
                  var examData = studentConsumer.examResultModel.result;
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _getCategories(examData!).length,
                      itemBuilder: (context, index) {
                        final category = _getCategories(examData)[index];
                        final categoryItems =
                            _getItemsForCategory(category, examData);
                        
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    category,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  studentConsumer.examResultModel.userType ==
                                          "COE"
                                      ? InkWell(
                                          onTap: () async {
                                            await studentConsumer
                                                .updateStudentResultTable(
                                                    categoryItems);
                                            if (context.mounted) {
                                              updateResultAlert(context);
                                            }
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: AppColors.colorc7e,
                                            size: 25.sp,
                                          ))
                                      : Container()
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: FractionallySizedBox(
                                widthFactor: 0.99,
                                child: DataTable(
                                  border: TableBorder.all(),
                                  columns: [
                                    DataColumn(
                                        label: Text(
                                      'Name',
                                      style: TextStyle(
                                          fontFamily: "Arial-Black",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Code',
                                      style: TextStyle(
                                          fontFamily: "Arial-Black",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Batch',
                                      style: TextStyle(
                                          fontFamily: "Arial-Black",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'CW-1',
                                      style: TextStyle(
                                          fontFamily: "Arial-Black",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'CW-2',
                                      style: TextStyle(
                                          fontFamily: "Arial-Black",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'CW-3',
                                      style: TextStyle(
                                          fontFamily: "Arial-Black",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'CW-4',
                                      style: TextStyle(
                                          fontFamily: "Arial-Black",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Final',
                                      style: TextStyle(
                                          fontFamily: "Arial-Black",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Grade',
                                      style: TextStyle(
                                          fontFamily: "Arial-Black",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    )),
                                  ],
                                  rows: categoryItems
                                      .map(
                                        (item) => DataRow(
                                          cells: [
                                            DataCell(item.isRepeat == true
                                                ? RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: item
                                                                .courseName!
                                                                .trim(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Arial-Black",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .colorBlack,
                                                                fontSize:
                                                                    12.sp)),
                                                        WidgetSpan(
                                                          child: Transform
                                                              .translate(
                                                            offset:
                                                                const Offset(
                                                                    0, -8),
                                                            child: const Text(
                                                              '(R)',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: AppColors
                                                                      .colorRed),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Text(
                                                    item.courseName!.trim(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Arial-Black",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .colorBlack,
                                                        fontSize: 12.sp),
                                                  )),
                                            DataCell(Text(
                                              item.courseCode!,
                                              style: TextStyle(
                                                  fontFamily: "Arial-Black",
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.colorBlack,
                                                  fontSize: 12.sp),
                                            )),
                                            DataCell(Text(
                                              item.batch!,
                                              style: TextStyle(
                                                  fontFamily: "Arial-Black",
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.colorBlack,
                                                  fontSize: 12.sp),
                                            )),
                                            DataCell(Text(
                                              item.cw1!,
                                              style: TextStyle(
                                                  fontFamily: "Arial-Black",
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.colorBlack,
                                                  fontSize: 12.sp),
                                            )),
                                            DataCell(Text(
                                              item.cw2!,
                                              style: TextStyle(
                                                  fontFamily: "Arial-Black",
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.colorBlack,
                                                  fontSize: 12.sp),
                                            )),
                                            DataCell(Text(
                                              item.cw3!,
                                              style: TextStyle(
                                                  fontFamily: "Arial-Black",
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.colorBlack,
                                                  fontSize: 12.sp),
                                            )),
                                            DataCell(Text(
                                              item.cw4!,
                                              style: TextStyle(
                                                  fontFamily: "Arial-Black",
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.colorBlack,
                                                  fontSize: 12.sp),
                                            )),
                                            DataCell(Text(
                                              item.finalMark!,
                                              style: TextStyle(
                                                  fontFamily: "Arial-Black",
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.colorBlack,
                                                  fontSize: 12.sp),
                                            )),
                                            DataCell(Text(
                                              item.grade!,
                                              style: TextStyle(
                                                  fontFamily: "Arial-Black",
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.colorBlack,
                                                  fontSize: 12.sp),
                                            )),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    ),
                  );
                }),
              ],
            );
          }
        },
      ),
    );
  }

  List<String> _getCategories(List<Result>? data) {
    return data!.map((item) => item.className!).toSet().toList();
  }

  List<Result> _getItemsForCategory(String category, List<Result>? data) {
    return data!.where((item) => item.className! == category).toList();
  }
}
