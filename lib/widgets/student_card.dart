import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class StudentCardWidget extends StatelessWidget {
  final String studentName;

  final String studentType;
  final String mobileNumber;
  final String email;
  final String citizenship;
  final String dob;
  final String program;
  final String currentClass;
  final String address;
  final String studentRegNo;
  final Uint8List userImage;

  const StudentCardWidget(
      {super.key,
      required this.studentName,
      required this.studentType,
      required this.mobileNumber,
      required this.email,
      required this.citizenship,
      required this.dob,
      required this.program,
      required this.currentClass,
      required this.address,
      required this.studentRegNo,
      required this.userImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 4.0.h, right: 4.w),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: studentType == "Regular"
                          ? AppColors.color582
                          : AppColors.colorPurple,
                      boxShadow: [
                        BoxShadow(
                            color: studentType == "Regular"
                                ? AppColors.color582
                                : AppColors.colorPurple,
                            blurRadius: 10,
                            spreadRadius: 5)
                      ]),
                ),
              ),
            ),
            Center(
              child: CircleAvatar(
                radius: 40.sp,
                backgroundColor: AppColors.colorWhite,
                child: CircleAvatar(
                  key: UniqueKey(),
                  radius: 38.sp,
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
                Flexible(
                  child: AppRichTextView(
                    maxLines: 2,
                    title: studentName,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.colorWhite,
                  ),
                ),
                const Icon(
                  Icons.male,
                  color: AppColors.colorWhite,
                )
              ],
            ),
            AppRichTextView(
              title: "$studentType Student",
              fontSize: 12.sp,
              fontWeight: FontWeight.w800,
              textColor: AppColors.colorWhite,
            ),
            SizedBox(
              height: 10.h,
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
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: AppRichTextView(
                      title: "Program: ",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      textColor: AppColors.colorGrey,
                    )),
                Expanded(
                    flex: 2,
                    child: AppRichTextView(
                      title: program,
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
                      title: "Class: ",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      textColor: AppColors.colorGrey,
                    )),
                Expanded(
                    flex: 2,
                    child: AppRichTextView(
                      title: currentClass,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      textColor: AppColors.colorWhite,
                    )),
              ],
            ),
            const Divider(
              color: AppColors.colorWhite,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AppRichTextView(
                    title: "Registration Number: ",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.colorGrey,
                  ),
                ),
                Expanded(
                  child: AppRichTextView(
                    maxLines: 2,
                    title: studentRegNo,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.colorWhite,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
