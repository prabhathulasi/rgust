import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_program_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';

import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgramDetailsForm extends StatelessWidget {
  final PageController pageController;
  const ProgramDetailsForm({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<AdmissionProgramProvider>(
        builder: (context, admissionProgramConsumer, child) {
      List<int> years = [];

      // Generate a list of years based on the start and end years
      for (int i = admissionProgramConsumer.startYear;
          i <= admissionProgramConsumer.endYear;
          i++) {
        years.add(i + 1);
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppRichTextView(
                  title: "Programme Details",
                  textColor: AppColors.colorc7e,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold),
              SizedBox(
                width: size.width * 0.2,
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.colorGrey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.sp),
                  color: AppColors.colorc7e,
                  minHeight: 15.sp,
                  value: 0.2,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRichTextView(
                        title: "Student Type",
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
                            value: admissionProgramConsumer
                                .studentTypeDropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: admissionProgramConsumer.studentType
                                .map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              admissionProgramConsumer
                                  .setStudentTypeDropDownValue(newValue!);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRichTextView(
                        title: "Programme",
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
                            value: admissionProgramConsumer
                                .programNamesDropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: admissionProgramConsumer.programNames
                                .map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              admissionProgramConsumer
                                  .setprogramNamesDropDownValue(newValue!);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRichTextView(
                        title: "Year",
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
                          child: DropdownButton<int>(
                            isDense: true,

                            // Initial Value
                            hint: AppRichTextView(
                                title: "Select",
                                fontSize: 10.sp,
                                textColor: AppColors.colorGrey,
                                fontWeight: FontWeight.w400),
                            value:
                                admissionProgramConsumer.semYearDropDownValue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: years.map<DropdownMenuItem<int>>((int year) {
                              return DropdownMenuItem<int>(
                              value: year,
                                child: Text(year.toString()),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (int? newValue) {
                              admissionProgramConsumer
                                  .setSemYearDropDownValue(newValue!);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
             admissionProgramConsumer.semYearDropDownValue== null? Container(): Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRichTextView(
                        title: "Semester",
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
                            value:
                                admissionProgramConsumer.semMonthDropDownValue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: admissionProgramConsumer.semMonth
                                .map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text("$items - ${admissionProgramConsumer.semYearDropDownValue}"),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              admissionProgramConsumer
                                  .setSemMonthDropDownValue(newValue!);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          AppRichTextView(
                    title:
                        "Financial Details",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),

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
                            value:
                                admissionProgramConsumer.finInfoDropDownValue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: admissionProgramConsumer.finInfo
                                .map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              admissionProgramConsumer
                                  .setFinInfoDropDownValue(newValue!);
                            },
                          ),
                        ),
                      ),
                    ),
              
              SizedBox(
            height: 15.h,
          ),
admissionProgramConsumer.finInfoDropDownValue == null? Container(): 
               SizedBox(
            height: 15.h,
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: AppRichTextView(
                    title:
                        "Have you previously applied to study or enrolled to any other medical universities in Guyana or out of Guyana.",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 20.w,
              ),
              Radio(
                activeColor: AppColors.colorc7e,
                value: "Yes",
                groupValue: admissionProgramConsumer.preEnrollRadio,
                onChanged: (String? value) {
                  admissionProgramConsumer.setPreEnrollRadioValue(value!);
                },
              ),
              AppRichTextView(
                  title: "Yes", fontSize: 12.sp, fontWeight: FontWeight.bold),
              Radio(
                activeColor: AppColors.colorc7e,
                value: "No",
                groupValue: admissionProgramConsumer.preEnrollRadio,
                onChanged: (String? value) {
                  admissionProgramConsumer.setPreEnrollRadioValue(value!);
                },
              ),
              AppRichTextView(
                  title: "No", fontSize: 12.sp, fontWeight: FontWeight.bold),
            ],
          ),
          admissionProgramConsumer.preEnrollRadio == "Yes"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    AppRichTextView(
                        title: "University Name",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppTextFormFieldWidget(
                      obscureText: false,
                      inputDecoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.colorc7e, width: 2.w)),
                          prefixIcon: const Icon(Icons.business_rounded),
                          hintText: "Enter University Name Name",
                          hintStyle: GoogleFonts.roboto(
                              fontSize: 12.sp, color: AppColors.colorGrey)),
                    )
                  ],
                )
              : Container(),
              const Spacer(),
          Expanded(
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppElevatedButon(
                  borderColor: AppColors.colorc7e,
                  title: "Back",
                  buttonColor: AppColors.colorWhite,
                  onPressed: (context) {
                    pageController.previousPage(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeOut);
                  },
                  textColor: AppColors.colorc7e,
                  height: 50.h,
                  width: 120.w,
                ),
                AppElevatedButon(
                  title: "Save & Continue",
                  buttonColor: AppColors.colorc7e,
                  onPressed: (context) {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeIn);
                  },
                  textColor: AppColors.colorWhite,
                  height: 50.h,
                  width: 200.w,
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
