import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

import 'package:rugst_alliance_academia/data/model/student/single_student_detail_model.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';

class SingleStudentStudyHistory extends StatefulWidget {
  final SingleStudentProfile studentData;
  const SingleStudentStudyHistory({super.key, required this.studentData});

  @override
  State<SingleStudentStudyHistory> createState() =>
      _SingleStudentStudyHistoryState();
}

class _SingleStudentStudyHistoryState extends State<SingleStudentStudyHistory> {
  @override
  Widget build(BuildContext context) {
    var data = widget.studentData.registeredCourse;

    return Container(
        color: AppColors.colorWhite,
        child: Column(
          children: [
            SizedBox(height: 10.h,),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _getCategories(data!).length,
                itemBuilder: (context, index) {
                  final category = _getCategories(data)[index];
                  final categoryItems = _getItemsForCategory(category, data);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.studentData.currentClassName == category
                            ? GlowText(
                                category,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.colorGreen),
                              )
                            : Text(
                                category,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 40, // Adjust column spacing as needed
                          // Adjust row height as needed
                          border: TableBorder.all(),
                          columns:  [
                            DataColumn(
                                label: Text(
                              'Course Name',
                              style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.color446,fontSize: 17.sp),
                              softWrap: true,
                            )),
                            DataColumn(
                                label: Text(
                              'Course Code',
                              style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.color446,fontSize: 17.sp),
                            )),
                            DataColumn(
                                label: Text(
                              'Batch',
                              style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.color446,fontSize: 17.sp),
                            )),
                            DataColumn(
                                label: Text(
                              'Credits',
                              style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.color446,fontSize: 17.sp),
                            )),
                          ],
                          rows: categoryItems
                              .map(
                                (item) => DataRow(
                                  cells: [
                                    DataCell(Text(
                                      item.courseName!.trim(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.colorBlack),
                                    )),
                                    DataCell(Text(
                                      item.courseCode!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.colorBlack),
                                    )),
                                    DataCell(Text(
                                      item.batch!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.colorBlack),
                                    )),
                                    DataCell(Text(
                                      item.courseCredits.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.colorBlack),
                                    )),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ));
  }

  List<String> _getCategories(List<RegisteredCourse>? data) {
    return data!.map((item) => item.className!).toSet().toList();
  }

  List<RegisteredCourse> _getItemsForCategory(
      String category, List<RegisteredCourse>? data) {
    return data!.where((item) => item.className! == category).toList();
  }
}
