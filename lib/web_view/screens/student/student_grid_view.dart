import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/add_student_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_detail_view.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/student_card.dart';

class StudentGridView extends StatefulWidget {
  const StudentGridView({super.key});

  @override
  State<StudentGridView> createState() => _StudentGridViewState();
}

class _StudentGridViewState extends State<StudentGridView> {
  showAddAlertDialog(BuildContext context) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Stack(
        children: [
          const AddStudentView(),
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
    );
  }

  showDetailAlertDialog(BuildContext context, int studentId) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width * 0.68,
        color: AppColors.color0ec,
        child: Stack(
          children: [
            StudentDetailView(studentId:studentId ),
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
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  final GlobalKey<FormFieldState<String>> textFieldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
     final studentProvider =
        Provider.of<StudentProvider>(context);
    final programProvider = Provider.of<ProgramProvider>(context);

    return Scaffold(
      body: Container(
        color: AppColors.color0ec,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 300.w,
                  height: 54.h,
                  decoration: BoxDecoration(
                      color: AppColors.colorc7e,
                      borderRadius: BorderRadius.circular(10.sp)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 18.0.w, right: 18.w),
                    child: AppTextFormFieldWidget(
                      
                      key: textFieldKey,
                   
                      onChanged: (p0) {
                        studentProvider.setEnableFilter(true);
                        studentProvider.filterStudent(p0);
                      },
                      
                      textStyle: GoogleFonts.oswald(color: AppColors.colorWhite,fontSize: 15.sp),
                      inputDecoration: InputDecoration(
                        suffixIcon : Icon(Icons.search, color: AppColors.colorWhite,size: 25.sp,),
                          border: InputBorder.none,
                          
                          hintText: "Search by Name",
                          hintStyle:
                              GoogleFonts.oswald(color: AppColors.colorWhite,fontSize: 15.sp)),
                    ),
                  ),
                ),
                 SizedBox(
                   width: 10.w,
                 ),
                 Row(
                   children: [
                     Container(
                       height: 10,
                       width: 10,
                       color: AppColors.color582,
                     ),
                     SizedBox(
                       width: 5.w,
                     ),
                     AppRichTextView(
                         title: "Regular",
                         fontSize: 13.sp,
                         fontWeight: FontWeight.bold)
                   ],
                 ),
                 SizedBox(
                   width: 10.w,
                 ),
                 Row(
                   children: [
                     Container(
                       height: 10,
                       width: 10,
                       color: AppColors.contentColorYellow,
                     ),
                     SizedBox(
                       width: 5.w,
                     ),
                     AppRichTextView(
                         title: "Widthdraw",
                         fontSize: 13.sp,
                         fontWeight: FontWeight.bold)
                   ],
                 ),
                 SizedBox(
                   width: 10.w,
                 ),
                 Row(
                   children: [
                     Container(
                       height: 10,
                       width: 10,
                       color: AppColors.colorRed,
                     ),
                     SizedBox(
                       width: 5.w,
                     ),
                     AppRichTextView(
                         title: "Dropout",
                         fontSize: 13.sp,
                         fontWeight: FontWeight.bold)
                   ],
                 ),
                 SizedBox(
                   width: 10.w,
                 ),
                 Row(
                   children: [
                     Container(
                       height: 10,
                       width: 10,
                       color: AppColors.colorPurple,
                     ),
                     SizedBox(
                       width: 5.w,
                     ),
                     AppRichTextView(
                         title: "Transfer",
                         fontSize: 13.sp,
                         fontWeight: FontWeight.bold)
                   ],
                 ),
                 SizedBox(
                   width: 10.w,
                 ),
                 Row(
                   children: [
                     Container(
                       height: 10,
                       width: 10,
                       color: AppColors.colorGrey,
                     ),
                     SizedBox(
                       width: 5.w,
                     ),
                     AppRichTextView(
                         title: "Clinical",
                         fontSize: 13.sp,
                         fontWeight: FontWeight.bold)
                   ],
                 ),
                 SizedBox(
                   width: 10.w,
                 ),
                 Row(
                   children: [
                     Container(
                       height: 10,
                       width: 10,
                       color: AppColors.colorf85,
                     ),
                     SizedBox(
                       width: 5.w,
                     ),
                     AppRichTextView(
                         title: "Leaf of Absent",
                         fontSize: 13.sp,
                         fontWeight: FontWeight.bold)
                   ],
                 ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
         studentProvider.filteredEnable == true? 
            Expanded(child: GridView.builder(
                shrinkWrap: true,
                itemCount: studentProvider.filteredList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size.width <= 1400 ? 4 : 6,
                    //  childAspectRatio:
                    childAspectRatio: size.width <= 1400 ? 1 / 1 : 1 / 1.3),
                itemBuilder: (context, index) {
                  var studentData =
                     studentProvider.filteredList[index];
                     var memoryImagedata = base64Decode(studentData.userImage!);
                  return InkWell(
                    onTap: () async{
        
                      showDetailAlertDialog(context, studentData.iD!);
                    },
                    child: Card(
                      color: AppColors.colorc7e,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.sp)),
                      child: StudentCardWidget(
                        userImage: memoryImagedata,
                        address: studentData.address!,
                        citizenship: studentData.citizenship!,
                        currentClass: studentData.currentClassName!,
                        dob: studentData.dOB!,
                        email: studentData.email!,
                        mobileNumber: studentData.mobileNumber!.toString(),
                        studentRegNo: studentData.studentRegiterNumber!,
                        studentName: studentData.firstName!+studentData.lastName!,
                        studentType: studentData.studentType!,
                       
                        program: studentData.currentProgramName!,


                      )
                    ),
                  );
                },
              ),):
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: studentProvider.studentModel.studentList!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size.width <= 1400 ? 4 : 6,
                    //  childAspectRatio:
                    childAspectRatio: size.width <= 1400 ? 1 / 1 : 1 / 1.3),
                itemBuilder: (context, index) {



                  var studentData =
                      studentProvider.studentModel.studentList![index];
                       var memoryImagedata = base64Decode(studentData.userImage!);
String abbreviatedText1 = abbreviateString(studentData.currentClassName!);


                  return InkWell(
                    onTap: () {
                      showDetailAlertDialog(context, studentData.iD!);
                    },
                    child: Card(
                      color: AppColors.colorc7e,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.sp)),
                      child: StudentCardWidget(
                        userImage: memoryImagedata,
                        address: studentData.address!,
                        citizenship: studentData.citizenship!,
                        currentClass: studentData.currentClassName!,
                        dob: studentData.dOB!,
                        email: studentData.email!,
                        mobileNumber: studentData.mobileNumber!.toString(),
                        studentRegNo: studentData.studentRegiterNumber!,
                        studentName: studentData.firstName!+studentData.lastName!,
                        studentType: studentData.studentType!,
                       
                        program: studentData.currentProgramName!,
                                            
                                            
                      )
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
          backgroundColor: AppColors.colorc7e,
          onPressed: () async {
            programProvider.selectedDept = null;
            programProvider.selectedClass = null;
            programProvider.selectedBatch = null;
            programProvider.selectedCourse = null;
           
            programProvider.newData.clear();
            showAddAlertDialog(context);
          },
          child: const Icon(
            Icons.person_add_alt_1_outlined,
            color: AppColors.colorWhite,
          )),
    );
  }
}
