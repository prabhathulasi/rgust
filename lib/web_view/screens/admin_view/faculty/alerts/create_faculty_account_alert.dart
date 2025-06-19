import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final formKey = GlobalKey<FormState>();
String? password;
String? userName;
showCreateFacultyAccountDialogue(BuildContext context, String email) {
  // set up the AlertDialog
  Dialog alert = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: IntrinsicHeight(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width / 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                AppRichTextView(
                    title: "Create Faculty Account",
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.color446, width: 3.w),
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.circular(18.sp)),
                  child: Center(
                    child: AppTextFormFieldWidget(
                      textStyle: GoogleFonts.roboto(
                        color: AppColors.colorBlack,
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
                              GoogleFonts.oswald(color: AppColors.colorGrey),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0.w),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.color446, width: 3.w),
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.circular(18.sp)),
                  child: AppTextFormFieldWidget(
                    enable: false,
                    textStyle: GoogleFonts.roboto(
                      color: AppColors.colorBlack,
                    ),
                    obscureText: false,
                    inputDecoration: InputDecoration(
                        errorStyle: GoogleFonts.oswald(
                            color: AppColors.colorRed,
                            fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: email,
                        hintStyle:
                            GoogleFonts.oswald(color: AppColors.colorBlack),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10.0.w),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.color446, width: 3.w),
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.circular(18.sp)),
                  child: AppTextFormFieldWidget(
                    textStyle: GoogleFonts.oswald(
                      color: AppColors.colorBlack,
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
                      hintStyle: GoogleFonts.oswald(color: AppColors.colorGrey),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0.w),
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
                        loading: facultyProvider.isLoading,
                        title: "Create",
                        buttonColor: AppColors.colorWhite,
                        height: 50.h,
                        width: 120.w,
                        textColor: AppColors.color446,
                        borderColor: AppColors.color446,
                        onPressed: (context) async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
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
                                  token, email, password!, userName!);
                              if (result != null) {
                                if (context.mounted) {
                                  Navigator.pop(context);
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
                      buttonColor: AppColors.colorWhite,
                      borderColor: AppColors.colorRed,
                      height: 50.h,
                      width: 120.w,
                      textColor: AppColors.colorRed,
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
