import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';

import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

int? feesAmount;
final _formKey = GlobalKey<FormState>();

showUpdateFeesDialog(BuildContext context, int studentId) {
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
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: AppColors.colorRed,
            ),
          )
        ],
      ),
      content:
          Consumer<StudentProvider>(builder: (context, studentConsumer, child) {
        return IntrinsicHeight(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppRichTextView(
                    title: "Full Fees Amount",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.colorBlack),
                SizedBox(
                  height: 5.h,
                ),
                AppTextFormFieldWidget(
                  validator: (p0) => AmountValidator.validate(p0!),
                  onSaved: (p0) => feesAmount = int.parse(p0!),
                  obscureText: false,
                  inputDecoration: InputDecoration(
                      hintText: "Enter Full Fess in USD",
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
                Row(
                  children: [
                    AppElevatedButon(
                      loading: studentConsumer.isAlertLoading,
                      title: "Update",
                      buttonColor: AppColors.colorc7e,
                      textColor: AppColors.colorWhite,
                      height: 50.h,
                      width: 110.w,
                      onPressed: (context) async {
                        var token = await getTokenAndUseIt();
                        if (token == null) {
                          if (context.mounted) {
                            Navigator.pushNamed(context, RouteNames.login);
                          }
                        } else if (token == "Token Expired") {
                          ToastHelper()
                              .errorToast("Session Expired Please Login Again");

                          if (context.mounted) {
                            Navigator.pushNamed(context, RouteNames.login);
                          }
                        } else {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            var result =
                                await studentConsumer.updateFessByStudentId(
                                    feesAmount!, studentId, token);
                            if (result == "200" && context.mounted) {
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
                      buttonColor: AppColors.colorc7e,
                      textColor: AppColors.colorWhite,
                      height: 50.h,
                      width: 110.w,
                      onPressed: (context) {},
                    )
                  ],
                )
              ],
            ),
          ),
        );
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
