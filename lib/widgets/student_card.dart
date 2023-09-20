import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class StudentCardWidget extends StatelessWidget {

  
  final String studentName;
  final String studentStatus;
  final String studentType;
  final String mobileNumber;
  final String email;
  final String citizenship;
  final String dob;
  final String program;
  final String currentClass;
  final String address;
  final String pasportNumber;

  const StudentCardWidget({super.key,
  required this.studentName,
  required this.studentStatus,
  required this.studentType,
  required this.mobileNumber,
  required this.email,
  required this.citizenship,
  required this.dob,
  required this.program, 
  required this.currentClass,
  required this.address,
  required this.pasportNumber
  });



  @override
  Widget build(BuildContext context) {
 List<Color> predefinedColors = [
  AppColors.color582,
 AppColors.contentColorYellow,
  AppColors.colorRed,
AppColors.colorPurple,
  Colors.purple,
  AppColors.colorGrey,
  AppColors.colorf85,
  // Add more colors as needed
];
    // Generate a random index
    Random random = Random();
    int randomIndex = random.nextInt(predefinedColors.length);

    // Get the random color from the list
    Color randomColor = predefinedColors[randomIndex];

   
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
                            color: randomColor,
                            boxShadow: [BoxShadow(
                color:randomColor,
                blurRadius: 10,
                spreadRadius: 5
                            )]
                          ),
                          
                        ),
                ),
              ),
              CircleAvatar(
                radius: 40.sp,
                backgroundImage:const AssetImage(ImagePath.webtestLogo,),
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppRichTextView(title: studentName, fontSize: 16.sp, fontWeight: FontWeight.bold,textColor: AppColors.colorWhite,),
                  const Icon(Icons.male,color: AppColors.colorWhite,)
                ],
              ),
        
        AppRichTextView(title: studentType, fontSize: 13.sp, fontWeight: FontWeight.w600,textColor: AppColors.colorWhite,),
        Row(
          children: [
            AppRichTextView(title: "Mobile Number: ", fontSize: 12.sp, fontWeight: FontWeight.w500,textColor: AppColors.colorWhite,),
            AppRichTextView(title: mobileNumber, fontSize: 10.sp, fontWeight: FontWeight.w400,textColor: AppColors.colorWhite,),
          ],
        ),
        Row(
          children: [
            AppRichTextView(title: "Email Address: ", fontSize: 12.sp, fontWeight: FontWeight.w500,textColor: AppColors.colorWhite,),
            AppRichTextView(title: email, fontSize: 10.sp, fontWeight: FontWeight.w400,textColor: AppColors.colorWhite,),
          ],
        ),
Row(
          children: [
            AppRichTextView(title: "Citizenship: ", fontSize: 12.sp, fontWeight: FontWeight.w500,textColor: AppColors.colorWhite,),
            AppRichTextView(title: citizenship, fontSize: 10.sp, fontWeight: FontWeight.w400,textColor: AppColors.colorWhite,),
          ],
        ),
        Row(
          children: [
            AppRichTextView(title: "DOB: ", fontSize: 12.sp, fontWeight: FontWeight.w500,textColor: AppColors.colorWhite,),
            AppRichTextView(title: dob, fontSize: 10.sp, fontWeight: FontWeight.w400,textColor: AppColors.colorWhite,),
          ],
        ),
        Row(
          children: [
            AppRichTextView(title: "Program: ", fontSize: 12.sp, fontWeight: FontWeight.w500,textColor: AppColors.colorWhite,),
            AppRichTextView(title: program, fontSize: 10.sp, fontWeight: FontWeight.w400,textColor: AppColors.colorWhite,),
          ],
        ),
        Row(
          children: [
            AppRichTextView(title: "Class: ", fontSize: 12.sp, fontWeight: FontWeight.w500,textColor: AppColors.colorWhite,),
            AppRichTextView(title: currentClass, fontSize: 10.sp, fontWeight: FontWeight.w400,textColor: AppColors.colorWhite,),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppRichTextView(title: "Address: ", fontSize: 12.sp, fontWeight: FontWeight.w500,textColor: AppColors.colorWhite,),
            
            Flexible(child: AppRichTextView(title: address, maxLines: 3, fontSize: 10.sp, fontWeight: FontWeight.w400,textColor: AppColors.colorWhite,)),
          ],
        ),
        const Divider(
          color: AppColors.colorWhite,
        ),
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppRichTextView(title: "Passport Number: ", fontSize: 12.sp, fontWeight: FontWeight.w500,textColor: AppColors.colorWhite,),
            
            AppRichTextView(title: pasportNumber,  fontSize: 10.sp, fontWeight: FontWeight.w400,textColor: AppColors.colorWhite,),
          ],
        ),

        
            ],
          ),
        ),
      );
  }
}