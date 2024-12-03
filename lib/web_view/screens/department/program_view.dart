import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/custom_plugin/commons/helper.dart';
import 'package:rugst_alliance_academia/custom_plugin/editable.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/clinical/clinical_course_model.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/batch_dropdown.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/class_dropdown.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/program_dropdown_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/year_dropdown_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class ProgramView extends StatefulWidget {
  const ProgramView({super.key});

  @override
  State<ProgramView> createState() => _ProgramViewState();
}

class _ProgramViewState extends State<ProgramView> {
  /// Create a Key for EditableState

  List rows = [];
  List cols = [
    {
      "title": 'Course Code',
      'widthFactor': 0.2,
      'key': 'coursecode',
    },
    {"title": 'Course Name', 'widthFactor': 0.2, 'key': 'coursename'},
    {"title": 'Credits', 'widthFactor': 0.2, 'key': 'credits'},
  ];
  List clinicalcols = [
    {
      "title": 'Rotations',
      'widthFactor': 0.2,
      'key': 'rotations',
    },
    {"title": 'Credits', 'widthFactor': 0.2, 'key': 'credits'},
    {"title": 'Duration (weeks)', 'widthFactor': 0.2, 'key': 'duration'},
  ];
  List clinicalRows = [];

  final _editableKey = GlobalKey<EditableState>();
  final _clinicaleditableKey = GlobalKey<EditableState>();
  final _noneditableKey = GlobalKey<EditableState>();

  List filterdcols = [];
  @override
  void initState() {
    addRow();
    filterdcols = [
      {
        "title": 'Course Code',
        'widthFactor': 0.15,
        'key': 'coursecode',
      },
      {"title": 'Course Name', 'widthFactor': 0.2, 'key': 'coursename'},
      {"title": 'Credits', 'widthFactor': 0.1, 'key': 'credits'},
      {
        "title": 'Assigned Lectures',
        'widthFactor': 0.2,
        'key': 'lectures',
        'editable': false
      },
    ];
    super.initState();
  }

