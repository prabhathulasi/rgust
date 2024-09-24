import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class EngProficiencyForm extends StatelessWidget {
  const EngProficiencyForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdmissionProvider>(
        builder: (context, admissionConsumer, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: AppRichTextView(
                    title: "Are you international student?",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 20.w,
              ),
              Radio(
                activeColor: AppColors.colorc7e,
                value: "Yes",
                groupValue: admissionConsumer.engProficiencyRadioValue,
                onChanged: (String? value) {
                  admissionConsumer.setEngProficiencyValue(value!);
                },
              ),
              AppRichTextView(
                  title: "Yes", fontSize: 12.sp, fontWeight: FontWeight.bold),
              Radio(
                activeColor: AppColors.colorc7e,
                value: "No",
                groupValue: admissionConsumer.engProficiencyRadioValue,
                onChanged: (String? value) {
                  admissionConsumer.setEngProficiencyValue(value!);
                  admissionConsumer.setEngProficiencySectionValue(true);
                },
              ),
              AppRichTextView(
                  title: "No", fontSize: 12.sp, fontWeight: FontWeight.bold),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          admissionConsumer.engProficiencyRadioValue == "No" ||
                  admissionConsumer.engProficiencyRadioValue == "" ||
                  admissionConsumer.engProficiencyRadioValue == null
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRichTextView(
                        title: "How long have you been studying English?",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.colorGrey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.all(10.0.sp),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isDense: true,

                            // Initial Value
                            hint: AppRichTextView(
                                title: "Select",
                                fontSize: 10.sp,
                                textColor: AppColors.colorGrey,
                                fontWeight: FontWeight.w400),
                            value: admissionConsumer.engYearDropdownValue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: admissionConsumer.engYearsItems
                                .map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              admissionConsumer
                                  .setEngYearDropDownValue(newValue!);
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    AppRichTextView(
                        title: "What is your present level of English?",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.colorGrey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.all(10.0.sp),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isDense: true,

                            // Initial Value
                            hint: AppRichTextView(
                                title: "Select",
                                fontSize: 10.sp,
                                textColor: AppColors.colorGrey,
                                fontWeight: FontWeight.w400),
                            value: admissionConsumer.engLevelDropdownValue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: admissionConsumer.engYearsItems
                                .map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              admissionConsumer
                                  .setEngLevalDropDownValue(newValue!);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                )
        ],
      );
    });
  }
}
