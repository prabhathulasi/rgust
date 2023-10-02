import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';

import 'package:rugst_alliance_academia/web_view/screens/faculty/faculty_attendance_view.dart';
import 'package:rugst_alliance_academia/widgets/app_indicator.dart';

class FacultyTabView extends StatelessWidget {
  const FacultyTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
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
                    height: 10.h,
                    width: 40.w,
                    borderRadius: 10),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(text: "Attendance"),
                  Tab(text: "Leave Request"),
                  Tab(text: "Feedback"),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  FacultyAttendanceView(),
                  Text("History"),
                  Text("History")
                ],
              ),
            )
          ],
        ));
  }
}
