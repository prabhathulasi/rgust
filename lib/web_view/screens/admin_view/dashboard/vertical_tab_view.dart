import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/admission/admission_list_view.dart';

import 'package:rugst_alliance_academia/web_view/screens/admin_view/dashboard/overview_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/department/program_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/faculty_list_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/fees/fees_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/result/result_settings_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/staffs/staff_list_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_list_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_vertical_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html';

class VerticalTabView extends StatefulWidget {
  const VerticalTabView({
    super.key,
  });

  @override
  VerticalTabViewState createState() => VerticalTabViewState();
}

class VerticalTabViewState extends State<VerticalTabView> {
  String? userName;
  getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userName = sharedPreferences.getString("username");
    });
  }

  @override
  void initState() {
    getUserName();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: VerticalTabs(
        footer: Padding(
          padding: EdgeInsets.only(bottom: 18.0.h),
          child: InkWell(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.clear();
              if (context.mounted) {
                window.history.pushState(null, '', "/");
                Navigator.of(context)
                    .popUntil((route) => route.settings.name == '/');
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppRichTextView(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  title: "Logout",
                  textColor: AppColors.colorc7e,
                ),
                SizedBox(
                  width: 20.w,
                ),
                const Icon(
                  Icons.logout,
                  color: AppColors.colorc7e,
                )
              ],
            ),
          ),
        ),
        selectedTabTextStyle: TextStyle(
            color: AppColors.colorc7e,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp),
        tabTextStyle: const TextStyle(
          color: AppColors.colorBlack,
          fontWeight: FontWeight.bold,
        ),
        tabBackgroundColor: AppColors.colorWhite,
        selectedTabBackgroundColor: AppColors.colorc7e,
        tabsWidth: 250.w,
        direction: TextDirection.ltr,
        contentScrollAxis: Axis.vertical,
        changePageDuration: const Duration(milliseconds: 500),
        header: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.colorc7e,
            child: Center(
              child: AppRichTextView(
                fontSize: 20.sp,
                textColor: AppColors.colorWhite,
                fontWeight: FontWeight.bold,
                title: userName?[0] ?? "A",
              ),
            ),
          ),
          title: AppRichTextView(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            title: userName ?? "Admin",
            textColor: AppColors.colorc7e,
          ),
        ),
        tabs: <Tab>[
          Tab(
            text: "Dashboard",
            icon: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: OverflowBox(
                    maxHeight: 80.h,
                    maxWidth: 80.w,
                    child: Lottie.asset(LottiePath.dashboardLottie,
                        repeat: false))),
          ),
          Tab(
            text: "Student",
            icon: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: OverflowBox(
                  maxHeight: 80.h,
                  maxWidth: 80.w,
                  child:
                      Lottie.asset(LottiePath.dstudentLottie, repeat: false)),
            ),
          ),
          Tab(
            text: "Staff",
            icon: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: OverflowBox(
                  maxHeight: 60.h,
                  maxWidth: 60.w,
                  child: Lottie.asset(LottiePath.dstaffLottie, repeat: false)),
            ),
          ),
          Tab(
            text: "Faculty",
            icon: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: OverflowBox(
                  maxHeight: 60.h,
                  maxWidth: 60.w,
                  child:
                      Lottie.asset(LottiePath.dfacultyLottie, repeat: false)),
            ),
          ),
          Tab(
            text: "Department",
            icon: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Lottie.asset(LottiePath.deptLottie),
            ),
          ),
          Tab(
            text: "Admission",
            icon: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: OverflowBox(
                  maxHeight: 80.h,
                  maxWidth: 80.w,
                  child: Lottie.asset(LottiePath.admissionLottie,repeat: false)),
            ),
          ),
          // Tab(
          //   text: "Leave Request",
          //   icon: CircleAvatar(
          //     backgroundColor: Colors.transparent,
          //     child: Lottie.asset(LottiePath.leaveReqLottie),
          //   ),
          // ),
          // const Tab(
          //   text: "E-library",
          //   icon: CircleAvatar(
          //     backgroundImage: AssetImage(
          //       ImagePath.webelibfLogo,
          //     ),
          //   ),
          // ),
          // Tab(
          //   text: "Notification",
          //   icon: CircleAvatar(
          //     backgroundColor: Colors.transparent,
          //     child: OverflowBox(
          //         maxHeight: 100.h,
          //         maxWidth: 100.w,
          //         child: Lottie.asset(LottiePath.notificationLottie)),
          //   ),
          // ),
          // Tab(
          //     text: "Create Account",
          //     icon: CircleAvatar(
          //       backgroundColor: Colors.transparent,
          //       child: OverflowBox(
          //           maxHeight: 100.h,
          //           maxWidth: 100.w,
          //           child: Lottie.asset(LottiePath.createAccountLottie)),
          //     )),
          const Tab(
            text: "Fees Structure",
            icon: CircleAvatar(
              child: Icon(
                Icons.attach_money_outlined,
                color: AppColors.colorc7e,
              ),
            ),
          ),
          const Tab(
            text: "Results",
            icon: CircleAvatar(child: Icon(Icons.checklist_sharp)),
          ),
        ],
        contents: const <Widget>[
          OverviewView(),
          StudentListView(),
          StaffListView(),
          FacultyListView(),
          ProgramView(),
          AdmissionListView(),
         
          FeesView(),
          ResultSettingsView(),
        ],
      ),
    );
  }

  Widget tabsContent(String caption, [String description = '']) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      color: Colors.black12,
      child: Column(
        children: <Widget>[
          Text(
            caption,
            style: const TextStyle(fontSize: 25),
          ),
          const Divider(
            height: 20,
            color: Colors.black45,
          ),
          Text(
            description,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
