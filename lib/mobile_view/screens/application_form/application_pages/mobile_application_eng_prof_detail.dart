import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_eng_proficieny_provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_login_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class MobileApplicationEngProfDetail extends StatelessWidget {
  final PageController pageController;
  const MobileApplicationEngProfDetail(
      {super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<AdmissionEngProficienyProvider>(
        builder: (context, admissionEngProficiencyConsumer, child) {
      List<String?> values = [
        admissionEngProficiencyConsumer.engProficiencyRadioValue,
        admissionEngProficiencyConsumer.engYearDropdownValue,
        admissionEngProficiencyConsumer.engLevelDropdownValue,
        admissionEngProficiencyConsumer.engExamRadioValue,
      ];
      // Check if all values are null
      bool allValuesNull = values.any((value) => value == null);

      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImagePath.webrgustLogo, width: 80.w),
                  SizedBox(
                    width: 15.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                          title:
                              "Rajiv Gandhi University of Science and Technology",
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold),
                      AppRichTextView(
                        textColor: AppColors.colorRed,
                        title: "A Brand for Quality Eduation",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppRichTextView(
                      title: "English Proficiency",
                      textColor: AppColors.colorc7e,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                  const Spacer(),
                  SizedBox(
                    width: size.width / 4,
                    child: LinearProgressIndicator(
                      backgroundColor: AppColors.colorGrey,
                      borderRadius: BorderRadius.circular(20.sp),
                      color: AppColors.colorc7e,
                      minHeight: 15.sp,
                      value: 0.47,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
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
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Radio(
                    activeColor: AppColors.colorc7e,
                    value: "Yes",
                    groupValue: admissionEngProficiencyConsumer
                        .engProficiencyRadioValue,
                    onChanged: (String? value) {
                      admissionEngProficiencyConsumer
                          .setEngProficiencyValue(value!);
                    },
                  ),
                  AppRichTextView(
                      title: "Yes",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold),
                  Radio(
                    activeColor: AppColors.colorc7e,
                    value: "No",
                    groupValue: admissionEngProficiencyConsumer
                        .engProficiencyRadioValue,
                    onChanged: (String? value) {
                      admissionEngProficiencyConsumer
                          .setEngProficiencyValue(value!);
                      // admissionConsumer.setEngProficiencySectionValue(true);
                    },
                  ),
                  AppRichTextView(
                      title: "No",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              admissionEngProficiencyConsumer.engProficiencyRadioValue ==
                          "No" ||
                      admissionEngProficiencyConsumer
                              .engProficiencyRadioValue ==
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
                                items: admissionEngProficiencyConsumer
                                    .engLevelItems
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
                                items: admissionEngProficiencyConsumer
                                    .engYearsItems
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
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: AppColors.colorc7e,
                              value: "Yes",
                              groupValue: admissionEngProficiencyConsumer
                                  .engExamRadioValue,
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
                              groupValue: admissionEngProficiencyConsumer
                                  .engExamRadioValue,
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
                        admissionEngProficiencyConsumer.engExamRadioValue ==
                                "Yes"
                            ? admissionEngProficiencyConsumer
                                        .selectedFileName ==
                                    null
                                ? Center(
                                    child: DottedBorder(
                                      strokeCap: StrokeCap.butt,
                                      color: AppColors.colorc7e,
                                      strokeWidth: 2,
                                      child: SizedBox(
                                          height: 130.h,
                                          width: size.width,
                                          child: InkWell(
                                            onTap: () async {
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: ['pdf'],
                                                allowMultiple: false,
                                              );
                                              if (result != null) {
                                                PlatformFile file =
                                                    result.files.first;
                                                admissionEngProficiencyConsumer
                                                    .addFile(
                                                        file.name,
                                                        base64Encode(
                                                            file.bytes!));
                                              } else {
                                                ToastHelper().errorToast(
                                                    "Please select a file to upload");
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
                                                  textColor:
                                                      AppColors.colorBlack,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  )
                                : Card(
                                    child: ListTile(
                                      title: Text(
                                          admissionEngProficiencyConsumer
                                              .selectedFileName!),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: AppColors.colorRed,
                                        ),
                                        onPressed: () {
                                          admissionEngProficiencyConsumer
                                              .clearFile();
                                        },
                                      ),
                                    ),
                                  )
                            : Container(),
                        SizedBox(
                          height: 10.h,
                        )
                      ],
                    ),
              admissionEngProficiencyConsumer.engProficiencyRadioValue !=
                          "No" &&
                      allValuesNull == true
                  ? Container()
                  : Center(
                      child: Consumer<AdmissionLoginProvider>(
                          builder: (context, admissionLoginConsumer, child) {
                        return AppElevatedButon(
                          title: "Save & Continue",
                          buttonColor: AppColors.colorc7e,
                          onPressed: (context) async {
                            if (admissionEngProficiencyConsumer
                                        .selectedFileName ==
                                    null &&
                                admissionEngProficiencyConsumer
                                        .engExamRadioValue ==
                                    "Yes") {
                              ToastHelper().errorToast("Please upload a file");
                            } else {
                              var applicationId =
                                  admissionLoginConsumer.applicationId;
                              var response =
                                  await admissionEngProficiencyConsumer
                                      .postAdmissionEngProfDetails(
                                          int.parse(applicationId!));
                              if (response.statusCode == 201) {
                                pageController.nextPage(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.easeIn);
                              } else {
                                ToastHelper()
                                    .errorToast(response.body.toString());
                              }
                            }
                          },
                          textColor: AppColors.colorWhite,
                          height: 50.h,
                          width: 200.w,
                        );
                      }),
                    )
            ],
          ),
        ),
      );
    });
  }
}
