import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/model/student_model.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_tab_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/update_student_detail.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';

import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class StudentDetailView extends StatefulWidget {
  final int studentId;
  const StudentDetailView({super.key, required this.studentId});

  @override
  State<StudentDetailView> createState() => _FacultyDetailViewState();
}

class _FacultyDetailViewState extends State<StudentDetailView> {
  String? password;

  showAddAlertDialog(BuildContext context, StudentDetail details) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Stack(
        children: [
          UpdateStudentDetails(studentDetails: details),
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

  Future<void> remainderDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 350.h,
              width: 400.w,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(18.sp)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRichTextView(
                      title: "Fees Remainder",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.colorBlack,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppTextFormFieldWidget(
                      textStyle: TextStyle(fontSize: 15.sp),
                      maxLines: 5,
                      inputDecoration: InputDecoration(
                          hintText: "Message",
                          hintStyle: TextStyle(fontSize: 15.sp),
                          border: const OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        AppElevatedButon(
                          title: "Send",
                          borderColor: AppColors.colorWhite,
                          buttonColor: AppColors.colorc7e,
                          height: 50.h,
                          width: 150.w,
                          onPressed: (context) {},
                          textColor: AppColors.colorWhite,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        AppElevatedButon(
                          title: "Cancel",
                          borderColor: AppColors.colorWhite,
                          buttonColor: AppColors.colorc7e,
                          height: 50.h,
                          width: 150.w,
                          onPressed: (context) {
                            Navigator.pop(context);
                          },
                          textColor: AppColors.colorWhite,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final programProvider =
        Provider.of<ProgramProvider>(context, listen: false);
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
        var result =
            await studentProvider.getStudentDetailById(widget.studentId, token);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    return FutureBuilder(
        future: getStudentDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitSpinningLines(
                color: AppColors.colorc7e,
              ),
            );
          } else {
            final studentData =
                studentProvider.studentDetailModel.studentDetail!;

            return Padding(
              padding: EdgeInsets.all(3.0.sp),
              child: Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.colorc7e,
                                borderRadius: BorderRadius.circular(18.sp)),
                            child: Padding(
                              padding: EdgeInsets.all(8.0.sp),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0.w),
                                        child: Stack(
                                          children: [
                                            CircleAvatar(
                                              radius: 60.sp,
                                              backgroundImage: MemoryImage(
                                                  base64Decode(
                                                      studentData.userImage!)),
                                            ),
                                            Positioned(
                                              right: 0,
                                              bottom: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.sp),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: AppColors
                                                              .color582,
                                                          blurRadius: 10,
                                                          spreadRadius: 5)
                                                    ]),
                                                child: InkWell(
                                                  onTap: () async {
                                                    programProvider
                                                        .clearAllTemp();
                                                    studentProvider
                                                        .clearStudentTemp();

                                                    showAddAlertDialog(
                                                        context, studentData);
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 15.sp,
                                                    backgroundColor:
                                                        AppColors.color582,
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.edit,
                                                        size: 20.sp,
                                                        color: AppColors
                                                            .colorWhite,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Tooltip(
                                              message: studentData.mobileNumber
                                                  .toString(),
                                              child: const Icon(
                                                Icons.phone,
                                                color: AppColors.colorWhite,
                                              )),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Tooltip(
                                              message: studentData.email,
                                              child: const Icon(
                                                Icons.mail,
                                                color: AppColors.colorWhite,
                                              )),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Tooltip(
                                              message: studentData.dOB,
                                              child: const Icon(
                                                Icons.cake,
                                                color: AppColors.colorWhite,
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  IntrinsicWidth(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 18.0.h, left: 10.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              AppRichTextView(
                                                overflow: TextOverflow.ellipsis,
                                                title: studentData.firstName! +
                                                    studentData.lastName!,
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor: AppColors.colorWhite,
                                              ),
                                              Icon(
                                                studentData.gender == "Male"
                                                    ? Icons.male
                                                    : Icons.female,
                                                color: AppColors.colorWhite,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppRichTextView(
                                                title: "Student Type: ",
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorGrey,
                                              ),
                                              AppRichTextView(
                                                title: studentData.studentType!,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorWhite,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppRichTextView(
                                                title: "Current Class: ",
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorGrey,
                                              ),
                                              AppRichTextView(
                                                title: studentData
                                                    .currentClassName!,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorWhite,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppRichTextView(
                                                title: "Joining Date: ",
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorGrey,
                                              ),
                                              AppRichTextView(
                                                title:
                                                    studentData.admissionDate!,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorWhite,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              AppRichTextView(
                                                title: "Student Id: ",
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorGrey,
                                              ),
                                              AppRichTextView(
                                                title: studentData.studentId!,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorWhite,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              AppRichTextView(
                                                title:
                                                    "Emergency Contact Number: ",
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorGrey,
                                              ),
                                              AppRichTextView(
                                                title: studentData
                                                    .emergencyContact!
                                                    .toString(),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorWhite,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              AppRichTextView(
                                                title: "Passport Number: ",
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorGrey,
                                              ),
                                              AppRichTextView(
                                                title:
                                                    studentData.passportNumber!,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorWhite,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              AppRichTextView(
                                                title: "Qualification: ",
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorGrey,
                                              ),
                                              AppRichTextView(
                                                title:
                                                    studentData.qualification!,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorWhite,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: AppColors.colorWhite,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 80.0.h),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppRichTextView(
                                                title: "Home Address: ",
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorGrey,
                                              ),
                                              Flexible(
                                                child: AppRichTextView(
                                                  maxLines: 3,
                                                  title: studentData.address!,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 18.0.h),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppRichTextView(
                                                title: "Mailing Address: ",
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorGrey,
                                              ),
                                              Flexible(
                                                child: AppRichTextView(
                                                  maxLines: 3,
                                                  title: studentData
                                                      .mailingAddress!,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 18.0.h),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppRichTextView(
                                                title: "Created By: ",
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorGrey,
                                              ),
                                              Flexible(
                                                child: AppRichTextView(
                                                  maxLines: 2,
                                                  title: studentData.createdBy!,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 18.0.h),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppRichTextView(
                                                title: "Created at: ",
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w800,
                                                textColor: AppColors.colorGrey,
                                              ),
                                              Flexible(
                                                child: AppRichTextView(
                                                  maxLines: 2,
                                                  title: DateFormat.yMMMd()
                                                      .format(DateTime.parse(
                                                          studentData
                                                              .createdAt!)),
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.colorc7e,
                                borderRadius: BorderRadius.circular(18.sp)),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: AppRichTextView(
                                      title: 'Financial Details',
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.colorWhite,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: AppRichTextView(
                                          title: 'Total Fee:',
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorWhite,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: AppRichTextView(
                                          title: '1500 USD',
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorWhite,
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
                                        flex: 2,
                                        child: AppRichTextView(
                                          title: 'Paid Fee:',
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorWhite,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: AppRichTextView(
                                          title: '500 USD',
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorWhite,
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
                                        flex: 2,
                                        child: AppRichTextView(
                                          title: 'Payable Fee:',
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorWhite,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: AppRichTextView(
                                          title: '1000 USD',
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorWhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      AppElevatedButon(
                                        title: "Remainder",
                                        borderColor: AppColors.colorBlack,
                                        buttonColor: AppColors.colorWhite,
                                        textColor: AppColors.colorc7e,
                                        height: 40.h,
                                        width: 140.w,
                                        onPressed: (context) {
                                          remainderDialog(context);
                                        },
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      AppElevatedButon(
                                        title: "Summary",
                                        borderColor: AppColors.colorBlack,
                                        buttonColor: AppColors.colorWhite,
                                        textColor: AppColors.colorc7e,
                                        height: 40.h,
                                        width: 140.w,
                                        onPressed: (context) {},
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.sp)),
                    child: StudentTabView(
                      studentDetail: studentData,
                    ),
                  ))
                ],
              ),
            );
          }
        });
  }
}
