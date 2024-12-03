import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/result_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/data/model/publish_result_model.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/batch_dropdown.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/class_dropdown.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/program_dropdown_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/year_dropdown_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/result/approval_timeline.dart';
import 'package:rugst_alliance_academia/web_view/screens/result/publish_button.dart';

import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class ResultSettingsView extends StatefulWidget {
  const ResultSettingsView({super.key});

  @override
  State<ResultSettingsView> createState() => _ResultSettingsViewState();
}

class _ResultSettingsViewState extends State<ResultSettingsView> {
 

  @override
  Widget build(BuildContext context) {
    final programProvider = Provider.of<ProgramProvider>(context);
    final resultProvider = Provider.of<ResultProvider>(context, listen: false);

    Future getOverallResult() async {
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
        var result = await resultProvider.getAllResult(token,
            batch: programProvider.selectedBatch,
            classId: programProvider.selectedClass,
            programId: programProvider.selectedDept);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Center(
              child: AppRichTextView(
                  title: "Publish Results",
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                          title: "Program",
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500),
                      SizedBox(
                        height: 10.h,
                      ),
                      const ProgramDropdown(),
                      SizedBox(
                        height: 10.h,
                      ),
                      programProvider.selectedDept == null
                          ? Container()
                          : AppRichTextView(
                              title: "Class",
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w500),
                      const ClassDropdown(isUpdatingStudent: false,),
                      SizedBox(
                        height: 10.h,
                      ),
                      programProvider.selectedClass == null
                          ? Container()
                          : AppRichTextView(
                              title: "Year",
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w500),
                      const DynamicYearsDropdown(),
                      SizedBox(
                        height: 10.h,
                      ),
                      programProvider.selectedClass == null
                          ? Container()
                          : AppRichTextView(
                              title: "Batch",
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w500),
                      SizedBox(
                        height: 10.h,
                      ),
                      const BatchDropdown(isUpdatingStudent: false,),
                      SizedBox(
                        height: 20.h,
                      ),
                      programProvider.selectedBatch == null
                          ? Container()
                          : const PublishButton()
                    ],
                  ),
                  const VerticalDivider(),
                  programProvider.selectedBatch == null
                      ? Container()
                      : Expanded(
                        flex: 2,
                        child: FutureBuilder(
                            future: getOverallResult(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: SpinKitSpinningLines(
                                      color: AppColors.colorc7e),
                                );
                              } else {
                                var examData =
                                    resultProvider.resultPublishModel.results;
                                              
                                return examData == null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Lottie.asset(LottiePath.noDataLottie),
                                          AppRichTextView(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            title: "No Result Records Found",
                                            textColor: AppColors.colorRed,
                                          ),
                                        ],
                                      )
                                    : resultProvider
                                                .resultPublishModel.userType ==
                                            "Admin"
                                        ? BubbleTimlineView()
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                _getCategories(examData).length,
                                            itemBuilder: (context, index) {
                                              final category =
                                                  _getCategories(examData)[index];
                                              final categoryItems =
                                                  _getItemsForCategory(
                                                      category, examData);
                                              
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "Student Registration No $category",
                                                      style:  TextStyle(
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    child: FractionallySizedBox(
                                                      widthFactor: 1.0,
                                                      child: DataTable(
                                                        border: TableBorder.all(),
                                                        columns: [
                                                          DataColumn(
                                                              label: Text(
                                                            'Name',
                                                            style: TextStyle(
                                                              fontFamily: "Arial-Black",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.sp),
                                                          )),
                                                          DataColumn(
                                                              label: Text(
                                                            'Code',
                                                            style: TextStyle(
                                                               fontFamily: "Arial-Black",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.sp),
                                                          )),
                                                          DataColumn(
                                                              label: Text(
                                                            'Batch',
                                                            style: TextStyle(
                                                               fontFamily: "Arial-Black",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.sp),
                                                          )),
                                                          DataColumn(
                                                              label: Text(
                                                                
                                                            'CW-1',
                                                            style: TextStyle(
                                                               fontFamily: "Arial-Black",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.sp),
                                                          )),
                                                          DataColumn(
                                                              label: Text(
                                                            'CW-2',
                                                            style: TextStyle(
                                                               fontFamily: "Arial-Black",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.sp),
                                                          )),
                                                          DataColumn(
                                                              label: Text(
                                                            'CW-3',
                                                            style: TextStyle(
                                                               fontFamily: "Arial-Black",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.sp),
                                                          )),
                                                          DataColumn(
                                                              label: Text(
                                                            'CW-4',
                                                            style: TextStyle(
                                                               fontFamily: "Arial-Black",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.sp),
                                                          )),
                                                          DataColumn(
                                                              label: Text(
                                                            'Final',
                                                            style: TextStyle(
                                                               fontFamily: "Arial-Black",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.sp),
                                                          )),
                                                          DataColumn(
                                                              label: Text(
                                                            'Grade',
                                                            style: TextStyle(
                                                               fontFamily: "Arial-Black",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.sp),
                                                          )),
                                                        ],
                                                        rows: categoryItems
                                                            .map(
                                                              (item) => DataRow(
                                                                cells: [
                                                                  DataCell(Text(
                                                                    item.courseName!
                                                                        .trim(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: AppColors
                                                                            .colorBlack,
                                                                        fontSize:
                                                                            12.sp),
                                                                  )),
                                                                  DataCell(Text(
                                                                    item.courseCode!,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: AppColors
                                                                            .colorBlack,
                                                                        fontSize:
                                                                            12.sp),
                                                                  )),
                                                                  DataCell(Text(
                                                                    item.batch!,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: AppColors
                                                                            .colorBlack,
                                                                        fontSize:
                                                                            12.sp),
                                                                  )),
                                                                  DataCell(Text(
                                                                    item.cw1
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: AppColors
                                                                            .colorBlack,
                                                                        fontSize:
                                                                            12.sp),
                                                                  )),
                                                                  DataCell(Text(
                                                                    item.cw2
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: AppColors
                                                                            .colorBlack,
                                                                        fontSize:
                                                                            12.sp),
                                                                  )),
                                                                  DataCell(Text(
                                                                    item.cw3
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: AppColors
                                                                            .colorBlack,
                                                                        fontSize:
                                                                            12.sp),
                                                                  )),
                                                                  DataCell(Text(
                                                                    item.cw4
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: AppColors
                                                                            .colorBlack,
                                                                        fontSize:
                                                                            12.sp),
                                                                  )),
                                                                  DataCell(Text(
                                                                    item.finalMark
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: AppColors
                                                                            .colorBlack,
                                                                        fontSize:
                                                                            12.sp),
                                                                  )),
                                                                  DataCell(Text(
                                                                    item.grade!,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: AppColors
                                                                            .colorBlack,
                                                                        fontSize:
                                                                            12.sp),
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
                                          );
                              }
                            },
                          ),
                      )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getCategories(List<Results>? data) {
    return data!.map((item) => item.studentReg!).toSet().toList();
  }

  List<Results> _getItemsForCategory(String category, List<Results>? data) {
    return data!.where((item) => item.studentReg! == category).toList();
  }
}
