import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/custom_plugin/editable.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/gender_model.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
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

class AddFacultyView extends StatefulWidget {
  const AddFacultyView({super.key});

  @override
  State<AddFacultyView> createState() => _AddFacultyViewState();
}

class _AddFacultyViewState extends State<AddFacultyView> {
  final _formKey = GlobalKey<FormState>();
  List<Gender> genders = [];
  List<JobType> jobType = [];
  List filterdcols = [];
  String? genderValue;
  String? jobTypeValue;
  String? selected_Course;
  String? randomString;
  final _editableKey = GlobalKey<EditableState>();
  @override
  void initState() {
    genders.add(Gender("Male", false));
    genders.add(Gender("Female", false));
    jobType.add(JobType("Full-Time", false));
    jobType.add(JobType("Part-Time", false));

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
    setState(() {
      randomString = generateRandomString(4);
    });
    super.initState();
  }

  String generateRandomString(int length) {
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    String result = '';

    for (int i = 0; i < length; i++) {
      int randomIndex = random.nextInt(chars.length);
      result += chars[randomIndex];
    }

    return result;
  }

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
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRichTextView(
                        title: "Add New Faculty",
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
                            Consumer<FacultyProvider>(
                                builder: (context, facultyConsumer, child) {
                              return facultyConsumer.selectedIndex == -1
                                  ? CircleAvatar(
                                      backgroundColor: AppColors.colorc7e,
                                      radius: 60.sp,
                                      backgroundImage: imageEncoded == null
                                          ? const AssetImage(
                                              ImagePath.webfacultyfLogo)
                                          : MemoryImage(bytesFromPicker!)
                                              as ImageProvider)
                                  : CircleAvatar(
                                      backgroundColor: AppColors.colorc7e,
                                      radius: 60.sp,
                                      backgroundImage: MemoryImage(base64Decode(
                                          facultyConsumer
                                              .facultyModel
                                              .facultyList![
                                                  facultyProvider.selectedIndex]
                                              .userImage!)),
                                    );
                            }),
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
                                : const ClassDropdown(),
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
                                        inputDecoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: programProvider
                                                        .selectedDept ==
                                                    null
                                                ? ""
                                                : "${DateTime.now().year}/${programProvider.selectedDept}/$randomString",
                                            hintStyle: const TextStyle(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          activeColor: AppColors.colorc7e,
                          value: false,
                          groupValue: facultyProvider.isNewUser,
                          onChanged: (value) {
                            facultyProvider.selectUserType(value!);
                          },
                        ),
                        AppRichTextView(
                            title: "New User",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                        Radio(
                          activeColor: AppColors.colorc7e,
                          value: true,
                          groupValue: facultyProvider.isNewUser,
                          onChanged: (value) {
                            facultyProvider.selectUserType(value!);
                          },
                        ),
                        AppRichTextView(
                            title: "Existing User",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                    facultyProvider.isNewUser == false
                        ? Form(
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
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(
                                                        RegExp(r'[a-zA-Z\s]'))
                                              ],
                                              textStyle: GoogleFonts.roboto(
                                                  color: AppColors.colorWhite,
                                                  fontSize: 15.sp),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "This FirstName is Required";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onSaved: (p0) {
                                                facultyProvider
                                                    .setfirstName(p0!);
                                              },
                                              inputDecoration:
                                                  const InputDecoration(
                                                      border: InputBorder.none,
                                                      hintStyle: TextStyle(
                                                          color: AppColors
                                                              .colorGrey)),
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
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(
                                                        RegExp(r'[a-zA-Z\s]'))
                                              ],
                                              textStyle: GoogleFonts.roboto(
                                                  color: AppColors.colorWhite,
                                                  fontSize: 15.sp),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "This LastName is Required";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onSaved: (p0) {
                                                facultyProvider
                                                    .setLastName(p0!);
                                              },
                                              inputDecoration:
                                                  const InputDecoration(
                                                      border: InputBorder.none,
                                                      hintStyle: TextStyle(
                                                          color: AppColors
                                                              .colorGrey)),
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
                                                  color: AppColors.colorWhite,
                                                  fontSize: 15.sp),
                                              validator: (value) {
                                                return EmailFormFieldValidator
                                                    .validate(value);
                                              },
                                              onSaved: (p0) {
                                                facultyProvider.setemail(p0!);
                                              },
                                              inputDecoration:
                                                  const InputDecoration(
                                                      border: InputBorder.none,
                                                      hintStyle: TextStyle(
                                                          color: AppColors
                                                              .colorGrey)),
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
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              textStyle: GoogleFonts.roboto(
                                                  color: AppColors.colorWhite,
                                                  fontSize: 15.sp),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "This MobileNumber is Required";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              onSaved: (p0) {
                                                facultyProvider.setMobile(p0!);
                                              },
                                              inputDecoration:
                                                  const InputDecoration(
                                                      border: InputBorder.none,
                                                      hintStyle: TextStyle(
                                                          color: AppColors
                                                              .colorGrey)),
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
                                                    color: AppColors.colorWhite,
                                                    fontSize: 15.sp),
                                                controller: dobinput,
                                                decoration: InputDecoration(
                                                    hintStyle:
                                                        GoogleFonts.roboto(
                                                            color: AppColors
                                                                .colorWhite),
                                                    border: InputBorder.none),
                                                onTap: () async {
                                                  DateTime? pickedDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate: DateTime(
                                                              1900), //- not to allow to choose before today.
                                                          lastDate: DateTime.now());

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
                                                    print(
                                                        "Date is not selected");
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
                                                    color: AppColors.colorWhite,
                                                    fontSize: 15.sp),
                                                controller: dateinput,
                                                decoration: InputDecoration(
                                                    hintStyle:
                                                        GoogleFonts.roboto(
                                                            color: AppColors
                                                                .colorWhite),
                                                    border: InputBorder.none),
                                                onTap: () async {
                                                  DateTime? pickedDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate: DateTime(
                                                              1900), //- not to allow to choose before today.
                                                          lastDate: DateTime.now());

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
                                                    print(
                                                        "Date is not selected");
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
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        color: AppColors.colorc7e,
                                        height: 95.h,
                                        width: size.width * 0.2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppRichTextView(
                                                  title: "Gender",
                                                  textColor:
                                                      AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                              Expanded(
                                                  child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: genders.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          for (var gender
                                                              in genders) {
                                                            gender.isSelected =
                                                                false;
                                                          }
                                                          genders[index]
                                                                  .isSelected =
                                                              true;
                                                          genderValue =
                                                              genders[index]
                                                                  .name;
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
                                                  textColor:
                                                      AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                              Expanded(
                                                  child: AppTextFormFieldWidget(
                                                textStyle: GoogleFonts.roboto(
                                                    color: AppColors.colorWhite,
                                                    fontSize: 15.sp),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "This Address is Required";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onSaved: (p0) {
                                                  facultyProvider
                                                      .setaddrss(p0!);
                                                },
                                                inputDecoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            color: AppColors
                                                                .colorGrey)),
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
                                                  title:
                                                      "Education qualification",
                                                  textColor:
                                                      AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                              Expanded(
                                                  child: AppTextFormFieldWidget(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                          RegExp(r'[a-zA-Z\s]'))
                                                ],
                                                textStyle: GoogleFonts.roboto(
                                                    color: AppColors.colorWhite,
                                                    fontSize: 15.sp),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "This Qualification is Required";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onSaved: (p0) {
                                                  facultyProvider
                                                      .setqualification(p0!);
                                                },
                                                inputDecoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            color: AppColors
                                                                .colorGrey)),
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
                                                  textColor:
                                                      AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                              Expanded(
                                                  child: AppTextFormFieldWidget(
                                                textStyle: GoogleFonts.roboto(
                                                    color: AppColors.colorWhite,
                                                    fontSize: 15.sp),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "This PassportNumber is Required";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onSaved: (p0) {
                                                  facultyProvider
                                                      .setpassport(p0!);
                                                },
                                                inputDecoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            color: AppColors
                                                                .colorGrey)),
                                                obscureText: false,
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        color: AppColors.colorc7e,
                                        height: 95.h,
                                        width: size.width * 0.2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppRichTextView(
                                                  title: "Job-Type",
                                                  textColor:
                                                      AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                              Expanded(
                                                  child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: jobType.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          for (var data
                                                              in jobType) {
                                                            data.isSelected =
                                                                false;
                                                          }
                                                          jobType[index]
                                                                  .isSelected =
                                                              true;
                                                          jobTypeValue =
                                                              jobType[index]
                                                                  .name;
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
                                                  textColor:
                                                      AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                              Expanded(
                                                  child: AppTextFormFieldWidget(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                          RegExp(r'[a-zA-Z\s]'))
                                                ],
                                                textStyle: GoogleFonts.roboto(
                                                    color: AppColors.colorWhite,
                                                    fontSize: 15.sp),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "This Citizenship is Required";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onSaved: (p0) {
                                                  facultyProvider
                                                      .setcitizen(p0!);
                                                },
                                                inputDecoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            color: AppColors
                                                                .colorGrey)),
                                                obscureText: false,
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : SizedBox(
                            height: size.height / 2,
                            width: 400,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: facultyProvider
                                  .facultyModel.facultyList?.length,
                              itemBuilder: (context, index) {
                                var data =
                                    facultyProvider.facultyModel.facultyList;
                                return InkWell(
                                  onTap: () {
                                    facultyProvider.selectTile(index);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0.sp),
                                    child: Container(
                                      color: AppColors.colorc7e,
                                      child: ListTile(
                                        trailing:
                                            facultyProvider.selectedIndex ==
                                                    index
                                                ? const Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                  )
                                                : null,
                                        leading: CircleAvatar(
                                          child: AppRichTextView(
                                            fontSize: 15.sp,
                                            title: data![index].firstName![0] +
                                                data[index].lastName![0],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        title: AppRichTextView(
                                          fontSize: 15.sp,
                                          title: data[index].firstName! +
                                              data[index].lastName!,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorWhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                    SizedBox(height: 10.h),
                    // const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          facultyProvider.isNewUser == true
                              ? AppElevatedButon(
                                  borderColor: AppColors.colorGreen,
                                  title: "Amend",
                                  buttonColor: AppColors.colorc7e,
                                  textColor: AppColors.colorWhite,
                                  height: 50.h,
                                  width: 150.w,
                                  onPressed: (context) async {
                                    if (programProvider.selectedDept == null) {
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
                                    } else if (facultyProvider.selectedIndex ==
                                        -1) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please Select Atleast one Faculty");
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
                                        var data = programProvider.newData
                                            .where((element) {
                                          return element["coursecode"] ==
                                              programProvider.selectedCourse!;
                                        }).toList();
                                        setState(() {
                                          selected_Course =
                                              data[0]["coursename"];
                                        });

                                        var result = await facultyProvider
                                            .updateCourseInFaculty(token,
                                                programId: int.parse(
                                                    programProvider
                                                        .selectedDept!),
                                                classId: int.parse(
                                                    programProvider
                                                        .selectedClass!),
                                                courseCode: programProvider
                                                    .selectedCourse!,
                                                courseName: selected_Course!,
                                                batch: programProvider
                                                    .selectedBatch!,
                                                facultyId: facultyProvider
                                                    .facultyModel
                                                    .facultyList![
                                                        facultyProvider
                                                            .selectedIndex]
                                                    .iD!);

                                        if (result != null) {
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                          }
                                        }
                                      }
                                    }
                                  },
                                )
                              : AppElevatedButon(
                                  borderColor: AppColors.colorGreen,
                                  title: "Hand in",
                                  buttonColor: AppColors.colorc7e,
                                  textColor: AppColors.colorWhite,
                                  height: 50.h,
                                  width: 160.w,
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
                                    } else if (programProvider.selectedDept ==
                                        null) {
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
                                        var data = programProvider.newData
                                            .where((element) {
                                          return element["coursecode"] ==
                                              programProvider.selectedCourse!;
                                        }).toList();
                                        setState(() {
                                          selected_Course =
                                              data[0]["coursename"];
                                        });
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();

                                          var result = await facultyProvider.addFaculty(
                                              token,
                                              programId: int.parse(
                                                  programProvider
                                                      .selectedDept!),
                                              classId: int.parse(programProvider
                                                  .selectedClass!),
                                              courseCode: programProvider
                                                  .selectedCourse!,
                                              courseName: selected_Course!,
                                              batch: programProvider
                                                  .selectedBatch!,
                                              facultyId:
                                                  "${DateTime.now().year}/${programProvider.selectedDept}/$randomString",
                                              gender: genderValue!,
                                              dob: dobinput.text,
                                              joiningDate: dateinput.text,
                                              userImage: imageEncoded!,
                                              jobType: jobTypeValue!);
                                          dev.log(result.toString());

                                          if (result != null) {
                                            if (context.mounted) {
                                              Navigator.pop(context);
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }),
                          SizedBox(
                            width: 10.h,
                          ),
                          AppElevatedButon(
                            borderColor: AppColors.colorRed,
                            title: "Cancel",
                            buttonColor: AppColors.colorc7e,
                            textColor: AppColors.colorWhite,
                            height: 50.h,
                            width: 150.w,
                            onPressed: (context) {},
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const VerticalDivider(),
              Expanded(
                flex: 1,
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
