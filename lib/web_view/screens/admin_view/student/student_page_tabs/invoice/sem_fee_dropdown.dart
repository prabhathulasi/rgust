import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/provider/fees_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class SemFeeDropdown extends StatefulWidget {
  final StudentDetail studentData;
  const SemFeeDropdown({super.key, required this.studentData});

  @override
  State<SemFeeDropdown> createState() => _SemFeeDropdownState();
}

class _SemFeeDropdownState extends State<SemFeeDropdown> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var data = widget.studentData.registeredCourse;
    final category = _getCategories(data);
    return Consumer<FeesProvider>(builder: (context, feesConsumer, child) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.colorc7e, width: 3.w),
            borderRadius: BorderRadius.circular(8.sp)),
        height: 60.h,
        width: size.width * 0.2,
        child: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              iconSize: 34.sp,
              iconEnabledColor: AppColors.colorc7e,
              dropdownColor: AppColors.colorWhite,
              isExpanded: true,
              value: feesConsumer.semFeeId,
              items: category.map<DropdownMenuItem<String>>(
                  (Map<String, dynamic> category) {
                return DropdownMenuItem<String>(
                  value: category["class_id"].toString(),
                  child: AppRichTextView(
                    fontSize: 15.sp,
                    title: category["class_name"],
                    fontWeight: FontWeight.w700,
                    textColor: AppColors.colorBlack,
                  ),
                );
              }).toList(),
              hint: AppRichTextView(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                title: "Please Select the Class",
                textColor: AppColors.colorBlack,
              ),
              onChanged: (String? value) async {
                print(value);
                feesConsumer.setSemFeeId(value!);
         
              },
            ),
          ),
        ),
      );
    });
  }
}

List<Map<String, dynamic>> _getCategories(List<RegisteredCourse>? data) {
  return data!.map((item) => {
    
    "class_id": item.classId,
        "class_name": item.className!
      }).toList()
      .fold<List<Map<String, dynamic>>>([], (accumulator, current) {
        if (!accumulator.any((item) => item["class_id"] == current["class_id"])) {
          accumulator.add(current);
        }
        return accumulator;
      });
}