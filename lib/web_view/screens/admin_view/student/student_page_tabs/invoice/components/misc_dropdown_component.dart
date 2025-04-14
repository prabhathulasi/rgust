import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class MiscDropdownComponent extends StatelessWidget {
  const MiscDropdownComponent({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<InvoiceProvider>(
      builder: (context, invoiceConsumer, child) {
        return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.color446, width: 3.w),
                  borderRadius: BorderRadius.circular(8.sp)),
              height: 60.h,
              width: size.width * 0.2,
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    
                    iconEnabledColor: AppColors.color446,
                    iconSize: 34.sp,
                    dropdownColor: AppColors.colorWhite,
                    isExpanded: true,
                    value: invoiceConsumer.selectedMiscItem,
                    onChanged: (String? newValue) {
                      invoiceConsumer.setSelectedMiscItem(newValue!);
                    },
                    items: invoiceConsumer.miscList.map<DropdownMenuItem<String>>((String misc) {
                      return DropdownMenuItem<String>(
                        
                        value: misc,
                        child: AppRichTextView(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          title: misc,
                          textColor: AppColors.colorBlack,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
      }
    );
  }
}