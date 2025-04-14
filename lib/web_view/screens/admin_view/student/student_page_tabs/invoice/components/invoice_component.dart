import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class InvoiceComponent extends StatelessWidget {
  const InvoiceComponent({super.key});

  @override
  Widget build(BuildContext context) {
    var yearProvider = Provider.of<ProgramProvider>(context);

    List<int> years = [];

    // Generate a list of years based on the start and end years
    for (int i = yearProvider.startYear; i <= yearProvider.endYear; i++) {
      years.add(i + 1);
    }
    var size = MediaQuery.sizeOf(context);
    return Consumer<InvoiceProvider>(
        builder: (context, invoiceConsumer, child) {
      return invoiceConsumer.selectedScholarshipItem == null
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                AppRichTextView(
                    title: "Invoice Type",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.colorBlack),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Radio(
                      activeColor: AppColors.color446,
                      value: "sem",
                      groupValue: invoiceConsumer.invoiceType,
                      onChanged: (value) {
                        invoiceConsumer.setInvoiceType(value!);
                      },
                      focusNode: FocusNode(),
                      autofocus:
                          true, // Autofocus is optional, depending on the app's needs.
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    AppRichTextView(
                        title: "Semester",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack),
                    SizedBox(
                      width: 20.w,
                    ),
                    Radio(
                      activeColor: AppColors.color446,
                      value: "year",
                      groupValue: invoiceConsumer.invoiceType,
                      onChanged: (value) {
                        invoiceConsumer.setInvoiceType(value!);
                      },
                      focusNode: FocusNode(),
                      autofocus:
                          true, // Autofocus is optional, depending on the app's needs.
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    AppRichTextView(
                        title: "Year",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack),
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                invoiceConsumer.invoiceType == null
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppRichTextView(
                              title: "Please Select Year",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.colorBlack),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.colorc7e, width: 3.w),
                                borderRadius: BorderRadius.circular(8.sp)),
                            height: 60.h,
                            width: size.width * 0.2,
                            child: Padding(
                              padding: EdgeInsets.all(8.0.sp),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  iconEnabledColor: AppColors.colorc7e,
                                  iconSize: 34.sp,
                                  dropdownColor: AppColors.colorWhite,
                                  isExpanded: true,
                                  value: yearProvider.selectedYear,
                                  onChanged: (int? newValue) {
                                    yearProvider.setSelectedYear(
                                        newValue ?? DateTime.now().year);
                                  },
                                  items: years
                                      .map<DropdownMenuItem<int>>((int year) {
                                    return DropdownMenuItem<int>(
                                      value: year,
                                      child: AppRichTextView(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                        title: year.toString(),
                                        textColor: AppColors.colorBlack,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppRichTextView(
                              title: "Regular Tution Fee",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.colorBlack),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: AppTextFormFieldWidget(
                                  enable: invoiceConsumer.invoiceList.isEmpty
                                      ? true
                                      : false,
                                  onChanged: (p0) {},
                                  textEditingController: invoiceConsumer
                                      .regularTuitionFeeController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  obscureText: false,
                                  inputDecoration: InputDecoration(
                                      hintText: "Regular Tution Fee",
                                      hintStyle: GoogleFonts.roboto(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.colorGrey,
                                      ),
                                      border: const OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.colorc7e,
                                              width: 3.w))),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: AppRichTextView(
                                    title: "X",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    textColor: AppColors.colorBlack),
                              ),
                              Expanded(
                                flex: 1,
                                child: AppTextFormFieldWidget(
                                  enable: false,
                                  // textEditingController:
                                  //     invoiceConsumer.conversionRateController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (p0) {},
                                  obscureText: false,
                                  inputDecoration: InputDecoration(
                                      hintText:
                                          invoiceConsumer.invoiceType == "sem"
                                              ? "3"
                                              : "1",
                                      hintStyle: GoogleFonts.roboto(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.colorGrey,
                                      ),
                                      border: const OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.colorc7e,
                                              width: 3.w))),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          invoiceConsumer.selectedScholarshipItem == null ||
                                  invoiceConsumer.selectedScholarshipItem ==
                                      "N/A"
                              ? Container()
                              : AppRichTextView(
                                  title: "Scholarship Amount",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  textColor: AppColors.colorBlack),
                          SizedBox(
                            height: 5.h,
                          ),
                          invoiceConsumer.selectedScholarshipItem == null ||
                                  invoiceConsumer.selectedScholarshipItem ==
                                      "N/A"
                              ? Container()
                              : Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: AppTextFormFieldWidget(
                                        enable:
                                            invoiceConsumer.invoiceList.isEmpty
                                                ? true
                                                : false,
                                        onChanged: (p0) {
                                          invoiceConsumer
                                              .gydAmountController.text = "0";
                                          invoiceConsumer
                                              .conversionRateController
                                              .text = "0";
                                        },
                                        textEditingController: invoiceConsumer
                                            .scholarshipController,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        obscureText: false,
                                        inputDecoration: InputDecoration(
                                            hintText:
                                                "Scholarship Amount in USD",
                                            hintStyle: GoogleFonts.roboto(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.colorGrey,
                                            ),
                                            border: const OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors.colorc7e,
                                                    width: 3.w))),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: AppRichTextView(
                                          title: "X",
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorBlack),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: AppTextFormFieldWidget(
                                        enable: false,
                                        // textEditingController:
                                        //     invoiceConsumer.conversionRateController,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        onChanged: (p0) {},
                                        obscureText: false,
                                        inputDecoration: InputDecoration(
                                            hintText:
                                                invoiceConsumer.invoiceType ==
                                                        "sem"
                                                    ? "3"
                                                    : "1",
                                            hintStyle: GoogleFonts.roboto(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.colorGrey,
                                            ),
                                            border: const OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors.colorc7e,
                                                    width: 3.w))),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            );
    });
  }
}
