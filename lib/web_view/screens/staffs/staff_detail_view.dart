import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/staff_model.dart';
import 'package:rugst_alliance_academia/data/provider/staff_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/staffs/staff_tab_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class StaffDetailView extends StatelessWidget {
  final StaffList staffDetails;
  const StaffDetailView({super.key, required this.staffDetails});



  showUpdateAlertDialog(BuildContext context, StaffList details) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Stack(
        children: [
          // UpdateFacultyView(facultyDetail: details),
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
    final staffData = staffDetails;
  final staffProvider = Provider.of<StaffProvider>(context);
    var size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Container(
              width: size.width *0.5,
              decoration: BoxDecoration(
                  color: AppColors.colorc7e,
                  borderRadius: BorderRadius.circular(18.sp)),
              child: Padding(
                padding: EdgeInsets.all(18.0.sp),
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
                                    base64Decode(staffData.userImage!)),
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
                                            color: staffData.empStatus=="Active"? staffData.jobType == "Full-Time"?AppColors.color582:AppColors.contentColorOrange: AppColors.colorRed,
                                            blurRadius: 10,
                                            spreadRadius: 5)
                                      ]),
                                  child: InkWell(
                                    onTap: () {
                                      // facultyProvider.updateJobType(false);
                                      // facultyProvider.updateGender(false);
                                      // showUpdateAlertDialog(
                                      //     context, staffData);
                                    },
                                    child: CircleAvatar(
                                      radius: 15.sp,
                                      backgroundColor:
                                         staffData.empStatus=="Active"? staffData.jobType == "Full-Time"?AppColors.color582:AppColors.contentColorOrange: AppColors.colorRed,
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
                                message: staffData.mobile,
                                child: const Icon(
                                  Icons.phone,
                                  color: AppColors.colorWhite,
                                )),
                            SizedBox(
                              width: 5.w,
                            ),
                            Tooltip(
                                message: staffData.email,
                                child: const Icon(
                                  Icons.mail,
                                  color: AppColors.colorWhite,
                                )),
                            SizedBox(
                              width: 5.w,
                            ),
                            Tooltip(
                                message: staffData.dob,
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
                                  title: staffData.firstName! +
                                      staffData.lastName!,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  textColor: AppColors.colorWhite,
                                ),
                                SizedBox(width: 15.w,),
                                Icon(
                                  staffData.gender == "Male"
                                      ? Icons.male
                                      : Icons.female,
                                  color: AppColors.colorWhite,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                       
                              Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppRichTextView(
                                  title: "Employment Type: ",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title: staffData.jobType!,
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
                                  title: staffData.joiningDate!,
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
                                  title: staffData.staffId!,
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
                                  title: staffData.qualifiation!,
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
                                  title: staffData.passportNumber!,
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
                                title: staffData.address!,
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
            height: 8.h,
          ),
          Expanded(
              child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(18.sp)),
             child:  StaffTabView(
              staffDetail:staffData ,
             ),
          ))
        ],
      ),
    );
  }
}