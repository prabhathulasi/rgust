import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/data/model/faculty_model.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/web_view/screens/faculty/faculty_tab_view.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class FacultyDetailView extends StatefulWidget {
  final FacultyList facultyDetail;
  const FacultyDetailView({super.key, required this.facultyDetail});

  @override
  State<FacultyDetailView> createState() => _FacultyDetailViewState();
}

class _FacultyDetailViewState extends State<FacultyDetailView> {

  @override
  Widget build(BuildContext context) {
    final facultyData = widget.facultyDetail;
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 339.h,
                width: 734.w,
                decoration: BoxDecoration(
                    color: AppColors.color927,
                    borderRadius: BorderRadius.circular(18.sp)),
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0.w),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 80.sp,
                              backgroundImage: MemoryImage(base64Decode(facultyData.userImage!)),
                            ),
                            Transform.translate(
                              offset: Offset(130.w,130.h),
                              child: Container(
                                decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.sp),
                                       
                                        boxShadow:  [
                                          BoxShadow(
                                              color: facultyData.jobType =="Part-Time"? AppColors.contentColorOrange : facultyData.jobType =="Full-Time"?  AppColors.color582: AppColors.colorRed,
                                              blurRadius: 10,
                                              spreadRadius: 5)
                                        ]),
                                child: CircleAvatar(
                                  radius: 15.sp,
                                backgroundColor: facultyData.jobType =="Part-Time"? AppColors.contentColorOrange : facultyData.jobType =="Full-Time"?  AppColors.color582: AppColors.colorRed,
                                child: Center(
                                  child: Icon(Icons.edit,size: 20.sp,color: AppColors.colorWhite,),
                                ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 18.0.h,left: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AppRichTextView(
                                  title: facultyData.firstName!+ facultyData.lastName! ,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  textColor: AppColors.colorWhite,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Container(
                                  width: 117,
                                  height: 43,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(25.sp),
                                      color: facultyData.jobType =="Part-Time"? AppColors.contentColorOrange : facultyData.jobType =="Full-Time"?  AppColors.color582: AppColors.colorRed,
                                      boxShadow:  [
                                        BoxShadow(
                                            color: facultyData.jobType =="Part-Time"? AppColors.contentColorOrange : facultyData.jobType =="Full-Time"?  AppColors.color582: AppColors.colorRed,
                                            blurRadius: 10,
                                            spreadRadius: 5)
                                      ]),
                                  child: Center(
                                      child: AppRichTextView(
                                    title: "Full-Time",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    textColor: AppColors.colorWhite,
                                  )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                AppRichTextView(
                                  title: "Batch: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title: facultyData.batch!,
                                  fontSize: 20.sp,
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
                                  title: "Gender: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title: facultyData.gender!,
                                  fontSize: 20.sp,
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
                                  title: "Email: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title: facultyData.email!,
                                  fontSize: 20.sp,
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
                                  title: "Phone: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title: facultyData.mobile!,
                                  fontSize: 20.sp,
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
                                  title: "DOB: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title: facultyData.dob!,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorWhite,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              radius: 60.sp,
                             backgroundImage: const AssetImage(ImagePath.webrgustLogo),
                            ),
                            SizedBox(height: 10.h,),
                            AppElevatedButon(title: "Create Account",
                            buttonColor: facultyData.jobType =="Part-Time"? AppColors.contentColorOrange : facultyData.jobType =="Full-Time"?  AppColors.color582: AppColors.colorRed,
                            height: 40.h,
                            width: 180.w,
                            textColor: AppColors.colorWhite,
                            onPressed: (context) {
                              
                            },
                            )
                          ],
                        ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Container(
                height: 339.h,
                width: 544.w,
                decoration: BoxDecoration(
                    color: AppColors.color927,
                    borderRadius: BorderRadius.circular(18.sp)),
                    child: Padding(
                      padding:  EdgeInsets.all(18.0.sp),
                      child: Column(
                        children: [
                          Row(
                              children: [
                                AppRichTextView(
                                  title: "Joining Date: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title: facultyData.joiningDate!,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorWhite,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h,),
                            Row(
                              children: [
                                AppRichTextView(
                                  title: "FacultyID: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title: facultyData.facultyId!,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorWhite,
                                ),
                              ],
                            ),
                           
                            SizedBox(height: 10.h,),
                            Row(
                              children: [
                                AppRichTextView(
                                  title: "Course Assigned: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title: facultyData.courseName!,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorWhite,
                                ),
                              ],
                            ),
                              SizedBox(height: 10.h,),
                            Row(
                              children: [
                                AppRichTextView(
                                  title: "Qualification: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title:facultyData.qualifiation!,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorWhite,
                                ),
                              ],
                            ),
                              SizedBox(height: 10.h,),
                            Row(
                              children: [
                                AppRichTextView(
                                  title: "Passport Number: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title: facultyData.passportNumber!,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorWhite,
                                ),
                              ],
                            ),

 SizedBox(height: 10.h,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppRichTextView(
                                  title: "Address: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                Flexible(
                                  child: AppRichTextView(
                                    maxLines: 3,
                                    title: facultyData.address!,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w800,
                                    textColor: AppColors.colorWhite,
                                  ),
                                ),
                              ],
                            ),

                        ],
                      ),
                    ),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
               
                borderRadius: BorderRadius.circular(18.sp)),
               child: const FacultyTabView(
              
               ), 
          ))
        ],
      ),
    );
  }
}
