import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/faculty_model.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/faculty_attendance_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/faculty_tab_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/update_faculty_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class FacultyDetailView extends StatefulWidget {
  final FacultyList facultyDetail;
  const FacultyDetailView({super.key, required this.facultyDetail});

  @override
  State<FacultyDetailView> createState() => _FacultyDetailViewState();
}

class _FacultyDetailViewState extends State<FacultyDetailView> {


  showUpdateAlertDialog(BuildContext context, FacultyList details) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Stack(
        children: [
          UpdateFacultyView(facultyDetail: details),
          Transform.translate(
            offset: Offset(10.w, -13.h),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: AppColors.colorc7e,
                    child: Icon(Icons.close, color: AppColors.color582),
                  ),
                )),
          )
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final facultyData = widget.facultyDetail;
    final facultyProvider = Provider.of<FacultyProvider>(context);
    var size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: size.height * 0.4,
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
                                        base64Decode(facultyData.userImage!)),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 15,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.sp),
                                          boxShadow: [
                                            BoxShadow(
                                                color: facultyData.jobType ==
                                                        "Part-Time"
                                                    ? AppColors
                                                        .contentColorOrange
                                                    : facultyData.jobType ==
                                                            "Full-Time"
                                                        ? AppColors.color582
                                                        : AppColors.colorRed,
                                                blurRadius: 10,
                                                spreadRadius: 5)
                                          ]),
                                      child: InkWell(
                                        onTap: () {
                                          facultyProvider.updateJobType(false);
                                          facultyProvider.updateGender(false);
                                          showUpdateAlertDialog(
                                              context, facultyData);
                                        },
                                        child: CircleAvatar(
                                          radius: 15.sp,
                                          backgroundColor:
                                              facultyData.jobType == "Part-Time"
                                                  ? AppColors.contentColorOrange
                                                  : facultyData.jobType ==
                                                          "Full-Time"
                                                      ? AppColors.color582
                                                      : AppColors.colorRed,
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
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Tooltip(
                                    message: facultyData.mobile,
                                    child: const Icon(
                                      Icons.phone,
                                      color: AppColors.colorWhite,
                                    )),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Tooltip(
                                    message: facultyData.email,
                                    child: const Icon(
                                      Icons.mail,
                                      color: AppColors.colorWhite,
                                    )),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Tooltip(
                                    message: facultyData.dob,
                                    child: const Icon(
                                      Icons.cake,
                                      color: AppColors.colorWhite,
                                    ))
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
                                      title: facultyData.firstName! +
                                          facultyData.lastName!,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.colorWhite,
                                    ),
                                    Icon(
                                      facultyData.gender == "Male"
                                          ? Icons.male
                                          : Icons.female,
                                      color: AppColors.colorWhite,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      facultyData.registeredCourse!.length,
                                  itemBuilder: (context, index) {
                                    return AppRichTextView(
                                      title:
                                          "${facultyData.registeredCourse![index].courseName!} (${facultyData.registeredCourse![index].batch})",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w800,
                                      textColor: AppColors.colorWhite,
                                    );
                                  },
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
                                      title: facultyData.joiningDate!,
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
                                      title: "FacultyID: ",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w800,
                                      textColor: AppColors.colorGrey,
                                    ),
                                    AppRichTextView(
                                      title: facultyData.facultyId!,
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
                                      title: "Qualification: ",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w800,
                                      textColor: AppColors.colorGrey,
                                    ),
                                    AppRichTextView(
                                      title: facultyData.qualifiation!,
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
                                      title: facultyData.passportNumber!,
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
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 18.0.h),
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
                                    title: facultyData.address!,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w800,
                                    textColor: AppColors.colorWhite,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                      color: AppColors.colorc7e,
                      borderRadius: BorderRadius.circular(18.sp)),
                  child: FacultyAttendanceView(
                      facultyDetail: widget.facultyDetail),
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
            child: const FacultyTabView(),
          ))
        ],
      ),
    );
  }
}
