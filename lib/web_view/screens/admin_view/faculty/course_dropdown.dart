import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class FacultyCourseList extends StatefulWidget {
  const FacultyCourseList({super.key});

  @override
  State<FacultyCourseList> createState() => _FacultyCourseListState();
}



class _FacultyCourseListState extends State<FacultyCourseList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProgramProvider>(
      builder: (context, programConsumer, child) {
        if (programConsumer.isLoading == true) {
          return const Center(
            child: SpinKitSpinningLines(color: AppColors.colorc7e),
          );
        } else {
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
              if (programConsumer.coursesModel.courses!.isNotEmpty)
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10.w),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppTextFormFieldWidget(
                          onChanged: (value) {
                            programConsumer.setEnableFilter(true);
                            programConsumer.filterCourses(value);
                          },
                          inputDecoration: const InputDecoration(
                            hintText: "Search Course Name",
                            prefixIcon: Icon(Icons.search),
                            hintStyle: TextStyle(color: AppColors.colorGrey),
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.colorc7e, width: 3),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.colorc7e, width: 3),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: programConsumer.filteredEnable
                            ? programConsumer.filteredCourse.length
                            : programConsumer.coursesModel.courses!.length,
                        itemBuilder: (context, index) {
                          var course = programConsumer.filteredEnable
                              ? programConsumer.filteredCourse[index]
                              : programConsumer.coursesModel.courses![index];
                          int itemId = course.iD!;
    
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: programConsumer.selectedFacultyCourseId == itemId
                                    ? AppColors.colorc7e.withOpacity(0.3)
                                    : AppColors.colorWhite,
                                border: Border.all(
                                  color: AppColors.colorc7e,
                                  width: 3.w,
                                ),
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                              child: RadioListTile<int>(
                                value: itemId,
                                groupValue: programConsumer.selectedFacultyCourseId,
                                onChanged: (value) {
                               programConsumer.setSelectedFacultyCourseId(value!);
                                  },
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                      title: course.courseName!.trim(),
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.colorc7e,
                                    ),
                                    AppRichTextView(
                                      title: course.courseId!,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      textColor: AppColors.colorc7e,
                                    ),
                                  ],
                                ),
                                activeColor: AppColors.colorc7e,
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
        }
      },
    );
  }
}
