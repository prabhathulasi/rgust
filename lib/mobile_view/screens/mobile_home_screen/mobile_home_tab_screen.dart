import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rugst_alliance_academia/data/model/student/single_student_detail_model.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/mobile_home_screen/mobile_exam_result_screen.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/mobile_home_screen/mobile_study_history_screen.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';



class MobileHomeTabScreen extends StatelessWidget {
  final SingleStudentProfile studentDetail;
  const MobileHomeTabScreen({super.key, required this.studentDetail});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
   tabAlignment: TabAlignment.start,
   isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
               physics: const NeverScrollableScrollPhysics(),
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
                Tab(text: "Profile"),
                Tab(text: "Settings"),
              ],
            ),
            Expanded(
              child: TabBarView(
                 physics: const NeverScrollableScrollPhysics(),
                children: [
                  MobileStudyHistoryScreen(studentData: studentDetail),
                  MobileExamResultScreen(studentData: studentDetail),
                  Container(),
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
