import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/web_view/screens/dashboard/overview_view.dart';

import 'package:rugst_alliance_academia/web_view/screens/department/program_view.dart';

import 'package:rugst_alliance_academia/web_view/screens/faculty/faculty_list_view.dart';

import 'package:rugst_alliance_academia/web_view/screens/student/student_list_view.dart';

class SidebarPage extends StatefulWidget {
  const SidebarPage({super.key});

  @override
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  List<CollapsibleItem>? _items;

  Widget? bodywidget;

  // final AssetImage _avatarImg = const AssetImage('assets/man.png');

  @override
  void initState() {
    super.initState();
    _items = _generateItems;

    bodywidget = const OverviewView();
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Dashboard',
        iconImage: const AssetImage(
          ImagePath.webDashboardLogo,
        ),
        onPressed: () => setState(() {
          bodywidget = const OverviewView();
        }),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Student',
        iconImage: const AssetImage(ImagePath.webGraduateLogo),
        onPressed: () => setState(() {
          bodywidget = const StudentListView();
        }),
      ),
      CollapsibleItem(
        text: 'Staff',
        iconImage: const AssetImage(ImagePath.webStaffLogo),
        onPressed: () => setState(() {}),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Notifications"))),
      ),
      CollapsibleItem(
        text: 'Faculty',
        iconImage: const AssetImage(ImagePath.webfacultyfLogo),
        onPressed: () => setState(() {
          bodywidget = const FacultyListView();
        }),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Settings"))),
      ),
      CollapsibleItem(
        text: 'Department',
        iconImage: const AssetImage(ImagePath.webdeptLogo),
        onPressed: () => setState(() {
          bodywidget = const ProgramView();
        }),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Alarm"))),
      ),
      CollapsibleItem(
        text: 'Admission',
        iconImage: const AssetImage(ImagePath.webadmissionLogo),
        onPressed: () => setState(() {}),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Eco"))),
      ),
      CollapsibleItem(
        text: 'Leave Request',
        iconImage: const AssetImage(ImagePath.webfacultyfLogo),
        onPressed: () => setState(() {}),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Event"))),
      ),
      CollapsibleItem(
        text: 'E-library',
        iconImage: const AssetImage(ImagePath.webelibfLogo),
        onPressed: () => setState(() {}),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Email"))),
      ),
      CollapsibleItem(
        text: 'Notification',
        iconImage: const AssetImage(ImagePath.webNotificationLogo),
        onPressed: () => setState(() {}),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Face"))),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: CollapsibleSidebar(
          isCollapsed: false,
          screenPadding: 0,
          borderRadius: 0,
          minWidth: 240.w,
          items: _items!,
          collapseOnBodyTap: false,
          showToggleButton: false,
          title: 'Prabhakaran',
          onTitleTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Yay! Flutter Collapsible Sidebar!')));
          },
          body: _body(size, context),
          selectedIconColor: AppColors.color582,
          backgroundColor: AppColors.color927,
          selectedTextColor: AppColors.color582,
          textStyle: TextStyle(fontSize: 15.sp, fontStyle: FontStyle.italic),
          titleStyle: TextStyle(
              fontSize: 20.sp,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
          toggleTitleStyle:
              TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          sidebarBoxShadow: const [
            BoxShadow(),
          ],
        ),
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
    return Container(
      height: double.infinity,
      width: size.width,
      color: Colors.blueGrey[50],
      child: bodywidget,
    );
  }
}
