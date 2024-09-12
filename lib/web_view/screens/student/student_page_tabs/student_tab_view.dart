import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';


import 'package:rugst_alliance_academia/theme/app_colors.dart';

import 'package:rugst_alliance_academia/web_view/screens/faculty/faculty_checkin_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_page_tabs/result/exam_result_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_page_tabs/invoice/invoice_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_page_tabs/settings/settings_tab_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_page_tabs/documents/student_additional_info.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_page_tabs/study_history/study_history.dart';
import 'package:rugst_alliance_academia/widgets/app_indicator.dart';

class StudentTabView extends StatelessWidget {
  final StudentDetail studentDetail;
  const StudentTabView({super.key, required this.studentDetail});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.colorc7e,
              width: MediaQuery.sizeOf(context).width,

              // ignore: prefer_const_constructors
              child: TabBar(
                unselectedLabelColor: AppColors.colorWhite,
                labelColor: AppColors.color582,
                indicatorWeight: 1.0,

                indicator: CustomTabIndicator(
                    color: AppColors.color582,
                    height: 1.h,
                    width: 60.w,
                    borderRadius: 10),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                   Tab(text: "Additional Documents"),
                  Tab(text: "Attendance"),
                  Tab(text: "Study History"),
                  Tab(text: "Results"),
                  Tab(text: "Invoice"),
                  Tab(text: "Settings"),
                ],
              ),
            ),
             Expanded(
              child: TabBarView(
                children: [
                     StudentAdditionalInfoView(studentDetail: studentDetail),
               const FacultyCheckInView(),
                 StudyHistoryView(studentData: studentDetail,),
                ExamResult(studentData: studentDetail),
                   StudentInvoiceView(studentId: studentDetail.iD!,fullTutionFee: studentDetail.fullTutionFee!),
                    SettingsTabView(studentDetail: studentDetail,)
                ],
              ),
            )
          ],
        ));
  }
}
