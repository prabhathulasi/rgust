import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rugst_alliance_academia/data/model/faculty_model.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';

import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class FacultyCardWidget extends StatelessWidget {
  final int index;
  final Uint8List userImage;
  final String facultyName;
  final List<RegisteredCourse>? registeredCourse;
  final String facultyType;
  final String mobileNumber;
  final String email;
  final String citizenship;
  final String dob;
  final String gender;
  final void Function() onTap;
  final bool isMultipleCourse;

  final String address;
  final String pasportNumber;

  const FacultyCardWidget(
      {super.key,
      required this.index,
      required this.facultyName,
      required this.userImage,
      required this.facultyType,
      required this.mobileNumber,
      required this.email,
      required this.citizenship,
      required this.dob,
      required this.gender,
      required this.registeredCourse,
      required this.address,
      required this.pasportNumber,
      required this.onTap,
      required this.isMultipleCourse});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isMultipleCourse == true
                  ? Image.asset(ImagePath.webMDILogo)
                  : Container(),
              Padding(
                padding: EdgeInsets.only(top: 4.0.h, right: 4.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: facultyType == "Part-Time"
                            ? AppColors.contentColorOrange
                            : facultyType == "Full-Time"
                                ? AppColors.color582
                                : AppColors.colorRed,
                        boxShadow: [
                          BoxShadow(
                              color: facultyType == "Part-Time"
                                  ? AppColors.contentColorOrange
                                  : facultyType == "Full-Time"
                                      ? AppColors.color582
                                      : AppColors.colorRed,
                              blurRadius: 10,
                              spreadRadius: 5)
                        ]),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: CircleAvatar(
              radius: 42.sp,
              backgroundColor: facultyType == "Part-Time"
                  ? AppColors.contentColorOrange
                  : facultyType == "Full-Time"
                      ? AppColors.color582
                      : AppColors.colorRed,
              child: CircleAvatar(
                key: UniqueKey(),
                radius: 40.sp,
                backgroundImage: MemoryImage(userImage),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppRichTextView(
                title: facultyName.toUpperCase(),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                textColor: AppColors.color0ec,
              ),
              Icon(
                gender == "Male" ? Icons.male : Icons.female,
                color: AppColors.color0ec,
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
              flex: 2,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: registeredCourse!.length,
                itemBuilder: (context, index) {
                  return AppRichTextView(
                    title:
                        "${registeredCourse![index].courseName!} (${registeredCourse![index].batch})",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.color0ec,
                  );
                },
              )),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: AppRichTextView(
                    title: "Mobile Number: ",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.color7ff,
                  )),
              Expanded(
                  flex: 2,
                  child: AppRichTextView(
                    title: mobileNumber,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.color0ec,
                  )),
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: AppRichTextView(
                    title: "Email Address: ",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.color7ff,
                  )),
              Expanded(
                  flex: 2,
                  child: AppRichTextView(
                    title: email,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.color0ec,
                  )),
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: AppRichTextView(
                    title: "Citizenship: ",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.color7ff,
                  )),
              Expanded(
                  flex: 2,
                  child: AppRichTextView(
                    title: citizenship,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.color0ec,
                  )),
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: AppRichTextView(
                    title: "DOB: ",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.color7ff,
                  )),
              Expanded(
                  flex: 2,
                  child: AppRichTextView(
                    title: dob,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.color0ec,
                  )),
            ],
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: AppRichTextView(
                      maxLines: 1,
                      title: "Address: ",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      textColor: AppColors.color7ff,
                    )),
                Expanded(
                    flex: 2,
                    child: AppRichTextView(
                      title: address,
                      maxLines: 3,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      textColor: AppColors.color0ec,
                    )),
              ],
            ),
          ),
          const Divider(
            color: AppColors.color0ec,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppRichTextView(
                  title: "Passport Number: ",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  textColor: AppColors.color7ff,
                ),
                AppRichTextView(
                  title: pasportNumber.toUpperCase(),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  textColor: AppColors.color0ec,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
