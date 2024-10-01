import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_eng_proficieny_provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class EngProficiencyForm extends StatelessWidget {
  final PageController pageController;
  const EngProficiencyForm({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<AdmissionEngProficienyProvider>(
        builder: (context, admissionEngProficiencyConsumer, child) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppRichTextView(
                    title: "English Proficiency",
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
                    value: 0.45,
                  ),
                ),
              ],
            ),
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
                  groupValue:
                      admissionEngProficiencyConsumer.engProficiencyRadioValue,
                  onChanged: (String? value) {
                    admissionEngProficiencyConsumer
                        .setEngProficiencyValue(value!);
                  },
                ),
                AppRichTextView(
                    title: "Yes", fontSize: 12.sp, fontWeight: FontWeight.bold),
                Radio(
                  activeColor: AppColors.colorc7e,
                  value: "No",
                  groupValue:
                      admissionEngProficiencyConsumer.engProficiencyRadioValue,
                  onChanged: (String? value) {
                    admissionEngProficiencyConsumer
                        .setEngProficiencyValue(value!);
                    // admissionConsumer.setEngProficiencySectionValue(true);
                  },
                ),
                AppRichTextView(
                    title: "No", fontSize: 12.sp, fontWeight: FontWeight.bold),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            admissionEngProficiencyConsumer.engProficiencyRadioValue == "No" ||
             
                    admissionEngProficiencyConsumer.engProficiencyRadioValue ==
                        null
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
                              value: admissionEngProficiencyConsumer
                                  .engYearDropdownValue,
        
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
        
                              // Array list of items
                              items: admissionEngProficiencyConsumer.engYearsItems
                                  .map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                admissionEngProficiencyConsumer
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
                              value: admissionEngProficiencyConsumer
                                  .engLevelDropdownValue,
        
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
        
                              // Array list of items
                              items: admissionEngProficiencyConsumer.engYearsItems
                                  .map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                admissionEngProficiencyConsumer
                                    .setEngLevalDropDownValue(newValue!);
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: AppRichTextView(
                                title:
                                    "Have you taken any English proficiency examinations?",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Radio(
                            activeColor: AppColors.colorc7e,
                            value: "Yes",
                            groupValue:
                                admissionEngProficiencyConsumer.engExamRadioValue,
                            onChanged: (String? value) {
                              admissionEngProficiencyConsumer
                                  .setEngExamValue(value!);
                            },
                          ),
                          AppRichTextView(
                              title: "Yes",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                          Radio(
                            activeColor: AppColors.colorc7e,
                            value: "No",
                            groupValue:
                                admissionEngProficiencyConsumer.engExamRadioValue,
                            onChanged: (String? value) {
                              admissionEngProficiencyConsumer
                                  .setEngExamValue(value!);
                            },
                          ),
                          AppRichTextView(
                              title: "No",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      admissionEngProficiencyConsumer.engExamRadioValue == "Yes"
                          ? Center(
                              child: DottedBorder(
                                strokeCap: StrokeCap.butt,
                                color: AppColors.colorc7e,
                                strokeWidth: 2,
                                child: SizedBox(
                                    height: 200.h,
                                    width: size.width,
                                    child: InkWell(
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
                                          if (!fileNamePattern.hasMatch(
                                              result.files.first.name)) {
                                            ToastHelper().errorToast(
                                                "Invalid file name format. Expected format: Receipt_1234");
                                          } else {
                                            // if (result.files.first.size <= 100 * 1024) {
                                            //   invoiceConsumer
                                            //       .setFileValue(result.files.first.name);
                                            //   invoiceConsumer.setMediaFileValue(result);
                                            // } else {
                                            //   ToastHelper().errorToast(
                                            //       "Selected file must be less than 100KB.");
                                            // }
                                          }
                                        }
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            ImagePath.uploadPdfLogo,
                                            width: 50.w,
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          AppRichTextView(
                                            title:
                                                "Please Attach PDF file to Upload",
                                            textColor: AppColors.colorBlack,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w800,
                                          ),
                                          
                                        ],
                                      ),
                                    )),
                              ),
                            )
                          : Container(),
                          SizedBox(height: 10.h,)
                    ],
                  ),
            Row(
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
                  onPressed: (context) async {
                    admissionEngProficiencyConsumer
                        .setEngProficiencySectionValue(true);
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeIn);
                  },
                  textColor: AppColors.colorWhite,
                  height: 50.h,
                  width: 200.w,
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
