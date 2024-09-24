import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/admission/admission_education_history_model.dart';
import 'package:rugst_alliance_academia/data/model/admission/admission_job_form.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class JobDetailsForm extends StatelessWidget {
  const JobDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController commencedInput = TextEditingController();
    TextEditingController completedInput = TextEditingController();
    return Consumer<AdmissionProvider>(
        builder: (context, admissionConsumer, child) {
      return Column(
        children: [
          admissionConsumer.jobList.isEmpty
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: admissionConsumer.jobList.length,
                  itemBuilder: (context, index) {
                    // Parse the date
                    DateTime completeddateTime = DateFormat('dd/MM/yyyy')
                        .parse(admissionConsumer.jobList[index].from!);
                    String completedmonthYear =
                        DateFormat('MMMM yyyy').format(completeddateTime);
                    // Parse the date
                    DateTime commenceddateTime = DateFormat('dd/MM/yyyy')
                        .parse(admissionConsumer.jobList[index].till!);
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
                                IconPath.workIcon,
                                width: 20.w,
                              ),
                              SizedBox(
                                width: 25.w,
                              ),
                              AppRichTextView(
                                  title: admissionConsumer.jobList[index].role!,
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
                                    title: admissionConsumer
                                        .jobList[index].organization!,
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
          admissionConsumer.isNewJob == false
              ? Container()
              : Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      admissionConsumer.setNewJob(false);
                    },
                    child: AppRichTextView(
                        title: "\u002b Add New Experience",
                        textColor: AppColors.colorc7e,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
          admissionConsumer.isNewJob == true
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
                                  title: "Employer Name",
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppRichTextView(
                                  title: "Role",
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
                                    color: AppColors.colorWhite,
                                    fontSize: 13.sp),
                                controller: commencedInput,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Icons.calendar_month),
                                    hintText: "Commenced Date",
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
                                    color: AppColors.colorWhite,
                                    fontSize: 13.sp),
                                controller: completedInput,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Icons.calendar_month),
                                    hintText: "Completed Date",
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
                    SizedBox(height: 15.h,),
                    Row(
                      children: [
                        Radio(
                          activeColor: AppColors.colorc7e,
                          value: "Full Time",
                          groupValue: admissionConsumer.jobTypeRadioValue,
                          onChanged: (String? value) {
                            admissionConsumer.setJobTypeRadioValue(value!);
                          },
                        ),
                        AppRichTextView(
                            title: "Full Time",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                        Radio(
                          activeColor: AppColors.colorc7e,
                          value: "Part Time",
                          groupValue: admissionConsumer.jobTypeRadioValue,
                          onChanged: (String? value) {
                            admissionConsumer.setJobTypeRadioValue(value!);
                          },
                        ),
                        AppRichTextView(
                            title: "Part Time",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                      ],
                    )
                  ],
                ),
          SizedBox(
            height: 15.h,
          ),
          admissionConsumer.isNewJob == false
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: AppElevatedButon(
                    title: "Save",
                    buttonColor: AppColors.colorc7e,
                    onPressed: (context) async {
                      admissionConsumer.storeJobDetails(
                        ExperienceModel(
                          employmentType: "Full Time",
                          organization: "XYZ Company",
                          from: "12/02/2018",
                          till: "06/08/2020",
                          role: "Tester"
                        )
                      );
                    },
                    textColor: AppColors.colorWhite,
                    height: 50.h,
                    width: 100.w,
                  ),
                )
              : Align(
                  alignment: Alignment.bottomRight,
                  child: AppElevatedButon(
                    title: "Save & Continue",
                    buttonColor: AppColors.colorc7e,
                    onPressed: (context) async {
                      admissionConsumer.setjobSectionValue(true);
                    },
                    textColor: AppColors.colorWhite,
                    height: 50.h,
                    width: 200.w,
                  ),
                )
        ],
      );
    });
  }
}
