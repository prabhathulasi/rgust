import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/provider/fees_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';

import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_detailed_layout/student_class_dropdown.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';

import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

String? amountInUsd;
String? amountInGyd;
final _formKey = GlobalKey<FormState>();

showUpdateFeesDialog(BuildContext context, StudentDetail studentData) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppRichTextView(
              title: "Update Fees Detail",
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              textColor: AppColors.colorBlack),
          Consumer<FeesProvider>(builder: (context, feesConsumer, child) {
            return InkWell(
              onTap: () {
                Navigator.pop(context);
                feesConsumer.setfeesTypeRadioValue(
                  "",
                  studentData.currentProgramId!,
                );
                feesConsumer.setSelectedFeeClass(null);
              },
              child: const Icon(
                Icons.close,
                color: AppColors.colorRed,
              ),
            );
          })
        ],
      ),
      content:
          Consumer<StudentProvider>(builder: (context, studentConsumer, child) {
        return Consumer<FeesProvider>(builder: (context, feesConsumer, child) {
          return IntrinsicHeight(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppRichTextView(
                      title: "Please Select Class",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.colorBlack),
                  SizedBox(
                    height: 10.h,
                  ),
                  StudentClassDropdown(
                    studentData: studentData,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  AppRichTextView(
                      title: "Please Select the Tution Type:",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.colorBlack),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: AppColors.colorc7e,
                        value: "Standard Tution",
                        groupValue: feesConsumer.feesTypeRadioValue,
                        onChanged: (String? value) async {
                          feesConsumer.setfeesTypeRadioValue(
                              value!, studentData.currentProgramId!);
                        },
                      ),
                      AppRichTextView(
                          title: "Standard Tution",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                      Radio(
                        activeColor: AppColors.colorc7e,
                        value: "Scholarship Tution",
                        groupValue: feesConsumer.feesTypeRadioValue,
                        onChanged: (String? value) {
                          feesConsumer.setfeesTypeRadioValue(
                            value!,
                            studentData.currentProgramId!,
                          );
                        },
                      ),
                      AppRichTextView(
                          title: "Scholarship Tution",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  feesConsumer.isLoading == true
                      ? const Center(
                          child:
                              SpinKitSpinningLines(color: AppColors.colorc7e),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppRichTextView(
                                title: "Semester Tution",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                textColor: AppColors.colorBlack),
                            SizedBox(
                              height: 5.h,
                            ),
                            AppTextFormFieldWidget(
                              initialValue: feesConsumer
                                      .feesDetailModel.feesDetails?.tutionFee
                                      .toString() ??
                                  "0",
                              validator: (p0) => AmountValidator.validate(p0!),
                              onSaved: (p0) => amountInUsd = p0!,
                              obscureText: false,
                              inputDecoration: InputDecoration(
                                  hintText: "Enter Semester Fees in USD",
                                  hintStyle: GoogleFonts.roboto(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.colorGrey,
                                  ),
                                  border: const OutlineInputBorder()),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            AppTextFormFieldWidget(
                              onSaved: (p0) => amountInGyd = p0!,
                              validator: (p0) => AmountValidator.validate(p0!),
                              obscureText: false,
                              inputDecoration: InputDecoration(
                                  hintText: "Enter the Semester Tution in GYD",
                                  hintStyle: GoogleFonts.roboto(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.colorGrey,
                                  ),
                                  border: const OutlineInputBorder()),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            feesConsumer.selectedClassForFee == null
                                ? Container()
                                : Row(
                                    children: [
                                      AppElevatedButon(
                                        loading: studentConsumer.isAlertLoading,
                                        title: "Update",
                                        borderColor: AppColors.color582,
                                        buttonColor: AppColors.colorWhite,
                                        textColor: AppColors.color582,
                                        height: 50.h,
                                        width: 110.w,
                                        onPressed: (context) async {
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
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();

                                              var result = await studentConsumer
                                                  .updateFessByStudentId(
                                                      amountInGyd!,
                                                      amountInUsd!,
                                                      studentData.iD!,
                                                      int.parse(feesConsumer.selectedClassForFee!),
                                                      feesConsumer
                                                          .feesTypeRadioValue!,
                                                      token);
                                              if (result == "200" &&
                                                  context.mounted) {
                                                    feesConsumer.setSelectedFeeClass(null);
                                                Navigator.pop(context);
                                              }
                                            }
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      AppElevatedButon(
                                        title: "Cancel",
                                        buttonColor: AppColors.colorWhite,
                                        textColor: AppColors.colorRed,
                                        borderColor: AppColors.colorRed,
                                        height: 50.h,
                                        width: 110.w,
                                        onPressed: (context) {
                                          Navigator.pop(context);
                                          feesConsumer.setSelectedFeeClass(null);
                                        },
                                      )
                                    ],
                                  )
                          ],
                        )
                ],
              ),
            ),
          );
        });
      }));

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
