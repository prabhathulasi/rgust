import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/staff_model.dart';
import 'package:rugst_alliance_academia/data/provider/staff_provider.dart';

import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class StaffSettingsTabView extends StatefulWidget {
  final StaffList? staffDetail;
  const StaffSettingsTabView({super.key, this.staffDetail});

  @override
  State<StaffSettingsTabView> createState() => _SettingsTabViewState();
}

class _SettingsTabViewState extends State<StaffSettingsTabView> {
  final formKey = GlobalKey<FormState>();
  String? password;
  String? userName;
  showCreateAccountDialogue(BuildContext context) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width / 4,
        height: MediaQuery.sizeOf(context).height / 2.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
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
                    textStyle: GoogleFonts.roboto(
                      color: AppColors.colorWhite,
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "UserName is Required";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (p0) => userName = p0,
                    obscureText: false,
                    inputDecoration: InputDecoration(
                        errorStyle: GoogleFonts.oswald(
                            color: AppColors.colorRed,
                            fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Enter UserName",
                        hintStyle:
                            GoogleFonts.oswald(color: AppColors.colorWhite),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 25.0.h, horizontal: 10.0.w),
                        border: InputBorder.none),
                  ),
                ),
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
                    // validator: (value) {
                    //   return EmailFormFieldValidator.validate(value!);
                    // },
                    // onSaved: (p0) => userName = p0,
                    obscureText: false,
                    inputDecoration: InputDecoration(
                        errorStyle: GoogleFonts.oswald(
                            color: AppColors.colorRed,
                            fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: widget.staffDetail!.email!,
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
                    Consumer<StaffProvider>(
                        builder: (context, staffConsumer, child) {
                      return AppElevatedButon(
                              title: "Create",
                              buttonColor: AppColors.colorc7e,
                              height: 50.h,
                              width: 140.w,
                              textColor: AppColors.colorWhite,
                              onPressed: (context) async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
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
                                        await staffConsumer.createAccount(
                                            token,
                                            widget.staffDetail!.email!,
                                            password!,
                                            userName!,
                                            widget.staffDetail!.iD!);
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
                      width: 140.w,
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width / 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppRichTextView(
                title: "Account Settings",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                textColor: AppColors.colorc7e,
              ),
              SizedBox(
                height: 10.h,
              ),
            //  Consumer<StaffProvider>(
            //    builder: (context, staffConsumer, child) {
            //      return staffConsumer.staffModel.staffList.accountCreated == true? Container(): InkWell(
            //               onTap: () {
            //                 showCreateAccountDialogue(context);
            //               },
            //               child: const Card(
            //                 elevation: 5.0,
            //                 child: ListTile(
            //                   leading: Icon(Icons.person_add),
            //                   title: Text("Create Account"),
            //                   trailing: Icon(Icons.chevron_right),
            //                 ),
            //               ),
            //             );
            //    }
            //  ),
                 
              SizedBox(
                height: 10.h,
              ),
              const Card(
                elevation: 5.0,
                child: ListTile(
                  leading: Icon(Icons.block),
                  title: Text("Block Account"),
                  trailing: Icon(Icons.chevron_right),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
