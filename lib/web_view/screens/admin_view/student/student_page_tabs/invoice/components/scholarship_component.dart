import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScholarshipComponent extends StatelessWidget {
  const ScholarshipComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceProvider>(
        builder: (context, invoiceConsumer, child) {
      return Consumer<ProgramProvider>(
        builder: (context, programConsumer, child) {
          return programConsumer.selectedDept == null ? Container(): Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppRichTextView(
                  title: "Please Select Scholarship Type",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.colorBlack),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.color446, width: 3.w),
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
                                invoiceConsumer.setScholarshipValue(newValue!);
                              }
                            },
                            items: invoiceConsumer.scholarShipItems.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      );
    });
  }
}
