import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/data/model/staff_model.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';

import 'package:rugst_alliance_academia/web_view/screens/staffs/staff_checkin_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/staffs/staff_settings_tab_view.dart';
import 'package:rugst_alliance_academia/widgets/app_indicator.dart';

class StaffTabView extends StatelessWidget {
  final StaffList staffDetail;
  const StaffTabView({super.key, required this.staffDetail});

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
                unselectedLabelColor: AppColors.colorWhite,
                labelColor: AppColors.color582,
                indicatorWeight: 1.0,
               indicatorColor: AppColors.color582,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(text: "Attendance"),
                  Tab(text: "Leave Request"),
                  Tab(text: "Settings"),
                ],
              ),
            ),
             Expanded(
              child: TabBarView(
                children: [
              const StaffCheckinView(),
                  const Text("History"),
                  StaffSettingsTabView(staffDetail: staffDetail,)
                ],
              ),
            )
          ],
        ));
  }
}
