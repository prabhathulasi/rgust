import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';

import 'package:rugst_alliance_academia/web_view/screens/student/add_new_student/add_student_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_detailed_layout/student_detail_view.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/student_card.dart';

class StudentGridView extends StatefulWidget {
  const StudentGridView({super.key});

  @override
  State<StudentGridView> createState() => _StudentGridViewState();
}

class _StudentGridViewState extends State<StudentGridView> {
  showAddAlertDialog(BuildContext context) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Stack(
        children: [
          const AddStudentView(),
          Transform.translate(
            offset: Offset(10.w, -13.h),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  backgroundColor: AppColors.colorc7e,
                  radius: 14.0,
                  child: CircleAvatar(
                    radius: 12.0,
                    backgroundColor: AppColors.colorWhite ,
                    child: Icon(Icons.close, color: AppColors.colorRed),
                  ),
                ),
              ),
            ),
          )
        ],
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

  showDetailAlertDialog(BuildContext context, int studentId) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: StatefulBuilder(builder: (context, setState) {
        return Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          color: AppColors.colorWhite,
          child: Stack(
            children: [
              StudentDetailView(
                studentId: studentId,
              ),
              Transform.translate(
                offset: Offset(10.w, -13.h),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child:  Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 14.0.sp,
                        backgroundColor: AppColors.colorc7e,
                        child: CircleAvatar(
                          radius: 12.sp,
                          backgroundColor: AppColors.colorWhite,
                          child: const Icon(Icons.close, color: AppColors.colorRed)),
                      ),
                    )),
              )
            ],
          ),
        );
      }),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final GlobalKey<FormFieldState<String>> textFieldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
        double gridWidth =
                        374.w; // 2 items per row, with spacing
                    double aspectRatio = gridWidth /
                        440.h; // Calculating aspect ratio to get a fixed height of 242


    return Scaffold(
      body: Consumer<StudentProvider>(
        builder: (context, studentConsumer, child) {
          return Container(
            color: AppColors.colorWhite,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 300.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.colorc7e, width: 3.w),
                          borderRadius: BorderRadius.circular(8.sp)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 18.0.w, right: 18.w),
                        child: AppTextFormFieldWidget(
                          key: textFieldKey,
                          onChanged: (p0) {
                            studentConsumer.setEnableFilter(true);
                            studentConsumer.filterStudent(p0);
                          },
                          textStyle: GoogleFonts.oswald(
                              color: AppColors.colorBlack, fontSize: 15.sp),
                          inputDecoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.search,
                                color: AppColors.colorBlack,
                                size: 25.sp,
                              ),
                              border: InputBorder.none,
                              hintText: "Search by Name",
                              hintStyle: GoogleFonts.oswald(
                                  color: AppColors.colorBlack, fontSize: 15.sp)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          color: AppColors.color582,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        AppRichTextView(
                            title: "Regular",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold)
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          color: AppColors.contentColorYellow,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        AppRichTextView(
                            title: "Widthdraw",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold)
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          color: AppColors.colorRed,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        AppRichTextView(
                            title: "Dropout",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold)
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          color: AppColors.colorPurple,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        AppRichTextView(
                            title: "Transfer",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold)
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          color: AppColors.colorGrey,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        AppRichTextView(
                            title: "Clinical",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold)
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          color: AppColors.colorf85,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        AppRichTextView(
                            title: "Leaf of Absent",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold)
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                studentConsumer.filteredEnable == true
                    ? Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: studentConsumer.filteredList.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: size.width <= 1400 ? 4 : 6,
                              mainAxisSpacing: 5.0, // Adjust as needed
                              crossAxisSpacing: 5.0, // Adjust as needed
                         
                             childAspectRatio: aspectRatio,),
                          itemBuilder: (context, index) {
                            var studentData = studentConsumer.filteredList[index];
                            var memoryImagedata =
                                base64Decode(studentData.userImage!);
                            return InkWell(
                              onTap: () async {
                                showDetailAlertDialog(context, studentData.iD!);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.colorWhite,
                                      border: Border.all(
                                          color: AppColors.colorc7e, width: 3.w),
                                      borderRadius: BorderRadius.circular(15.sp)),
                                  child: StudentCardWidget(
                                    userImage: memoryImagedata,
                                    address: studentData.address!,
                                    citizenship: studentData.citizenship!,
                                    currentClass:studentData.currentProgramId == 300?"": studentData.currentClassName!,
                                    dob: studentData.dOB!,
                                    email: studentData.email!,
                                    mobileNumber:
                                        studentData.mobileNumber!.toString(),
                                    studentRegNo: studentData.studentRegiterNumber!,
                                    studentName: studentData.firstName! +
                                        studentData.lastName!,
                                    studentType: studentData.studentType!,
                                    program: studentData.currentProgramName!,
                                  )),
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: LayoutBuilder(builder: (context, constraints) {
                          return GridView.builder(
                            shrinkWrap: true,
                            itemCount:
                                studentConsumer.studentModel.studentList!.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    constraints.maxWidth <= 1400 ? 4 : 6,
                                    childAspectRatio: aspectRatio,
                                mainAxisSpacing: 5.0, // Adjust as needed
                                crossAxisSpacing: 5.0, // Adjust as needed
                                //  childAspectRatio:
                                // childAspectRatio: constraints.maxWidth <= 1400
                                //     ? 1 / 1.2
                                //     : 1 / 1.16
                                    ),
                            itemBuilder: (context, index) {
                              var studentData =
                                  studentConsumer.studentModel.studentList![index];
                              var memoryImagedata =
                                  base64Decode(studentData.userImage!);
          
                              return InkWell(
                                onTap: () {
                                  showDetailAlertDialog(context, studentData.iD!);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.colorWhite,
                                        border: Border.all(
                                            color: AppColors.colorc7e, width: 3.w),
                                        borderRadius: BorderRadius.circular(15.sp)),
                                    child: StudentCardWidget(
                                      userImage: memoryImagedata,
                                      address: studentData.address!,
                                      citizenship: studentData.citizenship!,
                                      currentClass: studentData.currentProgramId == 300? studentData.rotationName!: studentData.currentClassName!,
                                      dob: studentData.dOB!,
                                      email: studentData.email!,
                                      mobileNumber:
                                          studentData.mobileNumber!.toString(),
                                      studentRegNo:
                                          studentData.studentRegiterNumber!,
                                      studentName: studentData.firstName! +
                                          studentData.lastName!,
                                      studentType: studentData.studentType!,
                                      program: studentData.currentProgramName!,
                                    )),
                              );
                            },
                          );
                        }),
                      ),
              ],
            ),
          );
        }
      ),
      floatingActionButton: Consumer<ProgramProvider>(
        builder: (context, programConsumer, child) {
          return FloatingActionButton(
              elevation: 10.0,
              backgroundColor: AppColors.colorc7e,
              onPressed: () async {
                programConsumer.selectedDept = null;
                programConsumer.selectedClass = null;
                programConsumer.selectedBatch = null;
                programConsumer.selectedCourse = null;
          
                programConsumer.newData.clear();
                showAddAlertDialog(context);
              },
              child: const Icon(
                Icons.person_add_alt_1_outlined,
                color: AppColors.colorWhite,
              ));
        }
      ),
    );
  }
}
