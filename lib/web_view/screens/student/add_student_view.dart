import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/custom_plugin/editable.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/gender_model.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/batch_dropdown.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/class_dropdown.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/program_dropdown_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/year_dropdown_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/doa_drop_down.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/instruction_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_fees_details.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_radiobutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddStudentView extends StatefulWidget {
  const AddStudentView({super.key});

  @override
  State<AddStudentView> createState() => _AddStudentViewState();
}

class _AddStudentViewState extends State<AddStudentView> {
  final _formKey = GlobalKey<FormState>();
  List<Gender> genders = [];
  String? genderValue;
  bool hasError = false;
  final _editableKey = GlobalKey<EditableState>();
  List filterdcols = [];
  @override
  void initState() {
    genders.add(Gender("Male", false));
    genders.add(Gender("Female", false));
    super.initState();
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
  }

  List<int> selectedIDs = []; // List to store selected checkbox IDs

  TextEditingController dobinput = TextEditingController();
  Uint8List? bytesFromPicker;
  String? imageEncoded;
  String? gender;

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final programProvider = Provider.of<ProgramProvider>(context);
    final studentProvider = Provider.of<StudentProvider>(context);

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            color: AppColors.color0ec,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), bottomLeft: Radius.circular(50))),
        child: Padding(
          padding: EdgeInsets.all(29.sp),
          child: Row(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppRichTextView(
                            title: "Add New Student",
                            textColor: AppColors.colorc7e,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700),
                        Radio(
                          activeColor: AppColors.colorc7e,
                          value: 1,
                          groupValue: programProvider.isNewStudent,
                          onChanged: (value) {
                            programProvider.selectStudentType(value!);
                          },
                        ),
                        AppRichTextView(
                            title: "New Student",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                        Radio(
                          activeColor: AppColors.colorc7e,
                          value: 2,
                          groupValue: programProvider.isNewStudent,
                          onChanged: (value) {
                            programProvider.selectStudentType(value!);
                          },
                        ),
                        AppRichTextView(
                            title: "Transfer Student",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
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
                            InkWell(
                              onTap: () async {
                                bytesFromPicker =
                                    await ImagePickerWeb.getImageAsBytes();
                                // Get the size of the base64 string in bytes
                                int imageSizeInBytes =
                                    (base64.encode(bytesFromPicker!).length *
                                            3 /
                                            4)
                                        .ceil();

// Convert bytes to kilobytes
                                double imageSizeInKB = imageSizeInBytes / 1024;
                                if (imageSizeInKB > 50) {
                                  ToastHelper().errorToast(
                                      "Image size exceeds 50KB. Please choose a smaller image.");
                                  setState(() {
                                    imageEncoded = null;
                                  });
                                } else {
                                  imageEncoded =
                                      base64.encode(bytesFromPicker!);

                                  setState(() {});
                                }
                              },
                              child: CircleAvatar(
                                  backgroundColor: AppColors.colorc7e,
                                  radius: 60.sp,
                                  backgroundImage: imageEncoded == null
                                      ? const AssetImage(
                                          ImagePath.webfacultyfLogo)
                                      : MemoryImage(bytesFromPicker!)
                                          as ImageProvider),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            InkWell(
                              onTap: () async {
                                bytesFromPicker =
                                    await ImagePickerWeb.getImageAsBytes();
                                // Get the size of the base64 string in bytes
                                int imageSizeInBytes =
                                    (base64.encode(bytesFromPicker!).length *
                                            3 /
                                            4)
                                        .ceil();

// Convert bytes to kilobytes
                                double imageSizeInKB = imageSizeInBytes / 1024;
                                if (imageSizeInKB > 50) {
                                  ToastHelper().errorToast(
                                      "Image size exceeds 50KB. Please choose a smaller image.");
                                  setState(() {
                                    imageEncoded = null;
                                  });
                                } else {
                                  imageEncoded =
                                      base64.encode(bytesFromPicker!);

                                  setState(() {});
                                }
                              },
                              child: AppRichTextView(
                                  title: "Select Profile Image",
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
                          children: [
                            Row(
                              children: [
                                AppRichTextView(
                                    title: "Program",
                                    textColor: AppColors.colorc7e,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                                AppRichTextView(
                                    title: "*",
                                    textColor: AppColors.colorRed,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                            const ProgramDropdown(),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                AppRichTextView(
                                    title: "Class",
                                    textColor: AppColors.colorc7e,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                                AppRichTextView(
                                    title: "*",
                                    textColor: AppColors.colorRed,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ],
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
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                AppRichTextView(
                                    title: "Student Id",
                                    textColor: AppColors.colorc7e,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                                AppRichTextView(
                                    title: "*",
                                    textColor: AppColors.colorRed,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ],
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
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9/]')),
                                        ],
                                        validator: (p0) {
                                          if (p0 == null || p0.isEmpty) {
                                            return "This Field is required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        textStyle: const TextStyle(
                                            color: AppColors.colorWhite),
                                        onSaved: (p0) {
                                          studentProvider.setStudentId(p0!);
                                        },
                                        inputDecoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "00/000/000",
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
                            Row(
                              children: [
                                AppRichTextView(
                                    title: "Year",
                                    textColor: AppColors.colorc7e,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                                AppRichTextView(
                                    title: "*",
                                    textColor: AppColors.colorRed,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ],
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
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                AppRichTextView(
                                    title: "Batch",
                                    textColor: AppColors.colorc7e,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                                AppRichTextView(
                                    title: "*",
                                    textColor: AppColors.colorRed,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ],
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
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                AppRichTextView(
                                    title: "Date of Admission",
                                    textColor: AppColors.colorc7e,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                                AppRichTextView(
                                    title: "*",
                                    textColor: AppColors.colorRed,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                            const DoaDropdown()
                            //////
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    AppRichTextView(
                        title: "Student Personal Details".toUpperCase(),
                        textColor: AppColors.colorBlack,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800),
                    SizedBox(
                      height: 20.h,
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: 80.h,
                                  width: size.width * 0.2,
                                  decoration: const BoxDecoration(
                                    color: AppColors.colorc7e,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AppRichTextView(
                                                title: "First Name",
                                                textColor: AppColors.colorWhite,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            AppRichTextView(
                                                title: "*",
                                                textColor: AppColors.colorRed,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[a-zA-Z\s]'))
                                          ],
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return ToastHelper().errorToast(
                                                  "First Name is Required");
                                            } else {
                                              return null;
                                            }
                                          },
                                          onSaved: (p0) => studentProvider
                                              .firstNamecontroller = p0,
                                          inputDecoration:
                                              const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      color:
                                                          AppColors.colorGrey)),
                                          obscureText: false,
                                        )),
                                        const SizedBox(
                                          height: 3,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  color: AppColors.colorc7e,
                                  height: 80.h,
                                  width: size.width * 0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AppRichTextView(
                                                title: "Last Name",
                                                textColor: AppColors.colorWhite,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            AppRichTextView(
                                                title: "*",
                                                textColor: AppColors.colorRed,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[a-zA-Z\s]'))
                                          ],
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This Field is Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onSaved: (p0) => studentProvider
                                              .lastNamecontroller = p0,
                                          inputDecoration:
                                              const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      color:
                                                          AppColors.colorGrey)),
                                          obscureText: false,
                                        )),
                                        const SizedBox(
                                          height: 3,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  color: AppColors.colorc7e,
                                  height: 80.h,
                                  width: size.width * 0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AppRichTextView(
                                                title: "Email Address",
                                                textColor: AppColors.colorWhite,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            AppRichTextView(
                                                title: "*",
                                                textColor: AppColors.colorRed,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          validator: (value) {
                                            return EmailFormFieldValidator
                                                .validate(value);
                                          },
                                          onSaved: (p0) => studentProvider
                                              .emailcontroller = p0,
                                          inputDecoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  color: AppColors.colorGrey,
                                                  fontSize: 15.sp)),
                                          obscureText: false,
                                        )),
                                        const SizedBox(
                                          height: 3,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  color: AppColors.colorc7e,
                                  height: 80.h,
                                  width: size.width * 0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AppRichTextView(
                                                title: "Mobile Number",
                                                textColor: AppColors.colorWhite,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            AppRichTextView(
                                                title: "*",
                                                textColor: AppColors.colorRed,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This Field is Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onSaved: (p0) => studentProvider
                                              .mobileController = p0,
                                          inputDecoration:
                                              const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      color:
                                                          AppColors.colorGrey)),
                                          obscureText: false,
                                        )),
                                        const SizedBox(
                                          height: 3,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  color: AppColors.colorc7e,
                                  height: 80.h,
                                  width: size.width * 0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AppRichTextView(
                                                title: "DOB",
                                                textColor: AppColors.colorWhite,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            AppRichTextView(
                                                title: "*",
                                                textColor: AppColors.colorRed,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
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
                                                hintStyle: GoogleFonts.roboto(
                                                    color: AppColors.colorWhite,
                                                    fontSize: 15.sp),
                                                border: InputBorder.none),
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      builder:
                                                          (context, child) {
                                                        return Theme(
                                                            data: ThemeData
                                                                    .light()
                                                                .copyWith(
                                                              primaryColor: Colors
                                                                  .green, // Change calendar header color

                                                              colorScheme:
                                                                  const ColorScheme
                                                                      .light(
                                                                      primary:
                                                                          AppColors
                                                                              .colorc7e), // Change days' colors
                                                              buttonTheme:
                                                                  const ButtonThemeData(
                                                                textTheme:
                                                                    ButtonTextTheme
                                                                        .primary,
                                                              ),
                                                            ),
                                                            child: child!);
                                                      },
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
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
                                        const SizedBox(
                                          height: 3,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  color: AppColors.colorc7e,
                                  height: 80.h,
                                  width: size.width * 0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AppRichTextView(
                                                title: "Identification Number",
                                                textColor: AppColors.colorWhite,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            AppRichTextView(
                                                title: "*",
                                                textColor: AppColors.colorRed,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This Field is Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onSaved: (p0) => studentProvider
                                              .passportcontroller = p0,
                                          inputDecoration:
                                              const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      color:
                                                          AppColors.colorGrey)),
                                          obscureText: false,
                                        )),
                                        const SizedBox(
                                          height: 3,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  color: AppColors.colorc7e,
                                  height: 100.h,
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
                                        SizedBox(
                                          height: 5.h,
                                        ),
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
                                                    for (var gender
                                                        in genders) {
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
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  color: AppColors.colorc7e,
                                  height: 120.h,
                                  width: size.width * 0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AppRichTextView(
                                                title: "Home Address",
                                                textColor: AppColors.colorWhite,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            AppRichTextView(
                                                title: "*",
                                                textColor: AppColors.colorRed,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          maxLines: 3,
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This Field is Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onSaved: (p0) => studentProvider
                                              .addresscontroller = p0,
                                          inputDecoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  color: AppColors.colorGrey,
                                                  fontSize: 15.sp)),
                                          obscureText: false,
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  color: AppColors.colorc7e,
                                  height: 120.h,
                                  width: size.width * 0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AppRichTextView(
                                                title: "Mailing Address",
                                                textColor: AppColors.colorWhite,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            AppRichTextView(
                                                title: "*",
                                                textColor: AppColors.colorRed,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          maxLines: 3,
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This Field is Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onSaved: (p0) => studentProvider
                                              .mailingaddresscontroller = p0,
                                          inputDecoration:
                                              const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      color:
                                                          AppColors.colorGrey)),
                                          obscureText: false,
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  color: AppColors.colorc7e,
                                  height: 80.h,
                                  width: size.width * 0.2,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AppRichTextView(
                                                title:
                                                    "Emergency Contact Number",
                                                textColor: AppColors.colorWhite,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            AppRichTextView(
                                                title: "*",
                                                textColor: AppColors.colorRed,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This Field is Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onSaved: (p0) => studentProvider
                                              .emergencyContactcontroller = p0,
                                          inputDecoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  color: AppColors.colorGrey,
                                                  fontSize: 15.sp)),
                                          obscureText: false,
                                        )),
                                        const SizedBox(
                                          height: 3,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  color: AppColors.colorc7e,
                                  height: 80.h,
                                  width: size.width * 0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AppRichTextView(
                                                title: "Qualification",
                                                textColor: AppColors.colorWhite,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            AppRichTextView(
                                                title: "*",
                                                textColor: AppColors.colorRed,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This Field is Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onSaved: (p0) => studentProvider
                                              .qualificationcontroller = p0,
                                          inputDecoration:
                                              const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      color:
                                                          AppColors.colorGrey)),
                                          obscureText: false,
                                        )),
                                        const SizedBox(
                                          height: 3,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  color: AppColors.colorc7e,
                                  height: 80.h,
                                  width: size.width * 0.2,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AppRichTextView(
                                                title: "CitizenShip",
                                                textColor: AppColors.colorWhite,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            AppRichTextView(
                                                title: "*",
                                                textColor: AppColors.colorRed,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500),
                                          ],
                                        ),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[a-zA-Z\s]'))
                                          ],
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This Field is Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onSaved: (p0) => studentProvider
                                              .citizenshipcontroller = p0,
                                          inputDecoration:
                                              const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      color:
                                                          AppColors.colorGrey)),
                                          obscureText: false,
                                        )),
                                        const SizedBox(
                                          height: 3,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
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
                              width: 120.w,
                              loading: studentProvider.isLoading,
                              onPressed: (context) async {
                                if (imageEncoded == null) {
                                  ToastHelper().errorToast(
                                      "Please Select the User Image");
                                } else if (genderValue == null) {
                                  ToastHelper()
                                      .errorToast("Please Select the Gender");
                                } else if (programProvider.selectedDept ==
                                    null) {
                                  ToastHelper()
                                      .errorToast("Please Select the Program");
                                } else if (programProvider.selectedClass ==
                                    null) {
                                  ToastHelper()
                                      .errorToast("Please Select the Class");
                                } else if (programProvider.selectedBatch ==
                                    null) {
                                  ToastHelper()
                                      .errorToast("Please Select the Batch");
                                } else if(selectedIDs.isEmpty){
                                  ToastHelper()
                                      .errorToast("Please select the course");
                                }else {
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
                                    if (_formKey.currentState!.validate() &&
                                        context.mounted) {
                                      // Save the form
                                      _formKey.currentState!.save();
                                      if (context.mounted) {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: Text(
                                                  "Confirmation",
                                                  style: TextStyle(
                                                      fontSize: 30.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: StudentInstructionView(
                                                  dobInput: dobinput.text,
                                                  gender: genderValue,
                                                  imageEncoded: imageEncoded,
                                                  token: token,
                                                  selectedCourse: selectedIDs,
                                                ));
                                          },
                                        );
                                      }
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
                            width: 140.w,
                            onPressed: (context) {
                              Navigator.pop(context);
                            },
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
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: departmentProvider
                                      .coursesModel.courses!.length,
                                  itemBuilder: (context, index) {
                                    var currentItem = departmentProvider
                                        .coursesModel.courses![index];
                                    int itemId = currentItem.iD!;

                                    return Card(
                                      color: AppColors.colorc7e,
                                      child: CheckboxListTile(
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                          (states) => const BorderSide(
                                              width: 2.0,
                                              color: AppColors.colorWhite),
                                        ),
                                        checkColor: AppColors.colorc7e,
                                        activeColor: AppColors.colorWhite,
                                        title: AppRichTextView(
                                          title: currentItem.courseName!.trim(),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorWhite,
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AppRichTextView(
                                              title: currentItem.courseId!,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor: AppColors.colorWhite,
                                            ),
                                             AppRichTextView(
                                              title:"Assigned Lecture: ${currentItem.assignedLec! == ""? "Not Assigned":currentItem.assignedLec!}",
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              textColor:currentItem.assignedLec! == ""? AppColors.colorRed: AppColors.colorWhite,
                                            ),
                                          ],
                                        ),
                                        value: selectedIDs.contains(itemId),
                                        onChanged: (value) {

                                          setState(() {
                                            if (value!) {
                                              // Add the selected ID to the list
                                              selectedIDs.add(itemId);
                                            } else {
                                              // Remove the ID if the checkbox is unchecked
                                              selectedIDs.remove(itemId);
                                            }
                                          });
                                          print(selectedIDs);
                                        },
                                      ),
                                    );
                                  },
                                );
                             
                              }),
                            );
                          }),
                          const Divider(),
                          const Expanded(child: StudentFeesDetails())
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
