import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/student_course_model.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class StudyHistoryView extends StatefulWidget {
  final int studentId;
  const StudyHistoryView({super.key, required this.studentId});

  @override
  State<StudyHistoryView> createState() => _StudyHistoryViewState();
}

class _StudyHistoryViewState extends State<StudyHistoryView> {

   List _elements = [
  {'name': 'John', 'group': 'Team A'},
  {'name': 'Will', 'group': 'Team B'},
  {'name': 'Beth', 'group': 'Team A'},
  {'name': 'Miranda', 'group': 'Team B'},
  {'name': 'Mike', 'group': 'Team C'},
  {'name': 'Danny', 'group': 'Team C'},
];
  @override
  Widget build(BuildContext context) {


     final studentProvider = Provider.of<StudentProvider>(context,listen: false);
     Future getStudentCourses() async {
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
         var result = await studentProvider.getStudentCourses(widget.studentId, token);
         if(result =="Invalid Token"){
           ToastHelper().errorToast("Session Expired Please Login Again");
           if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }}
      }
    }
    return  Container(
      color: AppColors.colorc7e,
      child:FutureBuilder(
        future: getStudentCourses(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: SpinKitSpinningLines(
                color: AppColors.colorWhite,
                size: 20.sp,
              ),
            );
          }else{
            var data = studentProvider.studentRegisterCourseModel.studentCourses;
            Map<String, List<StudentCourses>> coursesByProgram = {};

          // Group courses by ProgramName
          for (var course in data!) {
            final programName = course.className!;
            if (!coursesByProgram.containsKey(programName)) {
              coursesByProgram[programName] = [];
            }
            coursesByProgram[programName]!.add(course);
          }

            
           return ListView.builder(
            itemCount:data.length,
            itemBuilder: (context, index) {
               final programNames = coursesByProgram.keys.toList();
                if (index >= programNames.length) {
      return const SizedBox(); // Return an empty SizedBox if index is out of range
    }
                String programName = coursesByProgram.keys.elementAt(index);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppRichTextView(
                      title: programName,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.colorWhite,
                    )
                  ),
                   SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: data
                          .map<Widget>((course) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 5.0,
                                  // Customize card appearance as needed
                                  child:Container(
                                 decoration: BoxDecoration(
                                  color: AppColors.colorWhite,
                                  borderRadius: BorderRadius.circular(10.sp)
                                 ),
                                    height: 300.h,
                                    width: 200.w,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Align(alignment: Alignment.topRight,
                                          child:Icon(Icons.check_circle,color: AppColors.colorGreen,size: 25.sp ,)
                                          ),
                                          const Spacer(),
                                          AppRichTextView(
                      title: course.courseName!,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.colorc7e,
                    ),
                    SizedBox(height: 5.h,),
                    AppRichTextView(
                      title: course.courseCode!,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.colorBlack,
                    ),
                    SizedBox(height: 5.h,),
                      AppRichTextView(
                      title: course.batch!,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.colorBlack,
                    ),
         
         const Spacer(),
               Row(
                       
                        children: [
                          Expanded(
                            child: AppRichTextView(
                            title: "Approved Date:",
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.colorBlack,
                                              ),
                          ),
                    Expanded(
                      child: AppRichTextView(
                        maxLines: 2,
                            title: DateFormat.yMMMEd().format(DateTime.parse(course.createdAt!)),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.colorBlack,
                      ),
                    ),
                        ],
                      ),
                      Row(
                  
                        children: [
                          Expanded(
                            child: AppRichTextView(
                            title: "Approved By:",
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.colorBlack,
                                              ),
                          ),
                    Expanded(
                      child: AppRichTextView(
                        maxLines: 2,
                            title: course.approvedBy!,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.colorBlack,
                      ),
                    ),
                        ],
                      ),
                                        ],
                                      ),
                                    ),
                                  )
                                ),
                              ))
                          .toList(),
                    ),)
                  ],
                );
            },
            );
          }
        },
      )
    );
  }
}