

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';




class CourseDropDown extends StatefulWidget {
  const CourseDropDown({super.key});

  @override
  State<CourseDropDown> createState() => _ClassDropdownState();
}

class _ClassDropdownState extends State<CourseDropDown> {
  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.sizeOf(context);

     final programProvider = Provider.of<ProgramProvider>(context);
        return programProvider.newData.isEmpty
                           ?   Container(   color: AppColors.color927,
                               height: 60.h,
                               width: size.width * 0.2,
                               child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:  EdgeInsets.only(left:8.0.w),
                                  child: AppRichTextView(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700,
                                                title: "Please Select the Course",
                                                textColor: AppColors.colorWhite,
                                               ),
                                ),
                               ),
                               ) 
                           : Consumer<ProgramProvider>(
                             builder: (context, programProvider, child) {
                               return Container(
                                   color: AppColors.color927,
                                   height: 60.h,
                                   width: size.width * 0.2,
                                   child: Padding(
                                     padding: EdgeInsets.all(8.0.sp),
                                     child: DropdownButtonHideUnderline(
                                       child: DropdownButton(
                                         iconDisabledColor: AppColors.colorWhite,
                                         dropdownColor: AppColors.color927,
                                         isExpanded: true,
                                         value: programProvider.selectedCourse,
                                         items: programProvider.newData
                                             .map((dynamic programClass) {
                                           return DropdownMenuItem<String>(
                                             value: programClass["coursecode"],
                                             child: Align(
                                              alignment: Alignment.topLeft,
                                               child: AppRichTextView(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700,
                                                title: programClass["coursename"],
                                                textColor: AppColors.colorWhite,
                                               ),
                                             ),
                                             

                                             
                                            //  child: Text(programClass.className!,
                                            //      style: const TextStyle(
                                            //          color: AppColors.colorWhite)),
                                           );
                                         }).toList(),
                                         hint: AppRichTextView(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700,
                                              title: "Please Select the Class",
                                              textColor: AppColors.colorWhite,
                                             ),
                                         onChanged: (String? value) {
                                           programProvider.setSelectedCourse(value!);
                                         
                                           // deptProvider.selectedBatch = null;
                                         },
                                       ),
                                     ),
                                   ),
                                 );
                             }
                           );
      
 
  }
}