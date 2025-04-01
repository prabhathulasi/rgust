import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:html' as html;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/invoice/invoice_model.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/department/program_dropdown_view.dart';

import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/invoice/pdf_generate/student_invoice_generate.dart';

import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class AddNewInvoiceView extends StatelessWidget {
  final StudentDetail? studentData;
  const AddNewInvoiceView({super.key, this.studentData});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    final formKey = GlobalKey<FormState>();

    return Consumer<InvoiceProvider>(
        builder: (context, invoiceConsumer, child) {
      DateTime now = DateTime.now();
      return Container(
        color: AppColors.colorWhite,
        height: size.height,
        width: size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(right: 18.0.w),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        AppRichTextView(
                            title: "Please Select Program",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.colorBlack),
                        SizedBox(
                          height: 10.h,
                        ),
                        ProgramDropdown(
                          isenabled: invoiceConsumer.invoiceList.isEmpty
                              ? true
                              : false,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        AppRichTextView(
                            title: "Please Select Scholarship Type",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.colorBlack),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                                color: AppColors.color446, width: 3.w),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                focusColor: AppColors.colorWhite,
                                value: invoiceConsumer
                                    .selectedScholarshipItem, // Set the current value
                                hint: const Text(
                                    'Select an option'), // Hint text if no item is selected
                                onChanged: (newValue) {
                                  if (invoiceConsumer.invoiceList.isEmpty) {
                                    invoiceConsumer
                                        .setScholarshipValue(newValue!);
                                  }
                                },
                                items: invoiceConsumer.scholarShipItems
                                    .map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        invoiceConsumer.selectedScholarshipItem == null ||
                                invoiceConsumer.selectedScholarshipItem == "N/A"
                            ? Container()
                            : AppRichTextView(
                                title: "Scholarship Amount",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                textColor: AppColors.colorBlack),
                        SizedBox(
                          height: 5.h,
                        ),
                        invoiceConsumer.selectedScholarshipItem == null ||
                                invoiceConsumer.selectedScholarshipItem == "N/A"
                            ? Container()
                            : AppTextFormFieldWidget(
                                enable: invoiceConsumer.invoiceList.isEmpty
                                    ? true
                                    : false,
                                onChanged: (p0) {
                                  invoiceConsumer.gydAmountController.text =
                                      "0";
                                  invoiceConsumer
                                      .conversionRateController.text = "0";
                                },
                                textEditingController:
                                    invoiceConsumer.scholarshipController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                obscureText: false,
                                inputDecoration: InputDecoration(
                                    hintText: "Scholarship Amount in USD",
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
                        SizedBox(
                          height: 10.h,
                        ),
                        AppRichTextView(
                            title: "Description",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            textColor: AppColors.colorBlack),
                        SizedBox(
                          height: 5.h,
                        ),
                        AppTextFormFieldWidget(
                          textEditingController:
                              invoiceConsumer.invoiceDescriptionController,
                          obscureText: false,
                          inputDecoration: InputDecoration(
                              hintText: "Invoice Description",
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
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: AppTextFormFieldWidget(
                                onChanged: (p0) {
                                  invoiceConsumer.gydAmountController.clear();
                                  invoiceConsumer.conversionRateController
                                      .clear();
                                },
                                textEditingController:
                                    invoiceConsumer.usdAmountController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                obscureText: false,
                                inputDecoration: InputDecoration(
                                    hintText: "Amount in USD",
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
                                textEditingController:
                                    invoiceConsumer.conversionRateController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (p0) {
                                  invoiceConsumer.updateConvertedAmount(p0);
                                },
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return "Please Enter the Conversion Rate";
                                  }
                                  return null;
                                },
                                obscureText: false,
                                inputDecoration: InputDecoration(
                                    hintText: "218",
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
                          textEditingController:
                              invoiceConsumer.gydAmountController,
                          enable: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          obscureText: false,
                          inputDecoration: InputDecoration(
                              hintText: invoiceConsumer
                                      .gydAmountController.text.isEmpty
                                  ? "Amount in GYD"
                                  : invoiceConsumer.gydAmountController.text,
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.colorGrey,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.colorc7e, width: 3.w)),
                              border: const OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Consumer<ProgramProvider>(
                            builder: (context, programConsumer, child) {
                          return Row(
                            children: [
                              AppElevatedButon(
                                title: "Add",
                                buttonColor: AppColors.colorWhite,
                                textColor: AppColors.color582,
                                borderColor: AppColors.color582,
                                height: 50.h,
                                width: 100.w,
                                onPressed: (context) async {
                                  if (programConsumer.selectedDept == null) {
                                    ToastHelper()
                                        .errorToast("Please Select Program");
                                  } else if (invoiceConsumer
                                      .invoiceDescriptionController
                                      .text
                                      .isEmpty) {
                                    ToastHelper().errorToast(
                                        "Please Enter Invoice Description");
                                  } else if (invoiceConsumer
                                      .usdAmountController.text.isEmpty) {
                                    ToastHelper().errorToast(
                                        "Please Enter Amount in USD");
                                  } else if (invoiceConsumer
                                      .conversionRateController.text.isEmpty) {
                                    ToastHelper().errorToast(
                                        "Please Enter Conversion Rate");
                                  } else {
                                    invoiceConsumer.addInvoice(
                                      InvoiceModel(
                                          scholarshipType: invoiceConsumer
                                              .selectedScholarshipItem!,
                                          scholarshipAmount:
                                              invoiceConsumer.selectedScholarshipItem ==
                                                      "N/A"
                                                  ? 0
                                                  : int.parse(invoiceConsumer
                                                      .scholarshipController
                                                      .text),
                                          title: programConsumer.selectedDept!,
                                          description: invoiceConsumer
                                              .invoiceDescriptionController
                                              .text,
                                          usd: invoiceConsumer
                                                  .usdAmountController
                                                  .text
                                                  .isEmpty
                                              ? 0
                                              : int.parse(invoiceConsumer
                                                  .usdAmountController.text),
                                          gyd: invoiceConsumer
                                                  .gydAmountController
                                                  .text
                                                  .isEmpty
                                              ? 0
                                              : int.parse(invoiceConsumer.gydAmountController.text),
                                          studentId: studentData!.iD!),
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                             invoiceConsumer.invoiceList.isEmpty? Container(): AppElevatedButon(
                                title: "Clear",
                                buttonColor: AppColors.colorWhite,
                                textColor: AppColors.colorRed,
                                borderColor: AppColors.colorRed,
                                height: 50.h,
                                width: 100.w,
                                onPressed: (context) async {
                                  invoiceConsumer.clearInvoiceList();
                                },
                              ),
                            ],
                          );
                        }),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            VerticalDivider(
              color: AppColors.colorBlack,
              width: 1.w,
            ),
            Expanded(
                flex: 1,
                child: SizedBox(
                  height: size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AppRichTextView(
                            title: "Generate Invoice",
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.colorBlack),
                        invoiceConsumer.invoiceList.isEmpty
                            ? SizedBox(
                                height: size.height * 0.6,
                                child: Center(
                                    child: AppRichTextView(
                                        title: "No Invoice",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorRed)),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            ImagePath.webrgustLogo,
                                            height: 100.h,
                                            width: 100.w,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                AppRichTextView(
                                                    title:
                                                        "Rajiv Gandhi University of Science and Technology",
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    textColor:
                                                        AppColors.colorBlue),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                AppRichTextView(
                                                    title:
                                                        "Department of Finance",
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    textColor:
                                                        AppColors.colorBlack),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                AppRichTextView(
                                                    title: "Student Invoice",
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    textColor:
                                                        AppColors.colorBlack),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Row(
                                        children: [
                                          AppRichTextView(
                                              title: "Student Name",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          AppRichTextView(
                                              title:
                                                  "${studentData!.firstName!} ${studentData!.lastName!}",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                          const Spacer(),
                                          AppRichTextView(
                                              title: "Invoice Date",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          AppRichTextView(
                                              title: DateFormat(
                                                      'yyyy-MM-dd – kk:mm')
                                                  .format(now)
                                                  .toString(),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          AppRichTextView(
                                              title: "Registration#",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          AppRichTextView(
                                              title:
                                                  " ${studentData!.studentId}",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                          const Spacer(),
                                          AppRichTextView(
                                              title: "Invoice#:",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          AppRichTextView(
                                              title:
                                                  "Rgust/${DateFormat("yyyy/MMM").format(DateTime.now())}/11",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          AppRichTextView(
                                              title: "Program:",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          AppRichTextView(
                                              title: "Pre-Medicine",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                          const Spacer(),
                                          AppRichTextView(
                                              title: "Scholarship Type:",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          AppRichTextView(
                                              title: invoiceConsumer
                                                  .selectedScholarshipItem!,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: AppRichTextView(
                                                title: "Details",
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor:
                                                    AppColors.colorBlack),
                                          ),
                                          const Spacer(),
                                          Expanded(
                                            flex: 1,
                                            child: AppRichTextView(
                                                title: "Amount in GYD",
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor:
                                                    AppColors.colorBlack),
                                          ),
                                          const Spacer(),
                                          Expanded(
                                            flex: 1,
                                            child: AppRichTextView(
                                                title: "Amount in USD",
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor:
                                                    AppColors.colorBlack),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            invoiceConsumer.invoiceList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 20.w),
                                                        child: AppRichTextView(
                                                            maxLines: 3,
                                                            title: invoiceConsumer
                                                                .invoiceList[
                                                                    index]
                                                                .description,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            textColor: AppColors
                                                                .colorBlack),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AppRichTextView(
                                                          title:
                                                              "${invoiceConsumer.invoiceList[index].gyd}",
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          textColor: AppColors
                                                              .colorBlack),
                                                    ),
                                                    const Spacer(),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AppRichTextView(
                                                          title:
                                                              "${invoiceConsumer.invoiceList[index].usd}",
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          textColor: AppColors
                                                              .colorBlack),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(flex: 2, child: Container()),
                                          const Spacer(),
                                          Expanded(
                                            flex: 1,
                                            child: AppRichTextView(
                                                title: "Total GYD",
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor:
                                                    AppColors.colorBlack),
                                          ),
                                          const Spacer(),
                                          Expanded(
                                            flex: 1,
                                            child: AppRichTextView(
                                                title: "Total USD",
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor:
                                                    AppColors.colorBlack),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(flex: 2, child: Container()),
                                          const Spacer(),
                                          Expanded(
                                            flex: 1,
                                            child: AppRichTextView(
                                                title: (invoiceConsumer
                                                        .invoiceList
                                                        .fold(
                                                            0,
                                                            (sum, item) =>
                                                                sum + item.gyd))
                                                    .toString(),
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor:
                                                    AppColors.colorBlack),
                                          ),
                                          const Spacer(),
                                          Expanded(
                                            flex: 1,
                                            child: AppRichTextView(
                                                title: (invoiceConsumer
                                                        .invoiceList
                                                        .fold(
                                                            0,
                                                            (sum, item) =>
                                                                sum + item.usd))
                                                    .toString(),
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor:
                                                    AppColors.colorBlack),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          AppRichTextView(
                                              title: "Total Amount (USD): ",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          AppRichTextView(
                                              title: (invoiceConsumer
                                                      .invoiceList
                                                      .fold(
                                                          0,
                                                          (sum, item) =>
                                                              sum + item.usd))
                                                  .toString(),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          AppRichTextView(
                                              title:
                                                  "Scholarship Amount (USD): ",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          AppRichTextView(
                                              title: invoiceConsumer
                                                  .invoiceList[0]
                                                  .scholarshipAmount
                                                  .toString(),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          AppRichTextView(
                                              title: "Payable Amount (USD): ",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          AppRichTextView(
                                              title: (invoiceConsumer
                                                          .invoiceList
                                                          .fold(
                                                              0,
                                                              (sum, item) =>
                                                                  sum +
                                                                  item.usd) -
                                                      invoiceConsumer
                                                          .invoiceList[0]
                                                          .scholarshipAmount)
                                                  .toString(),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack)
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: AppRichTextView(
                                            textDecoration:
                                                TextDecoration.underline,
                                            title: "Important",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            textColor: AppColors.colorBlack),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      invoiceConsumer
                                              .customMsgController.text.isEmpty
                                          ? Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: AppTextFormFieldWidget(
                                                    textEditingController:
                                                        invoiceConsumer
                                                            .customMsgController,
                                                    obscureText: false,
                                                    inputDecoration:
                                                        InputDecoration(
                                                            hintText:
                                                                "Add Custom Message",
                                                            hintStyle:
                                                                GoogleFonts
                                                                    .roboto(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .colorGrey,
                                                            ),
                                                            border:
                                                                const OutlineInputBorder(),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppColors
                                                                        .colorc7e,
                                                                    width:
                                                                        3.w))),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                AppElevatedButon(
                                                  title: "save",
                                                  borderColor:
                                                      AppColors.color446,
                                                  buttonColor:
                                                      AppColors.colorWhite,
                                                  height: 50.h,
                                                  width: 100.w,
                                                  textColor: AppColors.color446,
                                                  onPressed: (context) {
                                                    invoiceConsumer
                                                        .setCustomMessageValue(
                                                            invoiceConsumer
                                                                .customMsgController
                                                                .text);
                                                  },
                                                )
                                              ],
                                            )
                                          : Align(
                                              alignment: Alignment.centerLeft,
                                              child: AppRichTextView(
                                                  maxLines: 10,
                                                  title: invoiceConsumer
                                                      .customMessage!,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorBlack),
                                            ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: AppRichTextView(
                                            textDecoration:
                                                TextDecoration.underline,
                                            fontStyle: FontStyle.italic,
                                            title:
                                                "Bank Information for Guyanese Students",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            textColor: AppColors.colorBlack),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          AppRichTextView(
                                              title: "Name of University: ",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          AppRichTextView(
                                              title:
                                                  "Rajiv Gandhi University of Science and Technology",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          AppRichTextView(
                                              title: "Name of Bank: ",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          AppRichTextView(
                                              title: "Demerara Bank Ltd",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          AppRichTextView(
                                              title: "Account Name: ",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          AppRichTextView(
                                              title:
                                                  "Rajiv Gandhi University of Science and Technology",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          AppRichTextView(
                                              title: "Account#: ",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack),
                                          AppRichTextView(
                                              title: "401-907-1",
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorBlack),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      AppRichTextView(
                                          title:
                                              "3rd Street, Cummingslodge, East Coast Demerara, Guyana",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorBlue),
                                      AppRichTextView(
                                          title: "Telephone#: +(592) 222-6076.",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorBlue),
                                      AppRichTextView(
                                          title:
                                              "email:financedepartment@rgust.edu.gy                     website: www.rgust.edu.gy",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorBlue),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      invoiceConsumer
                                              .customMsgController.text.isEmpty
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.bottomRight,
                                              child: AppElevatedButon(
                                                  title: "Generate",
                                                  borderColor:
                                                      AppColors.color446,
                                                  buttonColor:
                                                      AppColors.colorWhite,
                                                  height: 50.h,
                                                  width: 130.w,
                                                  textColor: AppColors.color446,
                                                  onPressed: (context) async {
                                                    var result =
                                                        await generateNewInvoice(
                                                      PdfPageFormat.a4,
                                                      studentData!,
                                                      invoiceConsumer
                                                          .invoiceList,
                                                    );
                                                    final blob = html.Blob(
                                                        [result],
                                                        'application/pdf');
                                                    final url = html.Url
                                                        .createObjectUrlFromBlob(
                                                            blob);

                                                    // Open the blob URL in a new tab
                                                    html.window
                                                        .open(url, '_blank');
                                                  }),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      );
    });
  }
}

showAddInvoiceAlert(BuildContext context, StudentDetail? studentData) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      backgroundColor: AppColors.colorWhite,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppRichTextView(
              title: "Add New Invoice",
              fontSize: 25.sp,
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
      content: AddNewInvoiceView(studentData: studentData));

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
