import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/add_student_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_grid_view.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';


class StudentListView extends StatelessWidget {
  const StudentListView({Key? key}) : super(key: key);

 

  showAddAlertDialog(BuildContext context) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Stack(
        children: [
          const AddStudentView(),
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

  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);

    Future getStudentList() async {
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
        var result = await studentProvider.getStudent(token);
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
          future: getStudentList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitSpinningLines(
                  color: AppColors.colorc7e,
                  size: 60.sp,
                ),
              );
            } else {
              return studentProvider.studentModel.studentList == null
                  ? Center(
                      child: Column(
                      children: [
                        Expanded(child: Image.asset(ImagePath.webNoDataLogo)),
                        AppElevatedButon(
                          title: "Add New Student",
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
                  :  const StudentGridView();
            }
          },
        ),
      ),
     
    );
  }


}