  addRow() {
    rows = addOneRow(cols, rows);
    clinicalRows = addOneRow(clinicalcols, clinicalRows);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final programProvider = Provider.of<ProgramProvider>(context);

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(18.0.sp),
            child: Row(children: [
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
                      : programProvider.selectedDept == "300"
                          ? Container()
                          : AppRichTextView(
                              title: "Class",
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w500),
                  programProvider.selectedDept == "300"
                      ? Container()
                      : const ClassDropdown(isUpdatingStudent: false,),
                
                 
                  SizedBox(
                    height: 10.h,
                  ),
                  programProvider.selectedDept == "300"
                      ? Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    activeColor: AppColors.colorc7e,
                                    value: false,
                                    groupValue: programProvider.isCore,
                                    onChanged: (value) {
                                      programProvider
                                          .selectRotationType(value!);
                                    },
                                  ),
                                  AppRichTextView(
                                      title: "Core Rotation",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                  Radio(
                                    activeColor: AppColors.colorc7e,
                                    value: true,
                                    groupValue: programProvider.isCore,
                                    onChanged: (value) {
                                      programProvider
                                          .selectRotationType(value!);
                                    },
                                  ),
                                  AppRichTextView(
                                      title: "Elective Rotation",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ],
                              ),
                              Expanded(
                                child: Editable(
                                  key: _clinicaleditableKey,
                                  showRemoveIcon: true,
                                  columns: clinicalcols,
                                  rows: clinicalRows,
                                  zebraStripe: true,
                                  stripeColor1: Colors.blue[50]!,
                                  stripeColor2: Colors.grey[200]!,
                                  onRowSaved: (value) async {
                                    if (value == null) {
                                      ToastHelper().errorToast(
                                          "Please Fill the Required Field");
                                    } else if (value["rotations"] == null) {
                                      ToastHelper().errorToast(
                                          "Rotation Name is Required ");
                                    } else if (value["duration"] == null) {
                                      ToastHelper().errorToast(
                                          "Duration is Required ");
                                    } else if (value["credits"] == null) {
                                      ToastHelper()
                                          .errorToast("credits is Required ");
                                    } else {
                                      var token = await getTokenAndUseIt();
                                      if (token == null) {
                                        if (context.mounted) {
                                          Navigator.pushNamed(
                                              context, RouteNames.login);
                                        }
                                      } else if (token == "Token Expired") {
                                        ToastHelper().errorToast(
                                            "Session Expired Please Login Again");
              
                                        if (context.mounted) {
                                          Navigator.pushNamed(
                                              context, RouteNames.login);
                                        }
                                      } else {
                                        await programProvider
                                            .postClinicalCourse(token,
                                                duration: int.parse(
                                                  value["duration"],
                                                ),
                                                rotationName:
                                                    value["rotations"],
                                                credits: int.parse(
                                                    value["credits"]));
              
                                        clinicalRows = removeOneRow(
                                            clinicalRows,
                                            clinicalRows,
                                            clinicalRows[0]);
                                        programProvider.setCreateButton(true);
                                      }
                                    }
                                  },
                                  onSubmitted: (value) {
                                    print(value);
                                  },
                                  borderColor: Colors.blueGrey,
                                  tdStyle: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  trHeight: 40.h,
                                  removeIconColor: AppColors.colorRed,
              
                                  thStyle: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.colorWhite),
                                  thAlignment: TextAlign.center,
                                  thVertAlignment: CrossAxisAlignment.end,
                                  thPaddingBottom: 3,
                                  showSaveIcon: true,
                                  saveIconColor: AppColors.colorc7e,
                                  showCreateButton:
                                      programProvider.showCreateButton,
                                  tdAlignment: TextAlign.left,
                                  tdEditableMaxLines:
                                      100, // don't limit and allow data to wrap
                                  tdPaddingTop: 0,
                                  tdPaddingBottom: 14,
                                  tdPaddingLeft: 10,
                                  tdPaddingRight: 8,
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(0))),
                                ),
                              ),
                            ],
                          ),
                        )
                      : programProvider.selectedBatch == null
                          ? Container()
                          : Expanded(
                              child: Editable(
                                key: _editableKey,
                                showRemoveIcon: true,
                                columns: cols,
                                rows: rows,
                                zebraStripe: true,
                                stripeColor1: Colors.blue[50]!,
                                stripeColor2: Colors.grey[200]!,
                                onRowSaved: (value) async {
                                  if (value["coursename"] == null) {
                                    Fluttertoast.showToast(
                                        msg: "Course Name is Required ");
                                  } else if (value["coursecode"] == null) {
                                    Fluttertoast.showToast(
                                        msg: "Course Code is Required ");
                                  } else if (value["credits"] == null) {
                                    Fluttertoast.showToast(
                                        msg: "credits is Required ");
                                  } else {
                                    var token = await getTokenAndUseIt();
                                    if (token == null) {
                                      if (context.mounted) {
                                        Navigator.pushNamed(
                                            context, RouteNames.login);
                                      }
                                    } else if (token == "Token Expired") {
                                      ToastHelper().errorToast(
                                          "Session Expired Please Login Again");
              
                                      if (context.mounted) {
                                        Navigator.pushNamed(
                                            context, RouteNames.login);
                                      }
                                    } else {
                                      await programProvider.postCoursesList(
                                          token,
                                          courseName: value["coursename"],
                                          courseid: value["coursecode"],
                                          credits:
                                              int.parse(value["credits"]));
              
                                      rows =
                                          removeOneRow(cols, rows, rows[0]);
                                      programProvider.setCreateButton(true);
                                    }
                                  }
                                },
                                onSubmitted: (value) {
                                  print(value);
                                },
                                borderColor: Colors.blueGrey,
                                tdStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                trHeight: 40.h,
                                removeIconColor: AppColors.colorRed,
              
                                thStyle: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.colorWhite),
                                thAlignment: TextAlign.center,
                                thVertAlignment: CrossAxisAlignment.end,
                                thPaddingBottom: 3,
                                showSaveIcon: true,
                                saveIconColor: AppColors.colorc7e,
                                showCreateButton:
                                    programProvider.showCreateButton,
                                tdAlignment: TextAlign.left,
                                tdEditableMaxLines:
                                    100, // don't limit and allow data to wrap
                                tdPaddingTop: 0,
                                tdPaddingBottom: 14,
                                tdPaddingLeft: 10,
                                tdPaddingRight: 8,
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0))),
                              ),
                            )
                ],
              ),
              const VerticalDivider(
                color: AppColors.colorc7e,
              ),
              programProvider.selectedDept == "300"
                  ? Expanded(child: Consumer<ProgramProvider>(
                      builder: (context, clinicalConsumer, child) {
                        var data =
                            clinicalConsumer.clinicalCoursesModel.clinicals;

                        return data == null
                            ? const Text("No Clinical Records Found")
                            : ListView.builder(
                                itemCount: _getCategories(data).length,
                                itemBuilder: (context, index) {
                                  final category = _getCategories(data)[index];
                                  final categoryItems =
                                      _getItemsForCategory(category, data);
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AppRichTextView(
                                            title: "$category Rotation",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          columnSpacing:
                                              40, // Adjust column spacing as needed
                                          // Adjust row height as needed
                                          border: TableBorder.all(),
                                          columns: const [
                                            DataColumn(
                                                label: Text(
                                              'Rotation',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              softWrap: true,
                                            )),
                                            DataColumn(
                                                label: Text(
                                              'Credits',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              'Duration',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ],
                                          rows: categoryItems
                                              .map(
                                                (item) => DataRow(
                                                  cells: [
                                                    DataCell(Text(
                                                      item.rotationName!.trim(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .colorBlack),
                                                    )),
                                                    DataCell(Text(
                                                      item.rotationCredits
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .colorBlack),
                                                    )),
                                                    DataCell(Text(
                                                      item.rotationDuration
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .colorBlack),
                                                    )),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                      },
                    ))
                  : Expanded(
                      child: programProvider.newData.isEmpty
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppRichTextView(
                                    title: "Registered Course",
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w500),
                                SizedBox(
                                  height: 10.w,
                                ),
                                Builder(builder: (context) {
                                  return Expanded(
                                    
                                    child: Consumer<ProgramProvider>(builder:
                                        (context, departmentProvider, child) {
                                      return Editable(
                                        enabled: false,
                                        key: _noneditableKey,
                                        showRemoveIcon: false,
                                        columns: filterdcols,
                                        rows: departmentProvider.newData,
                                        zebraStripe: true,
                                        // stripeColor1: AppColors.colorc7e,
                                        // stripeColor2: AppColors.colorc7e,
                                        onRowSaved: (value) async {
                                          log(value);
                                          //   await departmentProvider.patchCoursesList(context,
                                          //  courseName: value["coursename"],
                                          // courseid: value["coursecode"],
                                          // credits: int.parse(value["credits"]));
                                        },
                                        onSubmitted: (value) {
                                          print(value);
                                        },

                                        borderColor: AppColors.colorc7e,
                                        tdStyle: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.colorBlack),
                                        trHeight: 100.h,
                                        thStyle: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.colorWhite),
                                        thAlignment: TextAlign.center,
                                        thVertAlignment: CrossAxisAlignment.end,
                                        thPaddingBottom: 3,
                                        showSaveIcon: false,
                                        saveIconColor: Colors.black,
                                        showCreateButton: false,
                                        tdAlignment: TextAlign.left,
                                        tdEditableMaxLines:
                                            100, // don't limit and allow data to wrap
                                        tdPaddingTop: 10.h,
                                        tdPaddingBottom: 14.h,
                                        tdPaddingLeft: 10.w,
                                        tdPaddingRight: 8.w,
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.blue),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(0))),
                                      );
                                    }),
                                  );
                                }),
                              ],
                            ),
                    ),
            ])));
  }

  List<String> _getCategories(List<Clinicals>? clinicals) {
    return clinicals!.map((item) => item.rotationType!).toSet().toList();
  }

  List<Clinicals> _getItemsForCategory(String category, List<Clinicals>? data) {
    return data!.where((item) => item.rotationType! == category).toList();
  }
}
