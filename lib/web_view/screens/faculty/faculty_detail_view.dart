import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/web_view/screens/faculty/faculty_tab_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class FacultyDetailView extends StatefulWidget {
  const FacultyDetailView({super.key});

  @override
  State<FacultyDetailView> createState() => _FacultyDetailViewState();
}

class _FacultyDetailViewState extends State<FacultyDetailView> {
  @override
  Widget build(BuildContext context) {
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
                            ),
                            Transform.translate(
                              offset: Offset(130.w,130.h),
                              child: Container(
                                decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.sp),
                                        color: AppColors.color582,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: AppColors.color582,
                                              blurRadius: 10,
                                              spreadRadius: 5)
                                        ]),
                                child: CircleAvatar(
                                  radius: 15.sp,
                                backgroundColor: AppColors.color582,
                                child: Center(
                                  child: Icon(Icons.edit,size: 20.sp,color: AppColors.color927,),
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
                                  title: "Prabhakaran Thulasi",
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
                                      color: AppColors.color582,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: AppColors.color582,
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
                                  title: "September-2023",
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
                                  title: "Male",
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
                                  title: "Prabha709@gmail.com",
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
                                  title: "+917305822599",
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
                                  title: "02/04/1996",
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
                        child: CircleAvatar(
                          radius: 60.sp,
                         backgroundImage: const AssetImage(ImagePath.webrgustLogo),
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
                                  title: "17/02/2023",
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
                                  title: "2023/0100/001",
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
                                  title: "English -I",
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
                                  title: "Bachelor of Engineering",
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
                                  title: "s0123456",
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
                                    title: "No.22 gangai amman street urappakkam, chennai, TamilNadu, India",
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
