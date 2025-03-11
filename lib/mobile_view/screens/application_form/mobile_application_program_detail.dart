import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_login_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_program_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';

import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MobileApplicationProgramDetail extends StatelessWidget {
  final PageController pageController;
  const MobileApplicationProgramDetail(
      {super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var size = MediaQuery.sizeOf(context);
    return Consumer<AdmissionProgramProvider>(
        builder: (context, admissionProgramConsumer, child) {
      // Create a list of all values to check for null
      List<String?> values = [
        admissionProgramConsumer.studentTypeDropdownvalue,
        admissionProgramConsumer.programNamesDropdownvalue,
        admissionProgramConsumer.semMonthDropDownValue,
        admissionProgramConsumer.finInfoDropDownValue,
        admissionProgramConsumer.semYearDropDownValue.toString(),
        admissionProgramConsumer.preEnrollRadio
      ];
      // Check if all values are null
      bool allValuesNull = values.any((value) => value == null);

      List<int> years = [];

      // Generate a list of years based on the start and end years
      for (int i = admissionProgramConsumer.startYear;
          i <= admissionProgramConsumer.endYear;
          i++) {
        years.add(i + 1);
      }
      return Padding(
        padding: EdgeInsets.only(left: 18.w, right: 18.w,bottom: 18.h),
        child: SingleChildScrollView(
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
                        fontWeight: FontWeight.w400,
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
                      title: "Programme Details",
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
                      value: 0.2,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppRichTextView(
                          title: "Student Type",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                      SizedBox(
                        width: 5.w,
                      ),
                      AppRichTextView(
                          textColor: AppColors.colorRed,
                          title: "*",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
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
                              admissionProgramConsumer.studentTypeDropdownvalue,

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
              SizedBox(
                height: 10.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppRichTextView(
                          title: "Programme",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                      SizedBox(
                        width: 5.w,
                      ),
                      AppRichTextView(
                          textColor: AppColors.colorRed,
                          title: "*",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
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
              SizedBox(
                height: 10.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppRichTextView(
                          title: "Year",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                      SizedBox(
                        width: 5.w,
                      ),
                      AppRichTextView(
                          textColor: AppColors.colorRed,
                          title: "*",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
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
                          value: admissionProgramConsumer.semYearDropDownValue,

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
              SizedBox(
                width: 15.w,
              ),
              admissionProgramConsumer.semYearDropDownValue == null
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppRichTextView(
                                title: "Semester",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                            SizedBox(
                              width: 5.w,
                            ),
                            AppRichTextView(
                                textColor: AppColors.colorRed,
                                title: "*",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
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
                                    .semMonthDropDownValue,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: admissionProgramConsumer.semMonth
                                    .map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                        "$items - ${admissionProgramConsumer.semYearDropDownValue}"),
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
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  AppRichTextView(
                      title: "Financial Details",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    width: 5.w,
                  ),
                  AppRichTextView(
                      textColor: AppColors.colorRed,
                      title: "*",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ],
              ),
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
                      value: admissionProgramConsumer.finInfoDropDownValue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items:
                          admissionProgramConsumer.finInfo.map((String items) {
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
              admissionProgramConsumer.finInfoDropDownValue == null
                  ? Container()
                  : SizedBox(
                      height: 15.h,
                    ),
              Row(
                children: [
                  Expanded(
                    child: AppRichTextView(
                        maxLines: 2,
                        title:
                            "Have you previously applied to study or enrolled to any other medical universities in Guyana or out of Guyana.",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  AppRichTextView(
                      textColor: AppColors.colorRed,
                      title: "*",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
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
                    groupValue: admissionProgramConsumer.preEnrollRadio,
                    onChanged: (String? value) {
                      admissionProgramConsumer.setPreEnrollRadioValue(value!);
                    },
                  ),
                  AppRichTextView(
                      title: "Yes",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold),
                  Radio(
                    activeColor: AppColors.colorc7e,
                    value: "No",
                    groupValue: admissionProgramConsumer.preEnrollRadio,
                    onChanged: (String? value) {
                      admissionProgramConsumer.setPreEnrollRadioValue(value!);
                    },
                  ),
                  AppRichTextView(
                      title: "No",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold),
                ],
              ),
              admissionProgramConsumer.preEnrollRadio == "Yes"
                  ? Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              AppRichTextView(
                                  title: "University Name",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                              SizedBox(
                                width: 5.w,
                              ),
                              AppRichTextView(
                                  textColor: AppColors.colorRed,
                                  title: "*",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppTextFormFieldWidget(
                            onSaved: (p0) => admissionProgramConsumer
                                .enrolledUniversityName = p0,
                            validator: (p0) => p0!.isEmpty
                                ? "University Name is required."
                                : null,
                            obscureText: false,
                            inputDecoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.colorc7e, width: 2.w)),
                                prefixIcon: const Icon(Icons.business_rounded),
                                hintText: "Enter University Name",
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    color: AppColors.colorGrey)),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              AppRichTextView(
                                  title: "Program Name",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                              SizedBox(
                                width: 5.w,
                              ),
                              AppRichTextView(
                                  textColor: AppColors.colorRed,
                                  title: "*",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppTextFormFieldWidget(
                            onSaved: (p0) => admissionProgramConsumer
                                .enrolledProgramName = p0,
                            validator: (p0) => p0!.isEmpty
                                ? "Program Name is required."
                                : null,
                            obscureText: false,
                            inputDecoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.colorc7e, width: 2.w)),
                                prefixIcon: const Icon(Icons.business_rounded),
                                hintText: "Enter the Program Name",
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    color: AppColors.colorGrey)),
                          ),
                          SizedBox(
                            height: 15.sp,
                          ),
                          admissionProgramConsumer.selectedFileName == null
                              ? DottedBorder(
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
                                            for (var file in result.files) {
                                              if (file.size / 1024 > 500) {
                                                ToastHelper().errorToast(
                                                    "File size exceeds 500KB.");
                                              } else {
                                                admissionProgramConsumer
                                                    .addFile(
                                                        file.name,
                                                        base64Encode(
                                                            file.bytes!));
                                              }
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
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              title:
                                                  "Please Attach Supporting Documents of your previous enrollment",
                                              textColor: AppColors.colorBlack,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ],
                                        ),
                                      )),
                                )
                              : Card(
                                  child: ListTile(
                                    title: Text(admissionProgramConsumer
                                        .selectedFileName!),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: AppColors.colorRed,
                                      ),
                                      onPressed: () {
                                        admissionProgramConsumer.clearFile();
                                      },
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 15.sp,
              ),
              allValuesNull == true
                  ? Container()
                  :
              Center(
                child: Consumer<AdmissionLoginProvider>(
                    builder: (context, admissionLoginConsumer, child) {
                  return AppElevatedButon(
                    title: "Save & Continue",
                    buttonColor: AppColors.colorc7e,
                    onPressed: (context) async {
                      var applicationId = admissionLoginConsumer.applicationId;
                      if (admissionProgramConsumer.preEnrollRadio == "Yes") {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          // Get the current page index
                          int currentPageIndex =
                              pageController.page?.round() ?? 0;
                          var response = await admissionProgramConsumer
                              .postAdmissionProgramDetails(
                                  currentPageIndex, int.parse(applicationId!));
                          if (response.statusCode == 201) {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.easeIn);
                          } else {
                            ToastHelper().errorToast(response.body.toString());
                          }
                        } else {
                          ToastHelper()
                              .errorToast("Please Fill the Required Fields");
                        }
                      } else {
                        // Get the current page index
                        int currentPageIndex = pageController.page?.round() ?? 0;
                        var response = await admissionProgramConsumer
                            .postAdmissionProgramDetails(
                                currentPageIndex, int.parse(applicationId!));
                        if (response.statusCode == 201) {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.easeIn);
                        } else {
                          ToastHelper().errorToast(response.body.toString());
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
