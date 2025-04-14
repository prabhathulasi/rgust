import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/student/student_page_tabs/invoice/components/misc_dropdown_component.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class FormComponent extends StatelessWidget {
  const FormComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceProvider>(
        builder: (context, invoiceConsumer, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppRichTextView(
              title: "Description",
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              textColor: AppColors.colorBlack),
          SizedBox(
            height: 5.h,
          ),
         invoiceConsumer.feeType == "tution"? Consumer<ProgramProvider>(
           builder: (context, programConsumer, child) {
             return AppTextFormFieldWidget(
              
                textEditingController: invoiceConsumer.invoiceDescriptionController,
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
                        borderSide:
                            BorderSide(color: AppColors.colorc7e, width: 3.w))),
              );
           }
         ) : const MiscDropdownComponent(),
          SizedBox(
            height: 5.h,
          ),
          AppRichTextView(
              title: "Amount in USD",
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
                  onChanged: (p0) {
                    invoiceConsumer.gydAmountController.clear();
                    invoiceConsumer.conversionRateController.clear();
                  },
                  textEditingController: invoiceConsumer.usdAmountController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                              color: AppColors.colorc7e, width: 3.w))),
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                              color: AppColors.colorc7e, width: 3.w))),
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
              fontWeight: FontWeight.bold,
              textColor: AppColors.colorBlack),
          SizedBox(
            height: 5.h,
          ),
          AppTextFormFieldWidget(
            textEditingController: invoiceConsumer.gydAmountController,
            enable: false,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            obscureText: false,
            inputDecoration: InputDecoration(
                hintText: invoiceConsumer.gydAmountController.text.isEmpty
                    ? "Amount in GYD"
                    : invoiceConsumer.gydAmountController.text,
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
        ],
      );
    });
  }
}
