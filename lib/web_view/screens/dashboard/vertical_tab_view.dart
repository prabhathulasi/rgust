import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';
import 'package:rugst_alliance_academia/web_view/screens/dashboard/overview_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/program_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/faculty/faculty_list_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_list_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_vertical_tab.dart';



class VerticalTabView extends StatefulWidget {
  const VerticalTabView({super.key});

  @override
  _VerticalTabViewState createState() => _VerticalTabViewState();
  
}

class _VerticalTabViewState extends State<VerticalTabView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: VerticalTabs(
        selectedTabTextStyle: TextStyle(color: AppColors.colorc7e,fontWeight: FontWeight.bold,fontSize: 20.sp),
        tabTextStyle: const TextStyle(color: AppColors.color0ec,fontWeight: FontWeight.bold,),
          tabBackgroundColor: AppColors.colorc7e,
          selectedTabBackgroundColor: AppColors.color0ec,
          
          tabsWidth: 250.w,
          direction: TextDirection.ltr,
          contentScrollAxis: Axis.vertical,
          changePageDuration: const Duration(milliseconds: 500),
          header: ListTile(
            leading: CircleAvatar(
              child: Center(
                child: AppRichTextView(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  title: "A",
                ),
              ),
            ),
            title: AppRichTextView(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              title: "ADMIN",
              textColor: AppColors.color0ec,
            ),
          ),
          tabs: const <Tab>[
 
            Tab(
            text: "Dashboard",
            icon: CircleAvatar(
              backgroundImage: AssetImage(
          ImagePath.webDashboardLogo,
        ),
            ),
            ),
            Tab(
            text: "Student",
            icon: CircleAvatar(
              backgroundImage: AssetImage(
          ImagePath.webGraduateLogo,
        ),
            ),
            ),
            Tab(
            text: "Staff",
            icon: CircleAvatar(
              backgroundImage: AssetImage(
          ImagePath.webStaffLogo,
        ),
            ),
            ),
            Tab(
            text: "Faculty",
            icon: CircleAvatar(
              backgroundImage: AssetImage(
          ImagePath.webfacultyfLogo,
        ),
            ),
            ),
             Tab(
            text: "Department",
            icon: CircleAvatar(
              backgroundImage: AssetImage(
          ImagePath.webdeptLogo,
        ),
            ),
            ),
             Tab(
            text: "Admission",
            icon: CircleAvatar(
              backgroundImage: AssetImage(
          ImagePath.webadmissionLogo,
        ),
            ),
            ),
            Tab(
            text: "Leave Request",
            icon: CircleAvatar(
              backgroundImage: AssetImage(
          ImagePath.webfacultyfLogo,
        ),
            ),
            ),
             Tab(
            text: "E-library",
            icon: CircleAvatar(
              backgroundImage: AssetImage(
          ImagePath.webelibfLogo,
        ),
            ),
            ),
            Tab(
            text: "Notification",
            icon: CircleAvatar(
              backgroundImage: AssetImage(
          ImagePath.webNotificationLogo,
        ),
            ),
            ),
            Tab(
            text: "Create Account",
            icon: CircleAvatar(child: Icon(Icons.group_add))
            ),
            
          
          ],
          contents: <Widget>[
            const OverviewView(),
           const StudentListView(),
             tabsContent('Dart'),
            const FacultyListView(),
            const ProgramView(),
              tabsContent('Dart'),
                tabsContent('Dart'),
                  tabsContent('Dart'),
                   tabsContent('Dart'),
                

            Container(
                color: Colors.black12,
                child: ListView.builder(
                    itemCount: 10,
                    itemExtent: 100,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        color: Colors.white30,
                      );
                    })),
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