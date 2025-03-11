import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:rugst_alliance_academia/data/model/admission/admission_job_form_model.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_job_provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_login_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class MobileApplicationJobDetail extends StatelessWidget {
  final PageController pageController;
  const MobileApplicationJobDetail({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var size = MediaQuery.sizeOf(context);

    return Consumer<AdmissionJobProvider>(
        builder: (context, admissionJobConsumer, child) {
      return Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ImagePath.webrgustLogo, width: 80.h),
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
                        title: "Job Experience",
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
                        value: 0.4,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AppRichTextView(
                          title: "Do you have any Previous Work Experience?",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                   AppRichTextView(
                      textColor: AppColors.colorRed,
                      title: "*",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      activeColor: AppColors.colorc7e,
                      value: "Yes",
                      groupValue: admissionJobConsumer.jobRadioValue,
                      onChanged: (String? value) {
                        admissionJobConsumer.setJobRadioValue(value!);
                        admissionJobConsumer.setNewJob(false);
                      },
                    ),
                    AppRichTextView(
                        title: "Yes",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                    Radio(
                      activeColor: AppColors.colorc7e,
                      value: "No",
                      groupValue: admissionJobConsumer.jobRadioValue,
                      onChanged: (String? value) {
                        admissionJobConsumer.setJobRadioValue(value!);
                        admissionJobConsumer.setNewJob(false);
                      },
                    ),
                    AppRichTextView(
                        title: "No",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                SizedBox(
                  width: 20.w,
                ),
                admissionJobConsumer.jobList.isEmpty
                    ? Container()
                    : Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: admissionJobConsumer.jobList.length,
                              itemBuilder: (context, index) {
                                // Parse the date
                                DateTime completeddateTime =
                                    DateFormat('yyyy-MM-dd').parse(
                                        admissionJobConsumer
                                            .jobList[index].from!);
                                String completedmonthYear =
                                    DateFormat('MMMM yyyy')
                                        .format(completeddateTime);
                                // Parse the date
                                DateTime commenceddateTime =
                                    DateFormat('yyyy-MM-dd').parse(
                                        admissionJobConsumer
                                            .jobList[index].till!);
                                String commencedmonthYear =
                                    DateFormat('MMMM yyyy')
                                        .format(commenceddateTime);
                                return Padding(
                                  padding: EdgeInsets.all(10.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            IconPath.workIcon,
                                            width: 20.w,
                                          ),
                                          SizedBox(
                                            width: 25.w,
                                          ),
                                          AppRichTextView(
                                              title: admissionJobConsumer
                                                  .jobList[index].role!,
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.bold),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 50.0.w),
                                        child: Row(
                                          children: [
                                            AppRichTextView(
                                                title: admissionJobConsumer
                                                    .jobList[index]
                                                    .organization!,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400),
                                            SizedBox(width: 20.w),
                                            AppRichTextView(
                                                title:
                                                    "$commencedmonthYear - $completedmonthYear",
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                admissionJobConsumer.setNewJob(false);
                              },
                              child: AppRichTextView(
                                  title: "\u002b Add New Experience",
                                  textColor: AppColors.colorc7e,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: 20.h,
                ),
                admissionJobConsumer.isNewJob == true
                    ? Container()
                    : admissionJobConsumer.jobRadioValue == "No" ||
                            admissionJobConsumer.jobRadioValue == null
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppRichTextView(
                                            title: "Employer Name",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        AppTextFormFieldWidget(
                                          onSaved: (p0) => admissionJobConsumer
                                              .employerName = p0,
                                          validator: (p0) => p0!.isEmpty
                                              ? "This Employer Name is Required"
                                              : null,
                                          obscureText: false,
                                          inputDecoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors.colorc7e,
                                                      width: 2.w)),
                                              hintText: "Employer Name",
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppRichTextView(
                                            title: "Role",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        AppTextFormFieldWidget(
                                          onSaved: (p0) =>
                                              admissionJobConsumer.role = p0,
                                          validator: (p0) => p0!.isEmpty
                                              ? "This Role is Required"
                                              : null,
                                          obscureText: false,
                                          inputDecoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors.colorc7e,
                                                      width: 2.w)),
                                              hintText: "Role",
                                              hintStyle: GoogleFonts.roboto(
                                                  fontSize: 12.sp,
                                                  color: AppColors.colorGrey)),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppRichTextView(
                                            title: "Commenced Date",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This Commenced Date is Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          style: GoogleFonts.roboto(
                                              color: AppColors.colorBlack,
                                              fontSize: 13.sp),
                                          controller: admissionJobConsumer
                                              .commencedInput,
                                          decoration: InputDecoration(
                                              prefixIcon: const Icon(
                                                  Icons.calendar_month),
                                              hintText: "Commenced Date",
                                              hintStyle: GoogleFonts.roboto(
                                                  color: AppColors.colorGrey),
                                              border:
                                                  const OutlineInputBorder()),
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
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
                                              //formatted date output using intl package =>  2021-03-16
                                              admissionJobConsumer
                                                  .setStartDate(formattedDate);
                                              // setState(() {
                                              //   dobinput.text =
                                              //       formattedDate; //set output date to TextField value.
                                              // });
                                            } else {
                                              print("Date is not selected");
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppRichTextView(
                                            title: "Completed Date",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This Completed Date is Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          style: GoogleFonts.roboto(
                                              color: AppColors.colorBlack,
                                              fontSize: 13.sp),
                                          controller: admissionJobConsumer
                                              .completedInput,
                                          decoration: InputDecoration(
                                              prefixIcon: const Icon(
                                                  Icons.calendar_month),
                                              hintText: "Completed Date",
                                              hintStyle: GoogleFonts.roboto(
                                                  color: AppColors.colorGrey),
                                              border:
                                                  const OutlineInputBorder()),
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
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
                                              //formatted date output using intl package =>  2021-03-16
                                              admissionJobConsumer
                                                  .setEndDate(formattedDate);

                                              // setState(() {
                                              //   dobinput.text =
                                              //       formattedDate; //set output date to TextField value.
                                              // });
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
                                height: 15.h,
                              ),
                              AppRichTextView(
                                  title: "Job Type",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: AppColors.colorc7e,
                                    value: "Full Time",
                                    groupValue:
                                        admissionJobConsumer.jobTypeRadioValue,
                                    onChanged: (String? value) {
                                      admissionJobConsumer
                                          .setJobTypeRadioValue(value!);
                                    },
                                  ),
                                  AppRichTextView(
                                      title: "Full Time",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),
                                  Radio(
                                    activeColor: AppColors.colorc7e,
                                    value: "Part Time",
                                    groupValue:
                                        admissionJobConsumer.jobTypeRadioValue,
                                    onChanged: (String? value) {
                                      admissionJobConsumer
                                          .setJobTypeRadioValue(value!);
                                    },
                                  ),
                                  AppRichTextView(
                                      title: "Part Time",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),
                                ],
                              ),
                              SizedBox(
                                height: 15.sp,
                              ),
                              admissionJobConsumer.selectedFileName == null
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
                                                    admissionJobConsumer
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
                                                      "Please Attach Supporting Documents of your Work Experience",
                                                  textColor:
                                                      AppColors.colorBlack,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ],
                                            ),
                                          )),
                                    )
                                  : Card(
                                      child: ListTile(
                                        title: Text(admissionJobConsumer
                                            .selectedFileName!),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: AppColors.colorRed,
                                          ),
                                          onPressed: () {
                                            admissionJobConsumer.clearFile();
                                          },
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                SizedBox(
                  height: 15.h,
                ),
                admissionJobConsumer.jobRadioValue == null
                    ? Container()
                    : admissionJobConsumer.isNewJob == false &&
                            admissionJobConsumer.jobRadioValue == "Yes"
                        ? Align(
                          alignment: Alignment.bottomRight,
                          child: AppElevatedButon(
                            title: "Save",
                            buttonColor: AppColors.colorc7e,
                            onPressed: (context) async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                if (admissionJobConsumer
                                        .jobTypeRadioValue ==
                                    null) {
                                  ToastHelper()
                                      .errorToast("Please select job type");
                                } else if (admissionJobConsumer
                                        .selectedFileName ==
                                    null) {
                                  ToastHelper().errorToast(
                                      "Please attach supporting documents");
                                } else {
                                  admissionJobConsumer.storeJobDetails(
                                      ExperienceModel(
                                          employmentType:
                                              admissionJobConsumer
                                                  .jobTypeRadioValue,
                                          organization: admissionJobConsumer
                                              .employerName,
                                          from: admissionJobConsumer
                                              .startDate,
                                          till:
                                              admissionJobConsumer.endDate,
                                          role: admissionJobConsumer.role,
                                          document: admissionJobConsumer
                                              .selectedFileBytes));
                                  admissionJobConsumer.clearStartendDate();
                                }
                              }
                            },
                            textColor: AppColors.colorWhite,
                            height: 50.h,
                            width: 100.w,
                          ),
                        )
                        : Center(
                          child: Consumer<AdmissionLoginProvider>(builder:
                              (context, admissionLoginConsumer, child) {
                            return AppElevatedButon(
                              title: "Save & Continue",
                              buttonColor: AppColors.colorc7e,
                              onPressed: (context) async {
                                var applicationId =
                                    admissionLoginConsumer.applicationId;
                                var response = await admissionJobConsumer
                                    .postAdmissionJobDetails(
                                        int.parse(applicationId!));
                                if (response.statusCode == 201) {
                                  pageController.nextPage(
                                      duration: const Duration(
                                          milliseconds: 1000),
                                      curve: Curves.easeIn);
                                } else {
                                  ToastHelper()
                                      .errorToast(response.body.toString());
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
        ),
      );
    });
  }
}
