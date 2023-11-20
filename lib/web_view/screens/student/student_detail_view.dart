import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/data/model/student_model.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_tab_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class StudentDetailView extends StatefulWidget {
  final StudentList studentDetails;
  const StudentDetailView({super.key, required this.studentDetails});

  @override
  State<StudentDetailView> createState() => _FacultyDetailViewState();
}

class _FacultyDetailViewState extends State<StudentDetailView> {
  String? password;
  





  @override
  Widget build(BuildContext context) {
    final studentData = widget.studentDetails;

    return Container(
      color: AppColors.color0ec,
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 339.h,
                  width: 734.w,
                  decoration: BoxDecoration(
                      color: AppColors.colorc7e,
                      borderRadius: BorderRadius.circular(18.sp)),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0.w),
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 80.sp,
                                    backgroundImage: MemoryImage(
                                        base64Decode(studentData.userImage!)),
                                  ),
                                  Transform.translate(
                                    offset: Offset(130.w, 150.h),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25.sp),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: AppColors.color582,
                                                           
                                                blurRadius: 10,
                                                spreadRadius: 5)
                                          ]),
                                      child: InkWell(
                                        onTap: () {
                                        //  facultyProvider.updateJobType(false);
                                        //  facultyProvider.updateGender(false);
                                        //  showAddAlertDialog(context, facultyData);
                                        },
                                        child: CircleAvatar(
                                          radius: 15.sp,
                                          backgroundColor:
                                             AppColors.color582,
                                                     
                                          child: Center(
                                            child: Icon(
                                              Icons.edit,
                                              size: 20.sp,
                                              color: AppColors.colorWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            Row(
                              children: [
                                Tooltip(
                                 
                                
                                  message:studentData.mobileNumber.toString() ,
                                  child: const Icon(Icons.phone,color: AppColors.colorWhite,)),
                                SizedBox(width: 5.w,),
                                Tooltip(
                                  message: studentData.email,
                                  child: const Icon(Icons.mail,color: AppColors.colorWhite,)),
                                SizedBox(width: 5.w,),
                                Tooltip(
                                  message: studentData.dOB,
                                  child: const Icon(Icons.cake,color: AppColors.colorWhite,))
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 18.0.h, left: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    AppRichTextView(
                                      title: studentData.firstName! +
                                          studentData.lastName!,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.colorWhite,
                                    ),
                                     Icon(
                 studentData.gender == "Male" ? Icons.male : Icons.female,
                  color: AppColors.colorWhite,
                )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              
                               
                              Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppRichTextView(
                                title: "Student Type: ",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorGrey,
                              ),
                              AppRichTextView(
                                title:studentData.studentType!,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorWhite,
                              ),
                            ],
                          ),
                                        SizedBox(
                                  height: 10.h,
                                ),
                               Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppRichTextView(
                                title: "Current Class: ",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorGrey,
                              ),
                              AppRichTextView(
                                title:studentData.currentClassName!,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorWhite,
                              ),
                            ],
                          ),
                                
                           
                                             SizedBox(
                                  height: 10.h,
                                ),
                                            Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppRichTextView(
                                title: "Joining Date: ",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorGrey,
                              ),
                              AppRichTextView(
                                title: studentData.admissionDate!,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorWhite,
                              ),
                            ],
                          ),
                           SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              AppRichTextView(
                                title: "Student Id: ",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorGrey,
                              ),
                              AppRichTextView(
                                title: studentData.studentRegiterNumber!,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorWhite,
                              ),
                            ],
                          ),
                           SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              AppRichTextView(
                                title: "Emergency Contact Number: ",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorGrey,
                              ),
                              AppRichTextView(
                                title: studentData.emergencyContact!.toString(),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorWhite,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              AppRichTextView(
                                title: "Passport Number: ",
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorGrey,
                              ),
                              AppRichTextView(
                                title: studentData.passportNumber!,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorWhite,
                              ),
                            ],
                          ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(child:  Padding(
                          padding:  EdgeInsets.only(top:18.0.h),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppRichTextView(
                                  title: "Address: ",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                Flexible(
                                  child: AppRichTextView(
                                    maxLines: 3,
                                    title: studentData.address!,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w800,
                                    textColor: AppColors.colorWhite,
                                  ),
                                ),
                              ],
                            ),
                        ),)
    
                       
                     
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Container(
                    height: 339.h,
                    decoration: BoxDecoration(
                        color: AppColors.colorc7e,
                        borderRadius: BorderRadius.circular(18.sp)),
                        // child: const FacultyAttendanceView(),
                 
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Expanded(
                child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(18.sp)),
              child:  StudentTabView(
                studentId: studentData.iD!,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
