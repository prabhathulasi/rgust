import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

import 'package:rugst_alliance_academia/data/model/student/single_student_detail_model.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';

class MobileStudyHistoryScreen extends StatefulWidget {
  final SingleStudentProfile studentData;
  const MobileStudyHistoryScreen({super.key, required this.studentData});

  @override
  State<MobileStudyHistoryScreen> createState() =>
      _MobileStudyHistoryScreenState();
}

class _MobileStudyHistoryScreenState extends State<MobileStudyHistoryScreen> {
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
                                style:  TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.colorGreen),
                              )
                            : Text(
                                category,
                                style:  TextStyle(
                                    fontSize: 15.sp, fontWeight: FontWeight.bold),
                              ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          showBottomBorder: false,
                          columnSpacing: 20, // Adjust column spacing as needed
                          // Adjust row height as needed
                          border: const TableBorder.symmetric(outside: BorderSide(color: AppColors.colorBlack)),
                          columns:  [
                            DataColumn(
                                label: Text(
                              'Course Name',
                              style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.color446,fontSize: 14.sp),
                              softWrap: true,
                            )),
                            DataColumn(
                                label: Text(
                              'Course Code',
                              style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.color446,fontSize: 14.sp),
                            )),
                            DataColumn(
                                label: Text(
                              'Batch',
                              style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.color446,fontSize: 14.sp),
                            )),
                            DataColumn(
                                label: Text(
                              'Credits',
                              style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.color446,fontSize: 14.sp),
                            )),
                          ],
                          rows: categoryItems
                              .map(
                                (item) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                      
                                      softWrap: true,
                                      item.courseName!.trim(),
                                      style:  TextStyle(
                                        fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.colorBlack),
                                    )),
                                    DataCell(Text(
                                      item.courseCode!,
                                      style:  TextStyle(
                                              fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.colorBlack),
                                    )),
                                    DataCell(Text(
                                      item.batch!,
                                      style:  TextStyle(
                                              fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.colorBlack),
                                    )),
                                    DataCell(
                                      
                                      Text(
                                        
                                      item.courseCredits.toString(),
                                      style:  TextStyle(
                                              fontSize: 12.sp,
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
