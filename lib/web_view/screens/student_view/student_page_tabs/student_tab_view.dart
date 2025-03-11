import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rugst_alliance_academia/data/model/student/single_student_detail_model.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/student_view/student_page_tabs/result/single_student_exam_result_view.dart';

import 'package:rugst_alliance_academia/web_view/screens/student_view/student_page_tabs/study_history/single_student_study_history.dart';

class SingleStudentTabs extends StatelessWidget {
  final SingleStudentProfile studentDetail;
  const SingleStudentTabs({super.key, required this.studentDetail});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: false,
              unselectedLabelColor: AppColors.colorBlack,
              labelColor: AppColors.colorWhite,
              labelStyle: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold, fontSize: 15.sp),
              unselectedLabelStyle: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600, fontSize: 13.sp),
              indicatorColor: AppColors.color446,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.color446),
              indicatorWeight: 1.0,
              tabs: const [
                Tab(text: "Study History"),
                Tab(text: "Results"),
                Tab(text: "Payments"),
                Tab(text: "Settings"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleStudentStudyHistory(studentData: studentDetail),
                  SingleStudentExamResultView(studentData: studentDetail),
                  Container(),
                  Container(),
                  // StudentAdditionalInfoView(studentDetail: studentDetail),
                  // StudyHistoryView(
                  //   studentData: studentDetail,
                  // ),
                  // ExamResult(studentData: studentDetail),
                  // StudentInvoiceView(
                  //   studentData: studentDetail,
                  // ),
                ],
              ),
            )
          ],
        ));
  }
}
