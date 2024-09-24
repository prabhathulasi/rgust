import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class AddNewInvoiceView extends StatelessWidget {
  final int studentId;
  final String? studentRegNo;
  const AddNewInvoiceView(
      {super.key, required this.studentId, required this.studentRegNo});

  @override
  Widget build(BuildContext context) {
    String? fromAccountNumber;
    String? bankName;
    int? amountInUsd;

    final formKey = GlobalKey<FormState>();

    return Consumer<InvoiceProvider>(
        builder: (context, invoiceConsumer, child) {
      return IntrinsicHeight(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: DottedBorder(
                  color: AppColors.colorc7e,
                  child: SizedBox(
                    height: 200.h,
                    width: 400.w,
                    child: invoiceConsumer.selectedFileName == null ||
                            invoiceConsumer.selectedFileName == ""
                        ? InkWell(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf'],
                                allowMultiple: false,
                              );
                              if (result != null) {
                                final RegExp fileNamePattern =
                                    RegExp(r'^Receipt_\d{4}\.pdf$');
                                if (!fileNamePattern
                                    .hasMatch(result.files.first.name)) {
                                  ToastHelper().errorToast(
                                      "Invalid file name format. Expected format: Receipt_1234");
                                } else {
                                  if (result.files.first.size <= 100 * 1024) {
                                    invoiceConsumer
                                        .setFileValue(result.files.first.name);
                                    invoiceConsumer.setMediaFileValue(result);
                                  } else {
                                    ToastHelper().errorToast(
                                        "Selected file must be less than 100KB.");
                                  }
                                }
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImagePath.uploadPdfLogo,
                                  width: 50.w,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                AppRichTextView(
                                  title: "Please Attach PDF file to Upload",
                                  textColor: AppColors.colorBlack,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ],
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImagePath.uploadPdfLogo,
                                width: 50.w,
                              ),
                              AppRichTextView(
                                title: invoiceConsumer.selectedFileName!,
                                textColor: AppColors.colorBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                  onTap: () {
                                    invoiceConsumer.setFileValue("");
                                  },
                                  child: Icon(
                                    Icons.delete_outline,
                                    size: 30.sp,
                                    color: AppColors.colorRed,
                                  )),
                            ],
                          ),
                  ),
                ),
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
              AppRichTextView(
                  title: "Bank Account Number",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.colorBlack),
              SizedBox(
                height: 5.h,
              ),
              AppTextFormFieldWidget(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (p0) => BankAccountNumberValidator.validate(p0!),
                onSaved: (p0) => fromAccountNumber = p0,
                obscureText: false,
                inputDecoration: InputDecoration(
                    hintText: "From Bank Account Number",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.colorGrey,
                    ),
                    border: const OutlineInputBorder()),
              ),
              SizedBox(
                height: 5.h,
              ),
              AppRichTextView(
                  title: "Bank Name",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.colorBlack),
              SizedBox(
                height: 5.h,
              ),
              AppTextFormFieldWidget(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                ],
                validator: (p0) => BankNameValidator.validate(p0!),
                onSaved: (p0) => bankName = p0,
                obscureText: false,
                inputDecoration: InputDecoration(
                    hintText: "Bank Name",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.colorGrey,
                    ),
                    border: const OutlineInputBorder()),
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
                onChanged: (p0) {
                  if (p0.isEmpty) {
                    invoiceConsumer.setGydConversionValue(int.parse("0"));
                  } else {
                    invoiceConsumer.setGydConversionValue(int.parse(p0));
                  }
                },
                obscureText: false,
                inputDecoration: InputDecoration(
                    hintText: invoiceConsumer.usdConversion == 0
                        ? "Amount in USD"
                        : invoiceConsumer.usdConversion.round().toString(),
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.colorGrey,
                    ),
                    border: const OutlineInputBorder()),
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
                enable: false,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                // validator: (p0) => AmountValidator.validate(p0!),
                // onSaved: (p0) => amountInGyd = int.parse(p0!),
                onChanged: (p0) {
                  if (p0.isEmpty) {
                    invoiceConsumer.setUsdConversionValue(int.parse("0"));
                  } else {
                    invoiceConsumer.setUsdConversionValue(int.parse(p0));
                  }
                },
                obscureText: false,
                inputDecoration: InputDecoration(
                    hintText: invoiceConsumer.gydConversion == 0
                        ? "Amount in GYD"
                        : invoiceConsumer.gydConversion.round().toString(),
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.colorGrey,
                    ),
                    border: const OutlineInputBorder()),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  AppElevatedButon(
                    title: "Upload",
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
                        if (formKey.currentState!.validate() &&
                            context.mounted) {
                          formKey.currentState!.save();
                          invoiceConsumer.uploadStudentInvoice(
                            studentRegNo: studentRegNo,
                            context,
                            token: token,
                            studentId: studentId,
                            amountInGyd: invoiceConsumer.gydConversion.round(),
                            amountInUsd: amountInUsd,
                            bankName: bankName,
                            fromAccountNumber: fromAccountNumber,
                          );
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
    });
  }
}
