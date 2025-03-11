import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/faculty_account_creation.dart';

import 'package:rugst_alliance_academia/widgets/app_indicator.dart';

class AccountCreationView extends StatelessWidget {
  const AccountCreationView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.colorc7e,
          automaticallyImplyLeading: false,
          title: const Text("Create Accounts",style: TextStyle(color: AppColors.colorWhite,fontWeight: FontWeight.bold),),
          bottom:TabBar(
                labelColor: AppColors.colorWhite,
                indicatorWeight: 1.0,
                indicator: CustomTabIndicator(
                    color: AppColors.color582,
                    height: 3.h,
                    width: 40.w,
                    borderRadius: 10),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(text: "Faculty"),
                  Tab(text: "Student"),
                  Tab(text: "Staff"),
                ],
              ),
        ),
        body: const TabBarView(
          children: [
         FacultyAccountCreationView(),
            Text("History"),
            Text("History")
          ],
        ),
      ),
    );
  }
}
