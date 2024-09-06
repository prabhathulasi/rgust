import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class StaffCardWidget extends StatelessWidget {

  
  final String staffName;
final String joiningDate;
  final String staffType;
  final String mobileNumber;
  final String email;
  final String citizenship;
  final String dob;
final String gender;
  final String designation;
  final String address;
  final String pasportNumber;
  final Uint8List userImage;
  final String empStatus;

  const StaffCardWidget({super.key,
  required this.staffName,
required this.joiningDate,
  required this.staffType,
  required this.mobileNumber,
  required this.email,
  required this.citizenship,
  required this.dob,
 required this.gender,
  required this.designation,
  required this.address,
  required this.pasportNumber,
  required this.userImage,
  required this.empStatus
  });



  @override
  Widget build(BuildContext context) {


   
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding:  EdgeInsets.all(8.0.sp),
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top:4.0.h,right: 4.w),
                child: Align(alignment: Alignment.topRight,
                child: Container(
                          width: 10,
                          height: 10,
                          decoration:  BoxDecoration(
                            shape: BoxShape.circle,
                            color:empStatus=="Active"? staffType == "Full-Time"?AppColors.color582:AppColors.contentColorOrange: AppColors.colorRed,
                            boxShadow: [BoxShadow(
                color:empStatus=="Active"? staffType == "Full-Time"?AppColors.color582:AppColors.contentColorOrange: AppColors.colorRed,
                blurRadius: 10,
                spreadRadius: 5
                            )]
                          ),
                          
                        ),
                ),
              ),
              Center(
                child: CircleAvatar(
                  radius: 42.sp,
                  backgroundColor: AppColors.colorWhite,
                  child: CircleAvatar(
                    key: UniqueKey(),
                    radius: 40.sp,
                     backgroundImage: MemoryImage(userImage),
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppRichTextView(title: staffName,   fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                textColor: AppColors.colorWhite,),
                  const Icon(Icons.male,color: AppColors.colorWhite,)
                ],
              ),
        
        AppRichTextView(title: "$staffType staff",  fontSize: 12.sp,
            fontWeight: FontWeight.w800,
            textColor: AppColors.colorWhite,),
            SizedBox(height: 10.h,),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: AppRichTextView(title: "Mobile Number: ",   fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor:empStatus== "Active"? AppColors.colorGrey: AppColors.colorc7e,)),
             Expanded(
              flex: 2,child: AppRichTextView(title: mobileNumber,  fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.colorWhite,)),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 2,child: AppRichTextView(title: "Email Address: ",   fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor:empStatus== "Active"? AppColors.colorGrey: AppColors.colorc7e,)),
             Expanded(
              flex: 2,  child: AppRichTextView(title: email,  fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.colorWhite,)),
          ],
        ),
Row(
          children: [
             Expanded(
              flex: 2,child: AppRichTextView(title: "Citizenship: ",   fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor:empStatus== "Active"? AppColors.colorGrey: AppColors.colorc7e,)),
             Expanded(
              flex: 2,child: AppRichTextView(title: citizenship,  fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.colorWhite,)),
          ],
        ),
        Row(
          children: [
             Expanded(
              flex: 2,child: AppRichTextView(title: "DOB: ",   fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor:empStatus== "Active"? AppColors.colorGrey: AppColors.colorc7e,)),
             Expanded(
              flex: 2,child: AppRichTextView(title: dob,  fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.colorWhite,)),
          ],
        ),
        Row(
          children: [
             Expanded(
              flex: 2,child: AppRichTextView(title: "Joining Date: ",   fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor:empStatus== "Active"? AppColors.colorGrey: AppColors.colorc7e,)),
             Expanded(
              flex: 2,child: AppRichTextView(title: joiningDate,  fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.colorWhite,)),
          ],
        ),
        Row(
          children: [
             Expanded(
              flex: 2,child: AppRichTextView(title: "Class: ",   fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor:empStatus== "Active"? AppColors.colorGrey: AppColors.colorc7e,)),
             Expanded(
              flex: 2,child: AppRichTextView(title: designation,  fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.colorWhite,)),
          ],
        ),
        
        const Divider(
          color: AppColors.colorWhite,
        ),
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppRichTextView(title: "Passport Number: ",   fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor:empStatus== "Active"? AppColors.colorGrey: AppColors.colorc7e,),
            
            AppRichTextView(title: pasportNumber,   fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.colorWhite,),
          ],
        ),

        
            ],
          ),
        ),
      );
  }
}