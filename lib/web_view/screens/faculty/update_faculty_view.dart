import 'dart:convert';

import 'dart:typed_data';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/custom_plugin/editable.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/faculty_model.dart';
import 'package:rugst_alliance_academia/data/model/gender_model.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';

import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/batch_dropdown.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/class_dropdown.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/program_dropdown_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/year_dropdown_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/faculty/course_dropdown.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_radiobutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateFacultyView extends StatefulWidget {
  final FacultyList facultyDetail;
  const UpdateFacultyView({super.key, required this.facultyDetail});

  @override
  State<UpdateFacultyView> createState() => _AddFacultyViewState();
}

class _AddFacultyViewState extends State<UpdateFacultyView> {
  final _formKey = GlobalKey<FormState>();
  List<Gender> genders = [];
  List<JobType> jobType = [];
  List filterdcols = [];
  String? genderValue;
  String? jobTypeValue;
  String? selected_Course;

  final _editableKey = GlobalKey<EditableState>();
  @override
  void initState() {
    genders.add(Gender("Male", false));
    genders.add(Gender("Female", false));
    jobType.add(JobType("Full-Time", false));
    jobType.add(JobType("Part-Time", false));
    jobType.add(JobType("Resigned", false));

    filterdcols = [
      {
        "title": 'Course Code',
        'widthFactor': 0.2,
        'key': 'coursecode',
      },
      {"title": 'Course Name', 'widthFactor': 0.2, 'key': 'coursename'},
      {"title": 'Credits', 'widthFactor': 0.2, 'key': 'credits'},
      {
        "title": 'Assigned Lectures',
        'widthFactor': 0.2,
        'key': 'lectures',
        'editable': false
      },
    ];

    super.initState();
  }

