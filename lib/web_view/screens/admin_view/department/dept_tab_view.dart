import 'package:flutter/material.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/department/filterd_student_list.dart';

import 'package:tabbar_gradient_indicator/tabbar_gradient_indicator.dart';

class DepartmentTabView extends StatelessWidget {
  const DepartmentTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.colorc7e,
              width: MediaQuery.sizeOf(context).width,

              // ignore: prefer_const_constructors
              child: TabBar(
                labelColor: AppColors.colorWhite,
                indicatorWeight: 4.0,
                indicator: const TabBarGradientIndicator(
                    gradientColor: [AppColors.colorWhite, AppColors.color582],
                    indicatorWidth: 2),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(text: "Students"),
                  Tab(text: "History"),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [FilteredStudentView(), Text("History")],
              ),
            )
          ],
        ));
  }
}
