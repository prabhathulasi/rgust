import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';

import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/faculty_checkin_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/invoice/student_invoice_screen.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/result/exam_result_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/payment/invoice_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/settings/settings_tab_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/documents/student_additional_info.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/study_history/study_history.dart';
import 'package:rugst_alliance_academia/widgets/app_indicator.dart';

class StudentTabView extends StatelessWidget {
  final StudentDetail studentDetail;
  const StudentTabView({super.key, required this.studentDetail});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.colorWhite,
                  border: Border.all(color: AppColors.colorc7e, width: 3.w)),
              width: MediaQuery.sizeOf(context).width,

              // ignore: prefer_const_constructors
              child: TabBar(
                isScrollable: false,
                unselectedLabelColor: AppColors.colorBlack,
                labelColor: AppColors.colorc7e,
                labelStyle: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, fontSize: 15.sp),
                unselectedLabelStyle: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600, fontSize: 13.sp),
                indicatorColor: Colors.transparent,
                indicatorWeight: 1.0,
                tabs: const [
                  Tab(text: "Additional Documents"),
                  Tab(text: "Attendance"),
                  Tab(text: "Study History"),
                  Tab(text: "Results"),
                  Tab(text: "Invoice"),
                  Tab(text: "Payments"),
                  Tab(text: "Settings"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  StudentAdditionalInfoView(studentDetail: studentDetail),
                  const FacultyCheckInView(),
                  StudyHistoryView(
                    studentData: studentDetail,
                  ),
                  ExamResult(studentData: studentDetail),
                   Studentinvoicescreen(studentData:studentDetail,),
                  StudentPaymentView(
                    studentData: studentDetail,
                  ),
                  SettingsTabView(
                    studentDetail: studentDetail,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
