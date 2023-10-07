import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';

import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class FacultyCardWidget extends StatelessWidget {
  final String userImage;
  final String facultyName;
  final String assignedSubject;
  final String facultyType;
  final String mobileNumber;
  final String email;
  final String citizenship;
  final String dob;
  final String gender;
  final String batch;

  final String address;
  final String pasportNumber;

  const FacultyCardWidget(
      {super.key,
      required this.facultyName,
      required this.userImage,
      required this.assignedSubject,
      required this.facultyType,
      required this.mobileNumber,
      required this.email,
      required this.citizenship,
      required this.dob,
      required this.gender,
      required this.batch,
      required this.address,
      required this.pasportNumber});

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
              Image.asset(ImagePath.webMDILogo),
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
              backgroundColor: AppColors.colorWhite,
              child: CircleAvatar(
                radius: 40.sp,
                backgroundImage: MemoryImage(base64Decode(userImage)),
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
                title: facultyName,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                textColor: AppColors.colorWhite,
              ),
              Icon(
                gender == "Male" ? Icons.male : Icons.female,
                color: AppColors.colorWhite,
              )
            ],
          ),
          Center(
              child: AppRichTextView(
            title: assignedSubject,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            textColor: AppColors.colorWhite,
          )),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: AppRichTextView(
                    title: "Batch: ",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.colorGrey,
                  )),
              Expanded(
                  flex: 2,
                  child: AppRichTextView(
                    title: batch,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.colorWhite,
                  )),
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: AppRichTextView(
                    title: "Mobile Number: ",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.colorGrey,
                  )),
              Expanded(
                  flex: 2,
                  child: AppRichTextView(
                    title: mobileNumber,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.colorWhite,
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
                    textColor: AppColors.colorGrey,
                  )),
              Expanded(
                  flex: 2,
                  child: AppRichTextView(
                    title: email,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.colorWhite,
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
                    textColor: AppColors.colorGrey,
                  )),
              Expanded(
                  flex: 2,
                  child: AppRichTextView(
                    title: citizenship,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.colorWhite,
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
                    textColor: AppColors.colorGrey,
                  )),
              Expanded(
                  flex: 2,
                  child: AppRichTextView(
                    title: dob,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.colorWhite,
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
                      textColor: AppColors.colorGrey,
                    )),
                Expanded(
                    flex: 2,
                    child: AppRichTextView(
                      title: address,
                      maxLines: 3,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      textColor: AppColors.colorWhite,
                    )),
              ],
            ),
          ),
          const Divider(
            color: AppColors.colorWhite,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppRichTextView(
                  title: "Passport Number: ",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  textColor: AppColors.colorGrey,
                ),
                AppRichTextView(
                  title: pasportNumber.toUpperCase(),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  textColor: AppColors.colorWhite,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
