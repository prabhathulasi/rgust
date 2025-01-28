import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_login_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_stand_test_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StandardizedTestForm extends StatelessWidget {
  final PageController pageController;
  const StandardizedTestForm({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var size = MediaQuery.sizeOf(context);
    return Consumer<AdmissionStandTestProvider>(
        builder: (context, admissionStandTestConsumer, child) {
      return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              children: [
                 Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(ImagePath.webrgustLogo,
                                width: size.width * 0.08),
                            SizedBox(
                              width: 15.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppRichTextView(
                                    title:
                                        "Rajiv Gandhi University of Science and Technology"
                                            .toUpperCase(),
                                    fontSize: size.width * 0.02,
                                    fontWeight: FontWeight.bold),
                                AppRichTextView(
                                  fontStyle: FontStyle.italic,
                                  title: "A Brand for Quality Eduation",
                                  fontSize: 20.sp,
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
                        title: "Standardized Tests",
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
                        value: 0.6,
                      ),
                    ),
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
                          title:
                              "Have you attempted any English Standardized Tests?",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Radio(
                      activeColor: AppColors.colorc7e,
                      value: "Yes",
                      groupValue: admissionStandTestConsumer.standTestRadioValue,
                      onChanged: (String? value) {
                        admissionStandTestConsumer.setTestRadioValue(value!);
                      },
                    ),
                    AppRichTextView(
                        title: "Yes", fontSize: 12.sp, fontWeight: FontWeight.bold),
                    Radio(
                      activeColor: AppColors.colorc7e,
                      value: "No",
                      groupValue: admissionStandTestConsumer.standTestRadioValue,
                      onChanged: (String? value) {
                        admissionStandTestConsumer.setTestRadioValue(value!);
                        // admissionConsumer.setEngProficiencySectionValue(true);
                      },
                    ),
                    AppRichTextView(
                        title: "No", fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ],
                ),
                admissionStandTestConsumer.standTestRadioValue == "No" ||
                        admissionStandTestConsumer.standTestRadioValue == null
                    ? Container()
                    : Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppRichTextView(
                                      title: "Exams ",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: AppColors.colorGrey),
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
                                          value: admissionStandTestConsumer
                                              .testDropdownvalue,
            
                                          // Down Arrow Icon
                                          icon:
                                              const Icon(Icons.keyboard_arrow_down),
            
                                          // Array list of items
                                          items: admissionStandTestConsumer
                                              .testItems
                                              .map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) {
                                            admissionStandTestConsumer
                                                .setTestDropDownValue(newValue!);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Location Detail",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    AppTextFormFieldWidget(
                                      validator: (p0) => p0 == null || p0.isEmpty
                                          ? "This field is required"
                                          : null,
                                      onSaved: (p0) =>
                                          admissionStandTestConsumer.location = p0,
                                      obscureText: false,
                                      inputDecoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.colorc7e,
                                                  width: 2.w)),
                                          prefixIcon: const Icon(
                                              Icons.location_on_outlined),
                                          hintText: "Location",
                                          hintStyle: GoogleFonts.roboto(
                                              fontSize: 12.sp,
                                              color: AppColors.colorGrey)),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Exam Date",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "This Date is Required";
                                        } else {
                                          return null;
                                        }
                                      },
                                      style: GoogleFonts.roboto(
                                          color: AppColors.colorBlack,
                                          fontSize: 13.sp),
                                      controller:
                                          admissionStandTestConsumer.examDate,
                                      decoration: InputDecoration(
                                          prefixIcon:
                                              const Icon(Icons.calendar_month),
                                          hintText: "Exam Date",
                                          hintStyle: GoogleFonts.roboto(
                                              color: AppColors.colorGrey),
                                          border: const OutlineInputBorder()),
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(
                                                1900), //- not to allow to choose before today.
                                            lastDate: DateTime.now());
            
                                        if (pickedDate != null) {
                                          //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          admissionStandTestConsumer
                                              .setExamDate(formattedDate);
                                        } else {
                                          print("Date is not selected");
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Total Number of Attempts",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    AppTextFormFieldWidget(
                                      onSaved: (p0) => admissionStandTestConsumer
                                          .totalAttempts = p0,
                                      validator: (p0) => p0 == null || p0.isEmpty
                                          ? "This field is required"
                                          : null,
                                      obscureText: false,
                                      inputDecoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.colorc7e,
                                                  width: 2.w)),
                                          hintText: "Attempts",
                                          hintStyle: GoogleFonts.roboto(
                                              fontSize: 12.sp,
                                              color: AppColors.colorGrey)),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Highest Score",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    AppTextFormFieldWidget(
                                      onSaved: (p0) =>
                                          admissionStandTestConsumer.score = p0,
                                      validator: (p0) => p0 == null || p0.isEmpty
                                          ? "This field is required"
                                          : null,
                                      obscureText: false,
                                      inputDecoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.colorc7e,
                                                  width: 2.w)),
                                          hintText: "Score",
                                          hintStyle: GoogleFonts.roboto(
                                              fontSize: 12.sp,
                                              color: AppColors.colorGrey)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                SizedBox(
                  height: 10.h,
                ),
                admissionStandTestConsumer.standTestRadioValue != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // AppElevatedButon(
                          //   borderColor: AppColors.colorc7e,
                          //   title: "Back",
                          //   buttonColor: AppColors.colorWhite,
                          //   onPressed: (context) {
                          //     pageController.previousPage(
                          //         duration: const Duration(milliseconds: 1000),
                          //         curve: Curves.easeOut);
                          //   },
                          //   textColor: AppColors.colorc7e,
                          //   height: 50.h,
                          //   width: 120.w,
                          // ),
                          Consumer<AdmissionLoginProvider>(
                            builder: (context, admissionLoginConsumer, child) {
                              return AppElevatedButon(
                                title: "Save & Continue",
                                buttonColor: AppColors.colorc7e,
                                onPressed: (context) async {
                                     var applicationId =
                                          admissionLoginConsumer.applicationId;
                                  if (admissionStandTestConsumer.standTestRadioValue ==
                                      "Yes") {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      var response = await admissionStandTestConsumer
                                          .postAdmissionStandTestDetails(int.parse(applicationId!));
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
                                  } else {
                                    var response = await admissionStandTestConsumer
                                        .postAdmissionStandTestDetails(int.parse(applicationId!));
                                    if (response.statusCode == 201) {
                                      pageController.nextPage(
                                          duration: const Duration(milliseconds: 1000),
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
                            }
                          ),
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ),
      );
    });
  }
}
