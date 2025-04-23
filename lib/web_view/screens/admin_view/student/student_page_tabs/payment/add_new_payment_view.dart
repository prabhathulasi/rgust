
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:rugst_alliance_academia/data/provider/payment_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';

import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/payment/sem_fee_dropdown.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class AddNewPaymentView extends StatelessWidget {
  final StudentDetail? studentData;
  final bool  ? isMisc;
  const AddNewPaymentView({super.key, this.studentData, this.isMisc});

  @override
  Widget build(BuildContext context) {


    final formKey = GlobalKey<FormState>();

    return Consumer<PaymentProvider>(
        builder: (context, paymentConsumer, child) {
      return IntrinsicHeight(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                SizedBox(
                  height: 10.h,
                ),
                AppRichTextView(
                    title: "Please Select Class",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.colorBlack),
                SizedBox(
                  height: 10.h,
                ),
                SemFeeDropdown(
                  studentData: studentData!,
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppRichTextView(
                    title: "Payment Type",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.colorBlack),
                SizedBox(
                  height: 5.h,
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: paymentConsumer.paymentTypeValue,
                  hint: AppRichTextView(
                    title: "Please Select Payment Type",
                    textColor: AppColors.colorGrey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  items: paymentConsumer.dropDownItems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    
                    paymentConsumer.setDropDownValue(newValue!);
                  },
                ),
                SizedBox(
                  height: 5.h,
                ),
                AppRichTextView(
                    title: "Amount in USD",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.colorBlack),
                SizedBox(
                  height: 5.h,
                ),
                AppTextFormFieldWidget(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (p0) => AmountValidator.validate(p0!),
                  onSaved: (p0) => paymentConsumer.amountInUsd = int.parse(p0!),
                  obscureText: false,
                  inputDecoration: InputDecoration(
                      hintText:
                           "Amount in USD",
                          
                      hintStyle: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.colorGrey,
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.colorc7e, width: 3.w))),
                ),
                SizedBox(
                  height: 5.h,
                ),
                AppRichTextView(
                    title: "Amount in GYD",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.colorBlack),
                SizedBox(
                  height: 5.h,
                ),
                AppTextFormFieldWidget(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (p0) => AmountValidator.validate(p0!),
                  onSaved: (p0) => paymentConsumer.amountInGyd = int.parse(p0!),
                      
                  obscureText: false,
                  inputDecoration: InputDecoration(
                      hintText: "Amount in GYD",
                      hintStyle: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.colorGrey,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.colorc7e, width: 3.w)),
                      border: const OutlineInputBorder()),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Consumer<InvoiceProvider>(
                      builder: (context, invoiceConsumer, child) {
                        return AppElevatedButon(
                          title: "Upload",
                          buttonColor: AppColors.colorWhite,
                          textColor: AppColors.color582,
                          borderColor: AppColors.color582,
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
                              if (formKey.currentState!.validate() &&
                                  context.mounted) {
                                formKey.currentState!.save();
                             var data = await  paymentConsumer.postPaymenData(studentData!.iD!, token, isMisc == true? invoiceConsumer.selectedMiscIndex! : invoiceConsumer.selectedInvoiceId!, isMisc!);
                             if(data !=null){
                              Navigator.pop(context);
                             }
                              }
                            }
                          },
                        );
                      }
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
                     
                      },
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
}
