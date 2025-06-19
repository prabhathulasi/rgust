import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class DynamicYearsDropdown extends StatefulWidget {
  const DynamicYearsDropdown({super.key});

  @override
  DynamicYearsDropdownState createState() => DynamicYearsDropdownState();
}

class DynamicYearsDropdownState extends State<DynamicYearsDropdown> {
  @override
  Widget build(BuildContext context) {
    var yearProvider = Provider.of<ProgramProvider>(context);

    List<int> years = [];

    // Generate a list of years based on the start and end years
    for (int i = yearProvider.startYear; i <= yearProvider.endYear; i++) {
      years.add(i +1);
    }
    var size = MediaQuery.sizeOf(context);
    return yearProvider.selectedClass == null
        ? Container()
        : Container(
            decoration: BoxDecoration(
                    border: Border.all(color: AppColors.color446, width: 3.w),
                    borderRadius: BorderRadius.circular(8.sp)),
            height: 60.h,
            width: size.width * 0.2,
            child: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  iconEnabledColor: AppColors.color446,
                iconSize: 34.sp,
                  dropdownColor: AppColors.colorWhite,
                  isExpanded: true,
                  value: yearProvider.selectedYear,
                  onChanged: (int? newValue) {
                    yearProvider
                        .setSelectedYear(newValue ?? DateTime.now().year);
                  },
                  items: years.map<DropdownMenuItem<int>>((int year) {
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
          );
  }
}
