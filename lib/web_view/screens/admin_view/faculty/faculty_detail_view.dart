import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timeline_calendar/timeline/dictionaries/fa.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/faculty_model.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/alerts/create_faculty_account_alert.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/faculty_tab_views/faculty_checkin_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/faculty_tab_views/faculty_ciriculam_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/faculty_tab_views/faculty_class_history_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/update_faculty_view.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_indicator.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class FacultyDetailView extends StatefulWidget {
  final FacultyList facultyDetail;
  const FacultyDetailView({super.key, required this.facultyDetail});

  @override
  State<FacultyDetailView> createState() => _FacultyDetailViewState();
}

class _FacultyDetailViewState extends State<FacultyDetailView> {
  showUpdateAlertDialog(BuildContext context, FacultyList details) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Stack(
        children: [
          UpdateFacultyView(facultyDetail: details),
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
    ).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final facultyData = widget.facultyDetail;
    var size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Card(
              color: AppColors.colorWhite,
              elevation: 5.0,
              child: SizedBox(
                height: size.height,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 150.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.color446, width: 2),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(
                                  base64Decode(facultyData.userImage!)),
                            ),
                            borderRadius: BorderRadius.circular(18.sp),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AppRichTextView(
                          title: facultyData.firstName! + facultyData.lastName!,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          textColor: AppColors.color446,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: AppRichTextView(
                                title: "DOB:",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorBlack,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: AppRichTextView(
                                title: facultyData.dob!,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.color446,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: AppRichTextView(
                                title: "Gender :",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorBlack,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: AppRichTextView(
                                title: facultyData.gender!,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.color446,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: AppRichTextView(
                                title: "Mobile Number:",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorBlack,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: AppRichTextView(
                                title: facultyData.mobile!,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.color446,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: AppRichTextView(
                                title: "Email Address:",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorBlack,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: AppRichTextView(
                                title: facultyData.email!,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.color446,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: AppRichTextView(
                                title: "Job Type:",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorBlack,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: AppRichTextView(
                                title: facultyData.jobType!,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.color446,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: AppRichTextView(
                                title: "Joining Date:",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorBlack,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: AppRichTextView(
                                title: facultyData.joiningDate!,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.color446,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Important
                          children: [
                            Expanded(
                              flex: 1,
                              child: AppRichTextView(
                                title: "Address",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorBlack,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                child: AppRichTextView(
                                  maxLines: 5,
                                  title: facultyData.address!,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.color446,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Important
                          children: [
                            Expanded(
                              flex: 1,
                              child: AppRichTextView(
                                title: "Qualification",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.colorBlack,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                child: AppRichTextView(
                                  maxLines: 5,
                                  title: facultyData.qualifiation!,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.color446,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        facultyData.accountCreated == false
                            ? AppElevatedButon(
                                title: "Create Account",
                                onPressed: (context) async {
                                  showCreateFacultyAccountDialogue(
                                      context, facultyData.email!);
                                },
                                buttonColor: AppColors.colorWhite,
                                borderColor: AppColors.color446,
                                textColor: AppColors.color446,
                                height: 50.h,
                                width: 180.w,
                              )
                            : Container(),
                        SizedBox(
                          height: 20.h,
                        ),
                        Consumer<FacultyProvider>(
                            builder: (context, facultyConsumer, child) {
                          return Consumer<ProgramProvider>(
                              builder: (context, programConsumer, child) {
                            return AppElevatedButon(
                              title: "Update Faculty",
                              onPressed: (context) async {
                                facultyConsumer.updateJobType(false);
                                facultyConsumer.updateGender(false);
                                var token = await getTokenAndUseIt();
                                if (token == null) {
                                  if (context.mounted) {
                                    Navigator.pushNamed(
                                        context, RouteNames.login);
                                  }
                                } else if (token == "Token Expired") {
                                  ToastHelper().errorToast(
                                      "Session Expired Please Login Again");

                                  if (context.mounted) {
                                    Navigator.pushNamed(
                                        context, RouteNames.login);
                                  }
                                } else {
                                  await programConsumer
                                      .getAllCoursesList(token);
                                  if (context.mounted) {
                                    showUpdateAlertDialog(context, facultyData);
                                  }
                                }
                              },
                              buttonColor: AppColors.colorWhite,
                              borderColor: AppColors.color446,
                              textColor: AppColors.color446,
                              height: 50.h,
                              width: 180.w,
                            );
                          });
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Card(
              color: AppColors.colorWhite,
              elevation: 5.0,
              child: SizedBox(
                height: size.height,
                child: DefaultTabController(
                    length: 4,
                    child: Consumer<FacultyProvider>(
                        builder: (context, facultyProvider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            onTap: (value) async {
                              
                              if (value == 1) {
                                var token = await getTokenAndUseIt();
                                if (token == null) {
                                  if (context.mounted) {
                                    Navigator.pushNamed(
                                        context, RouteNames.login);
                                  }
                                } else if (token == "Token Expired") {
                                  ToastHelper().errorToast(
                                      "Session Expired Please Login Again");

                                  if (context.mounted) {
                                    Navigator.pushNamed(
                                        context, RouteNames.login);
                                  }
                                } else {
                                  var result =
                                      await facultyProvider.getRegisteredCourse(
                                          token, widget.facultyDetail.iD!);

                                  if (result == "Invalid Token") {
                                    ToastHelper().errorToast(
                                        "Session Expired Please Login Again");
                                    if (context.mounted) {
                                      Navigator.pushNamed(
                                          context, RouteNames.login);
                                    }
                                  }
                                }
                              }
                            },
                            labelColor: AppColors.color446,
                            indicatorWeight: 1.0,
                            indicator: CustomTabIndicator(
                                color: AppColors.color446,
                                height: 3.h,
                                width: 200.w,
                                borderRadius: 10),
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: const [
                              Tab(text: "Attendance"),
                              Tab(text: "Curriculum"),
                              Tab(text: "History"),
                              Tab(text: "Feedback"),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                 FacultyCheckInView(facultyId: facultyData.userId!),
                                FacultyCiriculamView(
                                  facultyId: facultyData.iD!,
                                ),
                                FacultyClassHistoryView(
                                  facultyId: facultyData.userId!,
                                ),
                                const Text("History")
                              ],
                            ),
                          )
                        ],
                      );
                    })),
              ),
            ),
          )
        ],
      ),
    );
    // return Padding(
    //   padding: EdgeInsets.all(8.0.sp),
    //   child: Column(
    //     children: [
    //       Row(
    //         children: [
    //           Expanded(
    //             flex: 2,
    //             child: Container(
    //               height: size.height * 0.4,
    //               decoration: BoxDecoration(
    //                   color: AppColors.colorc7e,
    //                   borderRadius: BorderRadius.circular(18.sp)),
    //               child: Padding(
    //                 padding: EdgeInsets.all(8.0.sp),
    //                 child: Row(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Column(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Padding(
    //                           padding: EdgeInsets.only(left: 8.0.w),
    //                           child: Stack(
    //                             children: [
    //                               CircleAvatar(
    //                                 radius: 80.sp,
    //                                 backgroundImage: MemoryImage(
    //                                     base64Decode(facultyData.userImage!)),
    //                               ),
    //                               Positioned(
    //                                 right: 0,
    //                                 bottom: 15,
    //                                 child: Container(
    //                                   decoration: BoxDecoration(
    //                                       borderRadius:
    //                                           BorderRadius.circular(25.sp),
    //                                       boxShadow: [
    //                                         BoxShadow(
    //                                             color: facultyData.jobType ==
    //                                                     "Part-Time"
    //                                                 ? AppColors
    //                                                     .contentColorOrange
    //                                                 : facultyData.jobType ==
    //                                                         "Full-Time"
    //                                                     ? AppColors.color582
    //                                                     : AppColors.colorRed,
    //                                             blurRadius: 10,
    //                                             spreadRadius: 5)
    //                                       ]),
    //                                   child: InkWell(
    //                                     onTap: () {
    //                                       facultyProvider.updateJobType(false);
    //                                       facultyProvider.updateGender(false);
    //                                       showUpdateAlertDialog(
    //                                           context, facultyData);
    //                                     },
    //                                     child: CircleAvatar(
    //                                       radius: 15.sp,
    //                                       backgroundColor:
    //                                           facultyData.jobType == "Part-Time"
    //                                               ? AppColors.contentColorOrange
    //                                               : facultyData.jobType ==
    //                                                       "Full-Time"
    //                                                   ? AppColors.color582
    //                                                   : AppColors.colorRed,
    //                                       child: Center(
    //                                         child: Icon(
    //                                           Icons.edit,
    //                                           size: 20.sp,
    //                                           color: AppColors.colorWhite,
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           height: 10.h,
    //                         ),
    //                         Row(
    //                           children: [
    //                             Tooltip(
    //                                 message: facultyData.mobile,
    //                                 child: const Icon(
    //                                   Icons.phone,
    //                                   color: AppColors.colorWhite,
    //                                 )),
    //                             SizedBox(
    //                               width: 5.w,
    //                             ),
    //                             Tooltip(
    //                                 message: facultyData.email,
    //                                 child: const Icon(
    //                                   Icons.mail,
    //                                   color: AppColors.colorWhite,
    //                                 )),
    //                             SizedBox(
    //                               width: 5.w,
    //                             ),
    //                             Tooltip(
    //                                 message: facultyData.dob,
    //                                 child: const Icon(
    //                                   Icons.cake,
    //                                   color: AppColors.colorWhite,
    //                                 ))
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                     Expanded(
    //                       child: Padding(
    //                         padding: EdgeInsets.only(top: 18.0.h, left: 10.h),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Row(
    //                               children: [
    //                                 AppRichTextView(
    //                                   title: facultyData.firstName! +
    //                                       facultyData.lastName!,
    //                                   fontSize: 24.sp,
    //                                   fontWeight: FontWeight.bold,
    //                                   textColor: AppColors.colorWhite,
    //                                 ),
    //                                 Icon(
    //                                   facultyData.gender == "Male"
    //                                       ? Icons.male
    //                                       : Icons.female,
    //                                   color: AppColors.colorWhite,
    //                                 )
    //                               ],
    //                             ),

    //                             SizedBox(
    //                               height: 10.h,
    //                             ),
    //                             Row(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 AppRichTextView(
    //                                   title: "Joining Date: ",
    //                                   fontSize: 12.sp,
    //                                   fontWeight: FontWeight.w800,
    //                                   textColor: AppColors.colorGrey,
    //                                 ),
    //                                 AppRichTextView(
    //                                   title: facultyData.joiningDate!,
    //                                   fontSize: 12.sp,
    //                                   fontWeight: FontWeight.w800,
    //                                   textColor: AppColors.colorWhite,
    //                                 ),
    //                               ],
    //                             ),
    //                             SizedBox(
    //                               height: 10.h,
    //                             ),
    //                             Row(
    //                               children: [
    //                                 AppRichTextView(
    //                                   title: "FacultyID: ",
    //                                   fontSize: 12.sp,
    //                                   fontWeight: FontWeight.w800,
    //                                   textColor: AppColors.colorGrey,
    //                                 ),
    //                                 AppRichTextView(
    //                                   title: facultyData.facultyId!,
    //                                   fontSize: 12.sp,
    //                                   fontWeight: FontWeight.w800,
    //                                   textColor: AppColors.colorWhite,
    //                                 ),
    //                               ],
    //                             ),
    //                             SizedBox(
    //                               height: 10.h,
    //                             ),
    //                             Row(
    //                               children: [
    //                                 AppRichTextView(
    //                                   title: "Qualification: ",
    //                                   fontSize: 12.sp,
    //                                   fontWeight: FontWeight.w800,
    //                                   textColor: AppColors.colorGrey,
    //                                 ),
    //                                 AppRichTextView(
    //                                   title: facultyData.qualifiation!,
    //                                   fontSize: 12.sp,
    //                                   fontWeight: FontWeight.w800,
    //                                   textColor: AppColors.colorWhite,
    //                                 ),
    //                               ],
    //                             ),
    //                             SizedBox(
    //                               height: 10.h,
    //                             ),
    //                             Row(
    //                               children: [
    //                                 AppRichTextView(
    //                                   title: "Passport Number: ",
    //                                   fontSize: 12.sp,
    //                                   fontWeight: FontWeight.w800,
    //                                   textColor: AppColors.colorGrey,
    //                                 ),
    //                                 AppRichTextView(
    //                                   title: facultyData.passportNumber!,
    //                                   fontSize: 12.sp,
    //                                   fontWeight: FontWeight.w800,
    //                                   textColor: AppColors.colorWhite,
    //                                 ),
    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     Expanded(
    //                       child: Padding(
    //                         padding: EdgeInsets.only(top: 18.0.h),
    //                         child: Row(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             AppRichTextView(
    //                               title: "Address: ",
    //                               fontSize: 12.sp,
    //                               fontWeight: FontWeight.w800,
    //                               textColor: AppColors.colorGrey,
    //                             ),
    //                             Flexible(
    //                               child: AppRichTextView(
    //                                 maxLines: 3,
    //                                 title: facultyData.address!,
    //                                 fontSize: 12.sp,
    //                                 fontWeight: FontWeight.w800,
    //                                 textColor: AppColors.colorWhite,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             width: 8.w,
    //           ),
    //           Expanded(
    //             flex: 1,
    //             child: Container(
    //               height: size.height * 0.4,
    //               decoration: BoxDecoration(
    //                   color: AppColors.colorc7e,
    //                   borderRadius: BorderRadius.circular(18.sp)),
    //               child: FacultyAttendanceView(
    //                   facultyDetail: widget.facultyDetail),
    //             ),
    //           ),
    //         ],
    //       ),
    //       SizedBox(
    //         height: 8.h,
    //       ),
    //       Expanded(
    //           child: Container(
    //         decoration:
    //             BoxDecoration(borderRadius: BorderRadius.circular(18.sp)),
    //         child: const FacultyTabView(),
    //       ))
    //     ],
    //   ),
    // );
  }
}
