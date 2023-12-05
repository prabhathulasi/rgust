import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/student_course_model.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class StudentRegistedCourse extends StatefulWidget {
  final int studentId;
  const StudentRegistedCourse({super.key, required this.studentId});

  @override
  State<StudentRegistedCourse> createState() => _StudentRegistedCourseState();
}

class _StudentRegistedCourseState extends State<StudentRegistedCourse> {
  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
      final studentCourseDetail =
        Provider.of<StudentProvider>(context, listen: false);

         Future getStudentCourseDetails() async {
      var token = await getTokenAndUseIt();
      if (token == null) {
        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }
      } else if (token == "Token Expired") {
        ToastHelper().errorToast("Session Expired Please Login Again");

        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }
      } else {
        var result = await studentCourseDetail.getStudentCourses(widget.studentId,token );
         if(result =="Invalid Token"){
           ToastHelper().errorToast("Session Expired Please Login Again");
           if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }}
      }
    }

    return  Scaffold(
      backgroundColor: AppColors.color0ec,
       body: FutureBuilder(
        future: getStudentCourseDetails(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: SpinKitSpinningLines(color: AppColors.colorc7e),
            );
          }else{
           return Column(
            children: [
              // Container(
              //                   color: AppColors.colorc7e,
              //                   height: 70.h,
              //                   width: size.width * 0.2,
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         AppRichTextView(
              //                             title: "Current Program",
              //                             textColor: AppColors.colorWhite,
              //                             fontSize: 14.sp,
              //                             fontWeight: FontWeight.w500),
              //                         Expanded(
              //                             child: AppTextFormFieldWidget(
              //                           initialValue:
              //                              ,
              //                           textStyle: GoogleFonts.roboto(
              //                               color: AppColors.colorWhite, fontSize: 15.sp),
              //                           onSaved: (p0) {
              //                             facultyProvider.setLastName(p0!);
              //                           },
              //                           inputDecoration: const InputDecoration(
              //                               border: InputBorder.none,
              //                               hintStyle: TextStyle(
              //                                   color: AppColors.colorGrey)),
              //                           obscureText: false,
              //                         )),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
            ],
           );
    //        var data = studentCourseDetail.studentRegisterCourseModel.studentCourses;
    //         Map<String, List<StudentCourses>> coursesByProgram = {};

    //       // Group courses by ProgramName
    //       for (var course in data!) {
    //         final programName = course.className!;
    //         if (!coursesByProgram.containsKey(programName)) {
    //           coursesByProgram[programName] = [];
    //         }
    //         coursesByProgram[programName]!.add(course);
    //       }
    //       return ListView.builder(
    //         itemCount: data.length,
    //         itemBuilder: (context, index) {
    //             final programNames = coursesByProgram.keys.toList();
    //             if (index >= programNames.length) {
    //   return const SizedBox(); // Return an empty SizedBox if index is out of range
    // }
    //             String programName = coursesByProgram.keys.elementAt(index);
    //           return Card(
    //             elevation: 5.0,
    //             child: ExpansionTile(
    //               title: AppRichTextView(
    //                 title: programName,
    //                 fontSize: 18.sp,
    //                 fontWeight: FontWeight.bold,
    //                 textColor: AppColors.colorc7e,
                    
    //               ),
    //               children: data.map((e) {
    //                 return Padding(
    //                   padding: const EdgeInsets.all(18.0),
    //                   child: Row(
    //                     children: [
    //                       AppRichTextView(title: e.courseCode!, fontSize: 15.sp, fontWeight: FontWeight.w600,textColor: AppColors.colorBlack,),
    //                       AppRichTextView(title: e.courseName!, fontSize: 15.sp, fontWeight: FontWeight.w600,textColor: AppColors.colorBlack,),
    //                     ],
    //                   ),
    //                 );
    //               }).toList(),
    //             ),
    //           );
    //         },
    //       );

          }
        },
       )
    );
  }
}