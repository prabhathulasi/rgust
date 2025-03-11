import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/clincial_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

final _formKey = GlobalKey<FormState>();
showClinicalFeeAlert(BuildContext context, int radioValue) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppRichTextView(
              title: "Update Clinical Fee ",
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              textColor: AppColors.colorBlack),
        ],
      ),
      content: Consumer<ClincialProvider>(
          builder: (context, clinicalConsumer, child) {
        return IntrinsicHeight(
          child: SizedBox(
            width: 250.w,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextFormFieldWidget(
                    autofocus: true,
                    validator: (p0) => AmountValidator.validate(p0!),
                    onSaved: (p0) =>
                        clinicalConsumer.clincalFees = int.parse(p0!),
                    obscureText: false,
                    inputDecoration: InputDecoration(
                        hintText: "Enter Clinical Fee in USD",
                        hintStyle: GoogleFonts.roboto(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.colorGrey,
                        ),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.colorc7e, width: 3.w))),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: AppColors.colorc7e,
                        value: "Paid",
                        groupValue: clinicalConsumer.clinicalFeeRadioValue,
                        onChanged: (String? value) {
                          clinicalConsumer.setFeesRadioValue(value!);
                        },
                      ),
                      AppRichTextView(
                          title: "Paid",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                      Radio(
                        activeColor: AppColors.colorc7e,
                        value: "UnPaid",
                        groupValue: clinicalConsumer.clinicalFeeRadioValue,
                        onChanged: (String? value) {
                          clinicalConsumer.setFeesRadioValue(value!);
                        },
                      ),
                      AppRichTextView(
                          title: "Unpaid",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      AppElevatedButon(
                        // loading: studentConsumer.isAlertLoading,
                        title: "Update",
                        borderColor: AppColors.color582,
                        buttonColor: AppColors.colorWhite,
                        textColor: AppColors.color582,
                        height: 50.h,
                        width: 110.w,
                        onPressed: (context) async {
                          if (_formKey.currentState!.validate() ||
                              clinicalConsumer.clinicalFeeRadioValue != null) {
                            _formKey.currentState!.save();
                            clinicalConsumer
                                .setClinicalRadioButtonValue(radioValue);
                                Navigator.pop(context);
                          }else{
                            ToastHelper().errorToast("Please select the fees is paid or unpaid");
                          }
                        },
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      AppElevatedButon(
                        title: "Cancel",
                        buttonColor: AppColors.colorWhite,
                        borderColor: AppColors.colorRed,
                        textColor: AppColors.colorRed,
                        height: 50.h,
                        width: 110.w,
                        onPressed: (context) {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
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
