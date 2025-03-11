import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/provider/fees_provider.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';

import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/invoice/sem_fee_dropdown.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class AddNewInvoiceView extends StatelessWidget {
  final StudentDetail? studentData;
  const AddNewInvoiceView({super.key, this.studentData});

  @override
  Widget build(BuildContext context) {
    int? amountInUsd;
    int? amountInGyd;

    final formKey = GlobalKey<FormState>();

    return Consumer<StudentProvider>(
      builder: (context, studentConsumer, child) {
        return Consumer<InvoiceProvider>(
            builder: (context, invoiceConsumer, child) {
          return Consumer<FeesProvider>(
            builder: (context, feesConsumer, child) {
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
                          value: invoiceConsumer.dropdownvalue,
                          hint: AppRichTextView(
                            title: "Please Select Payment Type",
                            textColor: AppColors.colorGrey,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          items: invoiceConsumer.dropDownItems.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            
                            invoiceConsumer.setDropDownValue(newValue!);
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
                          onSaved: (p0) => amountInUsd = int.parse(p0!),
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
                          onSaved: (p0) => amountInGyd = int.parse(p0!),
                              
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
                            AppElevatedButon(
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
                                    invoiceConsumer.uploadStudentInvoice(
                                      studentRegNo: studentData!.studentId,
                                      context,
                                      token: token,
                                      studentId: studentData!.iD,
                                      amountInGyd: amountInGyd,
                                      amountInUsd: amountInUsd,
                                      semfeeId: int.parse(feesConsumer.semFeeId!)
                                    );
                                     feesConsumer.setSemFeeId(null);
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
                                feesConsumer.setSemFeeId(null);
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          );
        });
      }
    );
  }
}
