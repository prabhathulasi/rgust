


import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_to_pdf/export_delegate.dart';
import 'package:flutter_to_pdf/export_frame.dart';
import 'dart:html' as html;
import 'package:rugst_alliance_academia/data/model/media_file_model.dart';
import 'package:rugst_alliance_academia/data/model/student_model.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';


class StudentPersonalProfile extends StatefulWidget {
  final  List<Files>? files;
  final StudentList? studentData;
  const StudentPersonalProfile({super.key, this.files, this.studentData});

  @override
  State<StudentPersonalProfile> createState() => _StudentPersonalProfileState();
}

class _StudentPersonalProfileState extends State<StudentPersonalProfile> {
 final ExportDelegate exportDelegate = ExportDelegate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    ImagePath.webrgustLogo,
                    width: 120.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: AppRichTextView(
                        maxLines: 2,
                        title:
                            "Rajiv Gandhi University of Science and Technology",
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              AppRichTextView(
                  maxLines: 2,
                  title: "Student's Personal File".toUpperCase(),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: 10.h,
              ),
              AppRichTextView(
                  maxLines: 2,
                  title: "Personal Information".toUpperCase(),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: 30.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 400.w,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppRichTextView(
                            title: "Student's Name:",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        flex: 2,
                        child: AppRichTextView(
                            title: widget.studentData!.firstName! + widget.studentData!.lastName!,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 400.w,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppRichTextView(
                            title: "Date of Birth:",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        flex: 2,
                        child: AppRichTextView(
                            title: widget.studentData!.dOB! ,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 400.w,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppRichTextView(
                            title: "Date of Admission:",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        flex: 2,
                        child: AppRichTextView(
                            title:  widget.studentData!.admissionDate!,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 400.w,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppRichTextView(
                            title: "Program",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        flex: 2,
                        child: AppRichTextView(
                            title:  widget.studentData!.currentProgramName!,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 400.w,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppRichTextView(
                            title: "Class",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        flex: 2,
                        child: AppRichTextView(
                            title:  widget.studentData!.currentClassName!,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(
              height: 30.h,
            ),
               AppRichTextView(
                    maxLines: 2,
                    title: "Submitted Documents".toUpperCase(), fontSize: 15.sp, fontWeight: FontWeight.bold),
                SizedBox(
              height: 20.h,
            ),    
             Expanded(
               child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.files!.length,
                itemBuilder: (context, index) {
                  var data = widget.files![index];
                  return Card(
                    child: ListTile(
                      title: AppRichTextView(title:data.name! ,fontSize: 15.sp,fontWeight: FontWeight.w500,textColor: AppColors.colorBlack),
                      trailing: const Icon(Icons.check_circle_outline,color: AppColors.colorGreen,),
                    ),
                  );
                },
               ),
             )
      
            ],
          ),
        ),
     
    );
  }
}
