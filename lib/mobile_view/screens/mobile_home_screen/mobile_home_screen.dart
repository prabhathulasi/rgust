import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/mobile_home_screen/mobile_home_tab_screen.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/student_view/student_page_tabs/student_tab_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({super.key});

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    Future getStudentDetail() async {
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var studentId = prefs.getInt("userId");
        var result =
            await studentProvider.getSingleStudentDetailById(studentId!, token);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 35.h,
        backgroundColor: AppColors.color446,
        title: AppRichTextView(
          title: "Student Profile",
          textColor: AppColors.colorWhite,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: FutureBuilder(
          future: getStudentDetail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitSpinningLines(
                  color: AppColors.colorc7e,
                ),
              );
            } else {
              return Consumer<StudentProvider>(
                  builder: (context, studentConsumer, child) {
                final studentData =
                    studentConsumer.singleStudentDetailModel.studentDetail!;
                return Padding(
                  padding: EdgeInsets.all(15.0.sp),
                  child: SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Column(
                      children: [
                        Card(
                          elevation: 3.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Card(
                                  elevation: 3.0,
                                  color: AppColors.color446.withOpacity(0.01),
                                  child: Container(
                                      height: 110.h,
                                      width: 110.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: MemoryImage(
                                                base64Decode(
                                                    studentData.userImage!),
                                              )))),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Flexible(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                      overflow: TextOverflow.ellipsis,
                                      title: studentData.firstName! +
                                          studentData.lastName!,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.color446,
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 20.sp,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        AppRichTextView(
                                          overflow: TextOverflow.ellipsis,
                                          title: studentData.mobileNumber
                                              .toString(),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          textColor: AppColors.colorBlack,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          size: 20.sp,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Flexible(
                                          child: AppRichTextView(
                                            overflow: TextOverflow.ellipsis,
                                            title: studentData.email!,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            textColor: AppColors.colorBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.cake,
                                          size: 20.sp,
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        AppRichTextView(
                                          overflow: TextOverflow.ellipsis,
                                          title: studentData.dOB!,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          textColor: AppColors.colorBlack,
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                                        Expanded(
                                    child: MobileHomeTabScreen(
                                  studentDetail: studentData,
                                ))
                      ],
                    ),
                  ),
                 
                );
              });
            }
          }),
    );
  }
}