  bool dropdownSelected = false;
  Uint8List? bytesFromPicker;
  String? imageEncoded;
  TextEditingController dateinput = TextEditingController();
  TextEditingController dobinput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final programProvider = Provider.of<ProgramProvider>(context);
    final facultyProvider = Provider.of<FacultyProvider>(context);

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), bottomLeft: Radius.circular(50))),
        child: Padding(
          padding: EdgeInsets.all(29.sp),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppRichTextView(
                      title: "Update Faculty",
                      textColor: AppColors.colorc7e,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppRichTextView(
                              title: "PROFILE IMAGE",
                              textColor: AppColors.colorc7e,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800),
                          SizedBox(
                            height: 10.h,
                          ),
                          CircleAvatar(
                            backgroundColor: AppColors.colorc7e,
                            radius: 60.sp,
                            backgroundImage: imageEncoded == null
                                ? MemoryImage(base64Decode(
                                    widget.facultyDetail.userImage!))
                                : MemoryImage(bytesFromPicker!)
                                    as ImageProvider,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          InkWell(
                            onTap: () async {
                              bytesFromPicker =
                                  await ImagePickerWeb.getImageAsBytes();
                              imageEncoded = base64.encode(bytesFromPicker!);

                              setState(() {});
                            },
                            child: AppRichTextView(
                                title: "Change Profile Image",
                                textColor: AppColors.color582,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppRichTextView(
                              title: "Program",
                              textColor: AppColors.colorBlack,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                          SizedBox(
                            height: 10.h,
                          ),
                          Consumer<ProgramProvider>(
                              builder: (context, programProvider, child) {
                            dropdownSelected == false
                                ? programProvider.selectedDept =
                                    widget.facultyDetail.programId.toString()
                                : programProvider.selectedDept = null;

                            return const ProgramDropdown();
                          }),
                          AppRichTextView(
                              title: "Class",
                              textColor: AppColors.colorBlack,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                          SizedBox(
                            height: 10.h,
                          ),
                          programProvider.selectedDept == null
                              ? Container(
                                  color: AppColors.colorc7e,
                                  height: 60.h,
                                  width: size.width * 0.2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0.w),
                                      child: AppRichTextView(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        title: "Please Select the Class",
                                        textColor: AppColors.colorWhite,
                                      ),
                                    ),
                                  ),
                                )
                              : Consumer<ProgramProvider>(
                                  builder: (context, programProvider, child) {
                                  return const ClassDropdown();
                                }),
                          AppRichTextView(
                              title: "Faculty Id",
                              textColor: AppColors.colorBlack,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            color: AppColors.colorc7e,
                            height: 60.h,
                            width: size.width * 0.2,
                            child: Padding(
                              padding: EdgeInsets.all(8.0.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AppTextFormFieldWidget(
                                      enable: false,
                                      textStyle: const TextStyle(
                                          color: AppColors.colorWhite),
                                      onSaved: (p0) {},
                                      inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                          //TODO ADD the exisiting employee id
                                          hintText: "",
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppRichTextView(
                              title: "Year",
                              textColor: AppColors.colorc7e,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                          SizedBox(
                            height: 10.h,
                          ),
                          programProvider.selectedClass == null
                              ? Container(
                                  color: AppColors.colorc7e,
                                  height: 60.h,
                                  width: size.width * 0.2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0.w),
                                      child: AppRichTextView(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        title: "Please Select the Year",
                                        textColor: AppColors.colorWhite,
                                      ),
                                    ),
                                  ),
                                )
                              : const DynamicYearsDropdown(),
                          AppRichTextView(
                              title: "Batch",
                              textColor: AppColors.colorc7e,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                          SizedBox(
                            height: 10.h,
                          ),
                          programProvider.selectedClass == null
                              ? Container(
                                  color: AppColors.colorc7e,
                                  height: 60.h,
                                  width: size.width * 0.2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0.w),
                                      child: AppRichTextView(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        title: "Please Select the Batch",
                                        textColor: AppColors.colorWhite,
                                      ),
                                    ),
                                  ),
                                )
                              : const BatchDropdown(),
                          AppRichTextView(
                              title: "Course",
                              textColor: AppColors.colorc7e,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                          SizedBox(
                            height: 10.h,
                          ),
                          const CourseDropDown()
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  AppRichTextView(
                      title: "Faculty Personal Details".toUpperCase(),
                      textColor: AppColors.colorBlack,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800),
                  SizedBox(
                    height: 20.h,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Form(
                      key: _formKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                color: AppColors.colorc7e,
                                height: 70.h,
                                width: size.width * 0.2,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "First Name",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This FirstName is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (p0) {
                                          facultyProvider.setfirstName(p0!);
                                        },
                                        inputDecoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: AppColors.colorGrey)),
                                        obscureText: false,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                color: AppColors.colorc7e,
                                height: 70.h,
                                width: size.width * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Last Name",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This LastName is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (p0) {
                                          facultyProvider.setLastName(p0!);
                                        },
                                        inputDecoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: AppColors.colorGrey)),
                                        obscureText: false,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                color: AppColors.colorc7e,
                                height: 70.h,
                                width: size.width * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Email Address",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite),
                                        validator: (value) {
                                          return EmailFormFieldValidator
                                              .validate(value);
                                        },
                                        onSaved: (p0) {
                                          facultyProvider.setemail(p0!);
                                        },
                                        inputDecoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: AppColors.colorGrey)),
                                        obscureText: false,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                color: AppColors.colorc7e,
                                height: 70.h,
                                width: size.width * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Mobile Number",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This MobileNumber is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (p0) {
                                          facultyProvider.setMobile(p0!);
                                        },
                                        inputDecoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: AppColors.colorGrey)),
                                        obscureText: false,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                color: AppColors.colorc7e,
                                height: 70.h,
                                width: size.width * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "DOB",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This DOB is Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          style: GoogleFonts.roboto(
                                              color: AppColors.colorWhite),
                                          controller: dobinput,
                                          decoration: InputDecoration(
                                              hintStyle: GoogleFonts.roboto(
                                                  color: AppColors.colorWhite),
                                              border: InputBorder.none),
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(
                                                        1900), //- not to allow to choose before today.
                                                    lastDate: DateTime(2101));

                                            if (pickedDate != null) {
                                              //pickedDate output format => 2021-03-10 00:00:00.000
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              //formatted date output using intl package =>  2021-03-16

                                              setState(() {
                                                dobinput.text =
                                                    formattedDate; //set output date to TextField value.
                                              });
                                            } else {
                                              print("Date is not selected");
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                color: AppColors.colorc7e,
                                height: 70.h,
                                width: size.width * 0.2,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Starts On",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This StartOn is Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          style: GoogleFonts.roboto(
                                              color: AppColors.colorWhite),
                                          controller: dateinput,
                                          decoration: InputDecoration(
                                              hintStyle: GoogleFonts.roboto(
                                                  color: AppColors.colorWhite),
                                              border: InputBorder.none),
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime
                                                        .now(), //- not to allow to choose before today.
                                                    lastDate: DateTime(2101));

                                            if (pickedDate != null) {
                                              //pickedDate output format => 2021-03-10 00:00:00.000
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              //formatted date output using intl package =>  2021-03-16

                                              setState(() {
                                                dateinput.text =
                                                    formattedDate; //set output date to TextField value.
                                              });
                                            } else {
                                              print("Date is not selected");
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            children: [
                              Container(
                                color: AppColors.colorc7e,
                                height: 70.h,
                                width: size.width * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Gender",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: genders.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  for (var gender in genders) {
                                                    gender.isSelected = false;
                                                  }
                                                  genders[index].isSelected =
                                                      true;
                                                  genderValue =
                                                      genders[index].name;
                                                });
                                              },
                                              child: AppRadioButton(
                                                gender: genders[index],
                                              ),
                                            ),
                                          );
                                        },
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                color: AppColors.colorc7e,
                                height: 70.h,
                                width: size.width * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Address",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This Address is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (p0) {
                                          facultyProvider.setaddrss(p0!);
                                        },
                                        inputDecoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: AppColors.colorGrey)),
                                        obscureText: false,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                color: AppColors.colorc7e,
                                height: 70.h,
                                width: size.width * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Education qualification",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This Qualification is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (p0) {
                                          facultyProvider.setqualification(p0!);
                                        },
                                        inputDecoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: AppColors.colorGrey)),
                                        obscureText: false,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                color: AppColors.colorc7e,
                                height: 70.h,
                                width: size.width * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Passport Number",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This PassportNumber is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (p0) {
                                          facultyProvider.setpassport(p0!);
                                        },
                                        inputDecoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: AppColors.colorGrey)),
                                        obscureText: false,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                color: AppColors.colorc7e,
                                height: 70.h,
                                width: size.width * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Job-Type",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: jobType.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  for (var data in jobType) {
                                                    data.isSelected = false;
                                                  }
                                                  jobType[index].isSelected =
                                                      true;
                                                  jobTypeValue =
                                                      jobType[index].name;
                                                });
                                              },
                                              child: AppRadioButton(
                                                jobType: jobType[index],
                                              ),
                                            ),
                                          );
                                        },
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                color: AppColors.colorc7e,
                                height: 70.h,
                                width: size.width * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Citizenship",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This Citizenship is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (p0) {
                                          facultyProvider.setcitizen(p0!);
                                        },
                                        inputDecoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: AppColors.colorGrey)),
                                        obscureText: false,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppElevatedButon(
                            title: "Save",
                            buttonColor: AppColors.colorc7e,
                            textColor: AppColors.colorWhite,
                            height: 50.h,
                            width: 150.w,
                            loading: facultyProvider.isLoading,
                            onPressed: (context) async {
                              if (imageEncoded == null) {
                                Fluttertoast.showToast(
                                    msg: "Please Select the User Image");
                              } else if (genderValue == null) {
                                Fluttertoast.showToast(
                                    msg: "Please Select the Gender");
                              } else if (jobTypeValue == null) {
                                Fluttertoast.showToast(
                                    msg: "Please Select the job type");
                              } else if (programProvider.selectedDept == null) {
                                Fluttertoast.showToast(
                                    msg: "Please Select the Program");
                              } else if (programProvider.selectedClass ==
                                  null) {
                                Fluttertoast.showToast(
                                    msg: "Please Select the Class");
                              } else if (programProvider.selectedBatch ==
                                  null) {
                                Fluttertoast.showToast(
                                    msg: "Please Select the Batch");
                              } else if (programProvider.selectedCourse ==
                                  null) {
                                Fluttertoast.showToast(
                                    msg: "Please Select the Course");
                              } else {
                                var token = await getTokenAndUseIt();
                                if (token == null) {
                                  if (context.mounted) {
                                    Navigator.pushNamed(
                                        context, RouteNames.login);
                                  }
                                } else if (token == "Token Expired") {
                                  ToastHelper().errorToast(
                                      "Session Expired Please Login Again");

                                  if (context.mounted) {
                                    Navigator.pushNamed(
                                        context, RouteNames.login);
                                  }
                                } else {
                                  var data =
                                      programProvider.newData.where((element) {
                                    return element["coursecode"] ==
                                        programProvider.selectedCourse!;
                                  }).toList();
                                  setState(() {
                                    selected_Course = data[0]["coursename"];
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    var result = await facultyProvider.addFaculty(
                                        token,
                                        programId: int.parse(
                                            programProvider.selectedDept!),
                                        classId: int.parse(
                                            programProvider.selectedClass!),
                                        courseCode:
                                            programProvider.selectedCourse!,
                                        courseName: selected_Course!,
                                        batch: programProvider.selectedBatch!,
                                        facultyId: "",
                                        // "${DateTime.now().year}/${programProvider.selectedDept}/$randomString",
                                        gender: genderValue!,
                                        dob: dobinput.text,
                                        joiningDate: dateinput.text,
                                        userImage: imageEncoded!,
                                        jobType: jobTypeValue!);
                                    dev.log(result.toString());
                                  }
                                }
                              }
                            }),
                        SizedBox(
                          width: 10.h,
                        ),
                        AppElevatedButon(
                          title: "Cancel",
                          buttonColor: AppColors.colorc7e,
                          textColor: AppColors.colorWhite,
                          height: 50.h,
                          width: 120.w,
                          onPressed: (context) {},
                        )
                      ],
                    ),
                  )
                ],
              ),
              const VerticalDivider(),
              Expanded(
                child: programProvider.newData.isEmpty
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppRichTextView(
                              title: "Registered Course",
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w500),
                          SizedBox(
                            width: 10.w,
                          ),

                          Builder(builder: (context) {
                            return Expanded(
                              child: Consumer<ProgramProvider>(builder:
                                  (context, departmentProvider, child) {
                                return Editable(
                                  key: _editableKey,
                                  showRemoveIcon: false,
                                  columns: filterdcols,
                                  rows: departmentProvider.newData,
                                  zebraStripe: true,
                                  stripeColor1: AppColors.colorc7e,
                                  stripeColor2: AppColors.colorc7e,
                                  onRowSaved: (value) async {},
                                  onSubmitted: (value) {
                                    print(value);
                                  },

                                  borderColor: Colors.blueGrey,
                                  tdStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.colorWhite),
                                  trHeight: 40,
                                  thStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.colorWhite),
                                  thAlignment: TextAlign.center,
                                  thVertAlignment: CrossAxisAlignment.end,
                                  thPaddingBottom: 3,
                                  showSaveIcon: false,
                                  saveIconColor: Colors.black,
                                  showCreateButton: false,
                                  tdAlignment: TextAlign.left,
                                  tdEditableMaxLines:
                                      100, // don't limit and allow data to wrap
                                  tdPaddingTop: 0,
                                  tdPaddingBottom: 14,
                                  tdPaddingLeft: 10,
                                  tdPaddingRight: 8,
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0))),
                                );
                              }),
                            );
                          }),

                          // const Expanded(child: DepartmentTabView())
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}