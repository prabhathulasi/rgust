import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/admission/admission_education_history_model.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_education_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_login_provider.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EducationDetailsForm extends StatelessWidget {
  final PageController pageController;
  const EducationDetailsForm({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var size = MediaQuery.sizeOf(context);

    return Consumer<AdmissionEducationProvider>(
        builder: (context, admissionConsumer, child) {
      return SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
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
                        title: "Education History",
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
                        value: 0.3,
                      ),
                    ),
                  ],
                ),
                admissionConsumer.educationList.isEmpty
                    ? Container()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: admissionConsumer.educationList.length,
                        itemBuilder: (context, index) {
                          // Parse the date
                          DateTime completeddateTime = DateFormat('yyyy-MM-dd')
                              .parse(admissionConsumer
                                  .educationList[index].dateCompleted!);
                          String completedmonthYear =
                              DateFormat('MMMM yyyy').format(completeddateTime);
                          // Parse the date
                          DateTime commenceddateTime = DateFormat('yyyy-MM-dd')
                              .parse(admissionConsumer
                                  .educationList[index].dateCommenced!);
                          String commencedmonthYear =
                              DateFormat('MMMM yyyy').format(commenceddateTime);
                          return Padding(
                            padding: EdgeInsets.all(10.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 25.h,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      IconPath.educationIcon,
                                      width: 20.w,
                                    ),
                                    SizedBox(
                                      width: 25.w,
                                    ),
                                    AppRichTextView(
                                        title: admissionConsumer
                                            .educationList[index].course!,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  const Text("Delete Confirmation"),
                                              content: const Text(
                                                  "Are you sure you want to delete this item?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    // Dismiss the dialog
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    admissionConsumer
                                                        .removeEducationDetails(
                                                            index);
                                                    // Dismiss the dialog
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Delete"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: AppColors.colorRed,
                                      ),
                                    )
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
                                          title: admissionConsumer
                                              .educationList[index]
                                              .institution!,
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
                SizedBox(
                  height: 20.h,
                ),
                admissionConsumer.isNewEdu == false
                    ? Container()
                    : Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            admissionConsumer.setNewEdu(false);
                          },
                          child: AppRichTextView(
                              title: "\u002b Add New Education",
                              textColor: AppColors.colorc7e,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                admissionConsumer.isNewEdu == true
                    ? Container()
                    : Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Course Name",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    AppTextFormFieldWidget(
                                      onSaved: (p0) =>
                                          admissionConsumer.courseName = p0,
                                      validator: (p0) => p0!.isEmpty
                                          ? "This Course Name is Required"
                                          : null,
                                      obscureText: false,
                                      inputDecoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.colorc7e,
                                                  width: 2.w)),
                                          hintText: "Course Name",
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
                                        title: "Institution Name",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    AppTextFormFieldWidget(
                                      onSaved: (p0) => admissionConsumer
                                          .institutionName = p0,
                                      validator: (p0) => p0!.isEmpty
                                          ? "This Institution Name is Required"
                                          : null,
                                      obscureText: false,
                                      inputDecoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.colorc7e,
                                                  width: 2.w)),
                                          hintText: "Enter Institution Name",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        if (value == null || value.isEmpty) {
                                          return "This Commenced Date is Required";
                                        } else {
                                          return null;
                                        }
                                      },
                                      style: GoogleFonts.roboto(
                                          color: AppColors.colorBlack,
                                          fontSize: 13.sp),
                                      controller:
                                          admissionConsumer.commencedInput,
                                      decoration: InputDecoration(
                                          prefixIcon:
                                              const Icon(Icons.calendar_month),
                                          hintText: "Commenced Date",
                                          hintStyle: GoogleFonts.roboto(
                                              color: AppColors.colorGrey),
                                          border: const OutlineInputBorder()),
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
                                          admissionConsumer
                                              .setStartDate(formattedDate);
                                          //formatted date output using intl package =>  2021-03-16

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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        if (value == null || value.isEmpty) {
                                          return "This Completed Date is Required";
                                        } else {
                                          return null;
                                        }
                                      },
                                      style: GoogleFonts.roboto(
                                          color: AppColors.colorBlack,
                                          fontSize: 13.sp),
                                      controller:
                                          admissionConsumer.completedInput,
                                      decoration: InputDecoration(
                                          prefixIcon:
                                              const Icon(Icons.calendar_month),
                                          hintText: "Completed Date",
                                          hintStyle: GoogleFonts.roboto(
                                              color: AppColors.colorGrey),
                                          border: const OutlineInputBorder()),
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
                                          admissionConsumer
                                              .setEndDate(formattedDate);
                                          //formatted date output using intl package =>  2021-03-16

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
                            height: 15.sp,
                          ),
                          admissionConsumer.selectedFileName == null
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
                                                admissionConsumer.addFile(
                                                    file.name,
                                                    base64Encode(file.bytes!));
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
                                              title:
                                                  "Please Attach Supporting Documents of your  Education",
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
                                    title: Text(
                                        admissionConsumer.selectedFileName!),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: AppColors.colorRed,
                                      ),
                                      onPressed: () {
                                        admissionConsumer.clearFile();
                                      },
                                    ),
                                  ),
                                ),
                        ],
                      ),
                SizedBox(
                  height: 15.h,
                ),
                admissionConsumer.isNewEdu == false
                    ? Row(
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
                            title: "Save",
                            buttonColor: AppColors.colorc7e,
                            onPressed: (context) async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                if (admissionConsumer.selectedFileBytes ==
                                    null) {
                                  ToastHelper().errorToast(
                                      "Supporting Document Required");
                                } else {
                                  admissionConsumer.storeEducationDetails(
                                      EducationModel(
                                          course: admissionConsumer.courseName,
                                          selectedFileName: admissionConsumer
                                              .selectedFileBytes,
                                          dateCommenced:
                                              admissionConsumer.startDate,
                                          dateCompleted:
                                              admissionConsumer.endDate,
                                          institution: admissionConsumer
                                              .institutionName));

                                  admissionConsumer.clearStartendDate();
                                }
                              }
                            },
                            textColor: AppColors.colorWhite,
                            height: 50.h,
                            width: 100.w,
                          ),
                        ],
                      )
                    : Row(
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
                                  var response = await admissionConsumer
                                      .postAdmissionEducationDetails(int.parse(applicationId!));
                                  if (response.statusCode == 201) {
                                    pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 1000),
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
                            }
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      );
    });
  }
}
