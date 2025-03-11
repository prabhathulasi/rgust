import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/student/single_student_result_model.dart';

import 'package:rugst_alliance_academia/data/model/student/single_student_detail_model.dart';

import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/result/update_result_view.dart';

import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class MobileExamResultScreen extends StatefulWidget {
  final SingleStudentProfile? studentData;
  const MobileExamResultScreen({super.key, this.studentData});

  @override
  State<MobileExamResultScreen> createState() => _MobileExamResultScreenState();
}

class _MobileExamResultScreenState extends State<MobileExamResultScreen> {
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
      var result = await studentProvider.getSingleStudentResult(
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
      } else if (studentConsumer.singleStudentResultModel.results == null) {
        return  Center(
          child: Text(
            "No Record Found",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        );
      } else {
                var result = studentConsumer.singleStudentResultModel.results;
            return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: _getCategories(result).length,
                        itemBuilder: (context, index) {
                          final category = _getCategories(result)[index];
                          final categoryItems =
                              _getItemsForCategory(category, result);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category,
                                style:  TextStyle(
                                    fontSize: 15.sp, fontWeight: FontWeight.bold),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  border: TableBorder.all(),
                                  columns: [
                                    DataColumn(
                                        label: Text(
                                      'Code',
                                      style: TextStyle(
                                        color: AppColors.color446,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Name',
                                      style: TextStyle(
                                         color: AppColors.color446,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    )),
                                      DataColumn(
                                        label: Text(
                                      'Credits',
                                      style: TextStyle(
                                         color: AppColors.color446,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Grade',
                                      style: TextStyle(
                                         color: AppColors.color446,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                    )),
                                  ],
                                  rows: categoryItems
                                      .map(
                                        (item) => DataRow(
                                          cells: [
                                            DataCell(Text(
                                              item.courseCode!.trim(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: item.grade == "F"
                                                      ? AppColors.colorRed
                                                      : AppColors.colorBlack,
                                                  fontSize: 12.sp),
                                            )),
                                            DataCell(Text(
                                              item.courseName!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: item.grade == "F"
                                                      ? AppColors.colorRed
                                                      : AppColors.colorBlack,
                                                  fontSize: 12.sp),
                                            )),
                                              DataCell(Text(
                                              item.credits.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: item.grade == "F"
                                                      ? AppColors.colorRed
                                                      : AppColors.colorBlack,
                                                  fontSize: 12.sp),
                                            )),
                                            DataCell(Text(
                                              item.grade!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: item.grade == "F"
                                                      ? AppColors.colorRed
                                                      : AppColors.colorBlack,
                                                  fontSize: 12.sp),
                                            )),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          );
                        }),
                  );
      }
    }));
  }

  List<String> _getCategories(List<Results>? data) {
    return data!.map((item) => item.className!).toSet().toList();
  }

  List<Results> _getItemsForCategory(String category, List<Results>? data) {
    return data!.where((item) => item.className! == category).toList();
  }
}
