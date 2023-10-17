import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/faculty/add_new_faculty_view.dart';

import 'package:rugst_alliance_academia/web_view/screens/faculty/faculty_grid_view.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';

import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class FacultyListView extends StatefulWidget {
  const FacultyListView({Key? key}) : super(key: key);

  @override
  State<FacultyListView> createState() => _FacultyListViewState();
}

showAddAlertDialog(BuildContext context) {
  // set up the AlertDialog
  Dialog alert = Dialog(
    child: Stack(
      children: [
        const AddFacultyView(),
        Transform.translate(
          offset: Offset(10.w, -13.h),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: AppColors.colorc7e,
                  child: Icon(Icons.close, color: AppColors.color582),
                ),
              )),
        )
      ],
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _FacultyListViewState extends State<FacultyListView> {
  @override
  Widget build(BuildContext context) {
    final facultyProvider =
        Provider.of<FacultyProvider>(context, listen: false);

    Future getFacultyList() async {
      var token = await getTokenAndUseIt();
      if (token == null) {
        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }
      } else if (token == "Token Expired") {
        ToastHelper().errorToast("Session Expired Please Login Again");

        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }
      } else {
        var result = await facultyProvider.getFaculty(token);
         if(result =="Invalid Token"){
           ToastHelper().errorToast("Session Expired Please Login Again");
           if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }}
      }
    }

    return Scaffold(
      backgroundColor: AppColors.color0ec,
      body: Padding(
        padding: EdgeInsets.all(18.0.sp),
        child: FutureBuilder(
          future: getFacultyList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitSpinningLines(
                  color: AppColors.colorc7e,
                  size: 60.sp,
                ),
              );
            } else {
              return facultyProvider.facultyModel.facultyList == null
                  ? Center(
                      child: Column(
                      children: [
                        Expanded(child: Image.asset(ImagePath.webNoDataLogo)),
                        AppElevatedButon(
                          title: "Add New Faculty",
                          buttonColor: AppColors.colorc7e,
                          height: 50.h,
                          width: 200.w,
                          onPressed: (context) {
                            showAddAlertDialog(context);
                          },
                          textColor: AppColors.colorWhite,
                        )
                      ],
                    ))
                  : const  FacultyGridView();
            }
          },
        ),
      ),
    );
  }
}
