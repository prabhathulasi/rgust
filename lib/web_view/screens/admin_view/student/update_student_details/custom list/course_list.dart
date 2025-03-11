import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  @override
  State<CourseList> createState() => _CourseListState();
}

List<int> selectedIDs = [];

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
        builder: (context, studentConsumer, child) {
      return Consumer<ProgramProvider>(
          builder: (context, programConsumer, child) {
        if (programConsumer.isLoading == true) {
          return const Center(
            child: SpinKitSpinningLines(color: AppColors.colorc7e),
          );
        } else {
          // List<RegisteredCourse>? registeredCourse = studentConsumer.studentDetailModel.studentDetail!.registeredCourse!;
          //  bool isClassRegistred = registeredCourse.any((course) => course.classId.toString() == programConsumer.selectedClass);
          //  if(isClassRegistred == true){
          //   return Center(
          //     child: AppRichTextView(
          //             maxLines: 2,
          //             title:
          //                 "The student is already registered the selected class",
          //             fontSize: 20.sp,
          //             fontWeight: FontWeight.bold,
          //             textColor: AppColors.colorRed,
          //           ),
          //   );
          //  }
          //  else{
          return Column(
            children: [
              programConsumer.coursesModel.courses!.isEmpty
                  ? AppRichTextView(
                      maxLines: 2,
                      title:
                          "No Course Found Kindly add the Course in the Department Section",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.colorRed,
                    )
                  : AppRichTextView(
                      title: "Course Pool",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.colorc7e,
                    ),
              programConsumer.coursesModel.courses!.isEmpty
                  ? Container()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.w,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppTextFormFieldWidget(
                              onChanged: (p0) {
                                programConsumer.setEnableFilter(true);
                                programConsumer.filterCourses(p0);
                              },
                              inputDecoration: const InputDecoration(
                                hintText: "Search Course Name",
                                prefixIcon: Icon(Icons.search),
                                hintStyle:
                                    TextStyle(color: AppColors.colorGrey),
                                enabled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.colorc7e, width: 3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.colorc7e, width: 3),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(height: 10.h),
                          programConsumer.filteredEnable == true
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      programConsumer.filteredCourse.length,
                                  itemBuilder: (context, index) {
                                    var currentItem =
                                        programConsumer.filteredCourse[index];
                                    int itemId = currentItem.iD!;

                                    return Card(
                                      color: AppColors.colorWhite,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          side: const BorderSide(
                                              color: AppColors.colorc7e,
                                              width: 2)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: selectedIDs.contains(itemId)
                                                ? AppColors.colorc7e
                                                    .withOpacity(0.3)
                                                : AppColors.colorWhite,
                                            border: Border.all(
                                                color: AppColors.colorc7e,
                                                width: 3.w),
                                            borderRadius:
                                                BorderRadius.circular(8.sp)),
                                        child: CheckboxListTile(
                                          isThreeLine: false,
                                          side:
                                              WidgetStateBorderSide.resolveWith(
                                            (states) => const BorderSide(
                                                width: 2.0,
                                                color: AppColors.colorc7e),
                                          ),
                                          checkColor: AppColors.colorc7e,
                                          activeColor: AppColors.colorWhite,
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppRichTextView(
                                                title: currentItem.courseName!
                                                    .trim(),
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor: AppColors.colorc7e,
                                              ),
                                              AppRichTextView(
                                                title: currentItem.courseId!,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w500,
                                                textColor: AppColors.colorc7e,
                                              ),
                                            ],
                                          ),
                                          value: selectedIDs.contains(itemId),
                                          onChanged: (value) {
                                            setState(() {
                                              if (value!) {
                                                // Add the selected ID to the list
                                                selectedIDs.add(itemId);
                                              } else {
                                                // Remove the ID if the checkbox is unchecked
                                                selectedIDs.remove(itemId);
                                              }
                                            });
                                            print(selectedIDs);
                                          },
                                        ),
                                      ),
                                    );
                                  })
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: programConsumer
                                      .coursesModel.courses!.length,
                                  itemBuilder: (context, index) {
                                    var currentItem = programConsumer
                                        .coursesModel.courses![index];
                                    int itemId = currentItem.iD!;

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: selectedIDs.contains(itemId)
                                                ? AppColors.colorc7e
                                                    .withOpacity(0.3)
                                                : AppColors.colorWhite,
                                            border: Border.all(
                                                color: AppColors.colorc7e,
                                                width: 3.w),
                                            borderRadius:
                                                BorderRadius.circular(8.sp)),
                                        child: CheckboxListTile(
                                          side:
                                              WidgetStateBorderSide.resolveWith(
                                            (states) => const BorderSide(
                                                width: 2.0,
                                                color: AppColors.colorc7e),
                                          ),
                                          checkColor: AppColors.colorc7e,
                                          activeColor: AppColors.colorWhite,
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppRichTextView(
                                                title: currentItem.courseName!
                                                    .trim(),
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor: AppColors.colorc7e,
                                              ),
                                              AppRichTextView(
                                                title: currentItem.courseId!,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w500,
                                                textColor: AppColors.colorc7e,
                                              ),
                                            ],
                                          ),
                                          value: selectedIDs.contains(itemId),
                                          onChanged: (value) {
                                            setState(() {
                                              if (value!) {
                                                // Add the selected ID to the list
                                                selectedIDs.add(itemId);
                                              } else {
                                                // Remove the ID if the checkbox is unchecked
                                                selectedIDs.remove(itemId);
                                              }
                                            });
                                            print(selectedIDs);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
            ],
          );
          //  }
        }
      });
    });
  }
}
