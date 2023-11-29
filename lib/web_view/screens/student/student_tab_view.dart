import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';

import 'package:rugst_alliance_academia/web_view/screens/faculty/faculty_checkin_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_additional_info.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/study_history.dart';
import 'package:rugst_alliance_academia/widgets/app_indicator.dart';

class StudentTabView extends StatelessWidget {
  final int studentId;
  const StudentTabView({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.colorc7e,
              width: MediaQuery.sizeOf(context).width,

              // ignore: prefer_const_constructors
              child: TabBar(
                labelColor: AppColors.colorWhite,
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
                ],
              ),
            ),
             Expanded(
              child: TabBarView(
                children: [
                     StudentAdditionalInfoView(studentId: studentId),
               const FacultyCheckInView(),
                 StudyHistoryView(studentId: studentId,),
                  const Text("History"),
                   const Text("History")
                ],
              ),
            )
          ],
        ));
  }
}
