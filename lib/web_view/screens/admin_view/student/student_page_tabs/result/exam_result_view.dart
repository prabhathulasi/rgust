import 'dart:developer';
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
import 'package:rugst_alliance_academia/web_view/screens/admin_view/pdf_generate/student_result_summary.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/result/alerts/delete_alert.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/result/update_result_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class ExamResult extends StatefulWidget {
  final StudentDetail? studentData;
  const ExamResult({super.key, this.studentData});

  @override
  State<ExamResult> createState() => _ExamResultState();
}

class _ExamResultState extends State<ExamResult> {
  updateResultAlert(BuildContext context) {
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

  Future getStudentResult() async {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    var token = await getTokenAndUseIt();
    if (token == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, RouteNames.login);
      });
    } else if (token == "Token Expired") {
      ToastHelper().errorToast("Session Expired Please Login Again");

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, RouteNames.login);
      });
    } else {
      var result = await studentProvider.getStudentResult(
          token, widget.studentData!.iD!);
      if (result == "Invalid Token") {
        ToastHelper().errorToast("Session Expired Please Login Again");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, RouteNames.login);
        });
      }
    }
  }

  @override
  void initState() {
    getStudentResult();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<StudentProvider>(builder: (context, studentConsumer, child) {
      if (studentConsumer.isLoading == true) {
        return const Center(
          child: SpinKitSpinningLines(color: AppColors.colorc7e),
        );
      } else if (studentConsumer.examResultModel.result == null) {
        return const Center(
          child: Text(
            "No Record Found",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      } else {
        var examData = studentConsumer.examResultModel.result;
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
                                      result: examData,
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
                                                  color: AppColors.color0ec),
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
            Expanded(
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
                            AppRichTextView(
                                title: category,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                            SizedBox(
                              width: 5.w,
                            ),
                            studentConsumer.examResultModel.userType == "COE"
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
                                      Icons.edit_outlined,
                                      color: AppColors.colorRed,
                                      size: 22.sp,
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
                                  label: AppRichTextView(
                                title: "Name",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.colorc7e,
                              )),
                              DataColumn(
                                  label: AppRichTextView(
                                title: "Code",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.colorc7e,
                              )),
                              DataColumn(
                                  label: AppRichTextView(
                                title: "Batch",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.colorc7e,
                              )),
                              DataColumn(
                                  label: AppRichTextView(
                                title: "CW-1",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.colorc7e,
                              )),
                              DataColumn(
                                  label: AppRichTextView(
                                title: "CW-2",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.colorc7e,
                              )),
                              DataColumn(
                                  label: AppRichTextView(
                                title: "CW-3",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.colorc7e,
                              )),
                              DataColumn(
                                  label: AppRichTextView(
                                title: "CW-4",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.colorc7e,
                              )),
                              DataColumn(
                                  label: AppRichTextView(
                                title: "Final",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.colorc7e,
                              )),
                              DataColumn(
                                  label: AppRichTextView(
                                title: "Grade",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.colorc7e,
                              )),
                            ],
                            rows: categoryItems
                                .map(
                                  (item) => DataRow(
                                    cells: [
                                      DataCell(item.isRepeat == true
                                          ? InkWell(
                                              onTap: () {
                                                if (studentConsumer
                                                        .examResultModel
                                                        .userType ==
                                                    "COE") {
                                                  resultDeleteDialog(
                                                      context,
                                                      item.iD!,
                                                      item.studentId!);
                                                }
                                              },
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: item.courseName!
                                                            .trim(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Arial-Black",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .colorBlack,
                                                            fontSize: 12.sp)),
                                                    WidgetSpan(
                                                      child:
                                                          Transform.translate(
                                                        offset:
                                                            const Offset(0, -8),
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
                                              ),
                                            )
                                          : Text(
                                              item.courseName!.trim(),
                                              style: TextStyle(
                                                  fontFamily: "Arial-Black",
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.colorBlack,
                                                  fontSize: 12.sp),
                                            )),
                                      DataCell(AppRichTextView(
                                        title: item.courseCode!,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                      DataCell(AppRichTextView(
                                        title: item.batch!,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                      DataCell(AppRichTextView(
                                        title: item.cw1!,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                      DataCell(AppRichTextView(
                                        title: item.cw2!,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                      DataCell(AppRichTextView(
                                        title: item.cw3!,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                      DataCell(AppRichTextView(
                                        title: item.cw4!,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                      DataCell(AppRichTextView(
                                        title: item.finalMark!,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                      DataCell(AppRichTextView(
                                        title: item.grade!,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
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
            )
          ],
        );
      }
    }));
  }

  List<String> _getCategories(List<Result>? data) {
    return data!.map((item) => item.className!).toSet().toList();
  }

  List<Result> _getItemsForCategory(String category, List<Result>? data) {
    return data!.where((item) => item.className! == category).toList();
  }
}
