import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/faculty_model.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/web_view/screens/faculty/faculty_tab_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/faculty/update_faculty_view.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class FacultyDetailView extends StatefulWidget {
  final FacultyList facultyDetail;
  const FacultyDetailView({super.key, required this.facultyDetail});

  @override
  State<FacultyDetailView> createState() => _FacultyDetailViewState();
}

class _FacultyDetailViewState extends State<FacultyDetailView> {
  String? password;

  showAddAlertDialog(BuildContext context, FacultyList details) {
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
      setState(() {});
    });
  }

  final _formKey = GlobalKey<FormState>();
  showCreateAccountDialogue(BuildContext context) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width / 4,
        height: MediaQuery.sizeOf(context).height / 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AppRichTextView(
                    title: "Create Account",
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.colorc7e,
                      borderRadius: BorderRadius.circular(18.sp)),
                  child: AppTextFormFieldWidget(
                    enable: false,
                    textStyle: GoogleFonts.roboto(
                      color: AppColors.colorWhite,
                    ),
                    validator: (value) {
                      return EmailFormFieldValidator.validate(value!);
                    },
                    // onSaved: (p0) => userName = p0,
                    obscureText: false,
                    inputDecoration: InputDecoration(
                        errorStyle: GoogleFonts.oswald(
                            color: AppColors.colorRed,
                            fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: widget.facultyDetail.email,
                        hintStyle:
                            GoogleFonts.oswald(color: AppColors.colorWhite),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 25.0.h, horizontal: 10.0.w),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.colorc7e,
                      borderRadius: BorderRadius.circular(18.sp)),
                  child: AppTextFormFieldWidget(
                    textStyle: GoogleFonts.oswald(
                      color: AppColors.colorWhite,
                    ),
                    onSaved: (p0) => password = p0,
                    validator: (value) {
                      return PasswordFormFieldValidator.validate(value!);
                    },
                    obscureText: true,
                    inputDecoration: InputDecoration(
                      errorStyle: GoogleFonts.oswald(
                          color: AppColors.colorRed,
                          fontWeight: FontWeight.bold),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Enter Password",
                      hintStyle:
                          GoogleFonts.oswald(color: AppColors.colorWhite),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 25.0.h, horizontal: 10.0.w),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Consumer<FacultyProvider>(
                        builder: (context, facultyProvider, child) {
                      return AppElevatedButon(
                        title: "Create",
                        buttonColor: AppColors.colorc7e,
                        height: 50.h,
                        width: 120.w,
                        textColor: AppColors.colorWhite,
                        onPressed: (context) async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            var token = await getTokenAndUseIt();
                            if (token == null) {
                              if (context.mounted) {
                                Navigator.pushNamed(context, RouteNames.login);
                              }
                            } else if (token == "Token Expired") {
                              ToastHelper().errorToast(
                                  "Session Expired Please Login Again");

                              if (context.mounted) {
                                Navigator.pushNamed(context, RouteNames.login);
                              }
                            } else {
                              var result = await facultyProvider.createAccount(
                                  token,
                                  widget.facultyDetail.email!,
                                  password!,
                                  "");
                              if (result != null) {
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              }
                            }
                          }
                        },
                      );
                    }),
                    SizedBox(
                      width: 10.w,
                    ),
                    AppElevatedButon(
                      title: "cancel",
                      buttonColor: AppColors.colorc7e,
                      height: 50.h,
                      width: 120.w,
                      textColor: AppColors.colorWhite,
                      onPressed: (context) {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
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
    final facultyData = widget.facultyDetail;
    log(facultyData.createAccount.toString());
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 339.h,
                width: 734.w,
                decoration: BoxDecoration(
                    color: AppColors.colorc7e,
                    borderRadius: BorderRadius.circular(18.sp)),
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0.w),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 80.sp,
                              backgroundImage: MemoryImage(
                                  base64Decode(facultyData.userImage!)),
                            ),
                            Transform.translate(
                              offset: Offset(130.w, 130.h),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.sp),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              facultyData.jobType == "Part-Time"
                                                  ? AppColors.contentColorOrange
                                                  : facultyData.jobType ==
                                                          "Full-Time"
                                                      ? AppColors.color582
                                                      : AppColors.colorRed,
                                          blurRadius: 10,
                                          spreadRadius: 5)
                                    ]),
                                child: InkWell(
                                  onTap: () {
                                    // showAddAlertDialog(context, facultyData);
                                  },
                                  child: CircleAvatar(
                                    radius: 15.sp,
                                    backgroundColor:
                                        facultyData.jobType == "Part-Time"
                                            ? AppColors.contentColorOrange
                                            : facultyData.jobType == "Full-Time"
                                                ? AppColors.color582
                                                : AppColors.colorRed,
                                    child: Center(
                                      child: Icon(
                                        Icons.edit,
                                        size: 20.sp,
                                        color: AppColors.colorWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 18.0.h, left: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AppRichTextView(
                                  title: facultyData.firstName! +
                                      facultyData.lastName!,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  textColor: AppColors.colorWhite,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Container(
                                  width: 117,
                                  height: 43,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(25.sp),
                                      color: facultyData.jobType == "Part-Time"
                                          ? AppColors.contentColorOrange
                                          : facultyData.jobType == "Full-Time"
                                              ? AppColors.color582
                                              : AppColors.colorRed,
                                      boxShadow: [
                                        BoxShadow(
                                            color: facultyData.jobType ==
                                                    "Part-Time"
                                                ? AppColors.contentColorOrange
                                                : facultyData.jobType ==
                                                        "Full-Time"
                                                    ? AppColors.color582
                                                    : AppColors.colorRed,
                                            blurRadius: 10,
                                            spreadRadius: 5)
                                      ]),
                                  child: Center(
                                      child: AppRichTextView(
                                    title: "Full-Time",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    textColor: AppColors.colorWhite,
                                  )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                AppRichTextView(
                                  title: "Batch: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title: facultyData.batch!,
                                  fontSize: 20.sp,
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
                                  title: "Gender: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title: facultyData.gender!,
                                  fontSize: 20.sp,
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
                                  title: "Email: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title: facultyData.email!,
                                  fontSize: 20.sp,
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
                                  title: "Phone: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title: facultyData.mobile!,
                                  fontSize: 20.sp,
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
                                  title: "DOB: ",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorGrey,
                                ),
                                AppRichTextView(
                                  title: facultyData.dob!,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  textColor: AppColors.colorWhite,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                radius: 60.sp,
                                backgroundImage:
                                    const AssetImage(ImagePath.webrgustLogo),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              facultyData.createAccount == false
                                  ? AppElevatedButon(
                                      title: "Create Account",
                                      buttonColor: facultyData.jobType ==
                                              "Part-Time"
                                          ? AppColors.contentColorOrange
                                          : facultyData.jobType == "Full-Time"
                                              ? AppColors.color582
                                              : AppColors.colorRed,
                                      height: 40.h,
                                      width: 180.w,
                                      textColor: AppColors.colorWhite,
                                      onPressed: (context) {
                                        // showCreateAccountDialogue(context);
                                      },
                                    )
                                  : Container()
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Container(
                height: 339.h,
                width: 544.w,
                decoration: BoxDecoration(
                    color: AppColors.colorc7e,
                    borderRadius: BorderRadius.circular(18.sp)),
                child: Padding(
                  padding: EdgeInsets.all(18.0.sp),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AppRichTextView(
                            title: "Joining Date: ",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            textColor: AppColors.colorGrey,
                          ),
                          AppRichTextView(
                            title: facultyData.joiningDate!,
                            fontSize: 20.sp,
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
                            title: "FacultyID: ",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            textColor: AppColors.colorGrey,
                          ),
                          AppRichTextView(
                            title: facultyData.facultyId!,
                            fontSize: 20.sp,
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
                            title: "Course Assigned: ",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            textColor: AppColors.colorGrey,
                          ),
                          AppRichTextView(
                            title: facultyData.courseName!,
                            fontSize: 20.sp,
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
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            textColor: AppColors.colorGrey,
                          ),
                          AppRichTextView(
                            title: facultyData.qualifiation!,
                            fontSize: 20.sp,
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
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            textColor: AppColors.colorGrey,
                          ),
                          AppRichTextView(
                            title: facultyData.passportNumber!,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            textColor: AppColors.colorWhite,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppRichTextView(
                            title: "Address: ",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            textColor: AppColors.colorGrey,
                          ),
                          Flexible(
                            child: AppRichTextView(
                              maxLines: 3,
                              title: facultyData.address!,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.colorWhite,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Expanded(
              child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(18.sp)),
            child: const FacultyTabView(),
          ))
        ],
      ),
    );
  }
}
