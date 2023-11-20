import 'dart:convert';
import 'dart:typed_data';

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

  TextEditingController dateinput = TextEditingController();
  TextEditingController dobinput = TextEditingController();
  Uint8List? bytesFromPicker;
  String? imageEncoded;

  showTermsDialog(BuildContext context, StudentProvider studentProvider,
      String token, ProgramProvider programProvider) {
    Dialog alert = Dialog(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height / 2,
        width: MediaQuery.sizeOf(context).width / 2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Confirmation",
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "1.I confirm that all the information provided is accurate and up to date to the best of my knowledge.",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "2.I ensure that there are no duplicate entries or redundant information in the submitted data.",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "3.The provided image adheres to the requirement of a white background as specified for identification purposes.",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "4.I have verified that there are no errors or inaccuracies in the information submitted, ensuring its correctness.",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "5.I affirm that the information submitted maintains its integrity and authenticity without manipulation or misrepresentation.",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "6.The image submitted complies with the mandated criteria, ensuring clarity and adherence to guidelines.",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  AppElevatedButon(
                      title: "Submit",
                      buttonColor: AppColors.colorc7e,
                      textColor: AppColors.colorWhite,
                      height: 50.h,
                      width: 130.w,
                      loading: studentProvider.isLoading,
                      onPressed: (context) async {
                        var result = await studentProvider.addStudent(
                          token,
                          programId: int.parse(programProvider.selectedDept!),
                          classId: int.parse(programProvider.selectedClass!),
                          admissionDate: dateinput.text,
                          studentType: "Regular",
                          batch: programProvider.selectedBatch!,
                          registerNo:
                              "${DateTime.now().year}/${programProvider.selectedDept}/212",
                          gender: genderValue!,
                          dob: dobinput.text,
                          userImage: imageEncoded!,
                        );

                        if (result != null) {
                          if (context.mounted) {
                            Navigator.pop(context);
                                   Navigator.pop(context);
                          }
                        }
                      }),
                  SizedBox(
                    width: 10.w,
                  ),
                  AppElevatedButon(
                      title: "Close",
                      buttonColor: AppColors.colorc7e,
                      textColor: AppColors.colorWhite,
                      height: 50.h,
                      width: 130.w,
                      loading: studentProvider.isLoading,
                      onPressed: (context) async {})
                ],
              )
            ],
          ),
        ),
      ),
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
                          value: false,
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
                          value: true,
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
                            CircleAvatar(
                                backgroundColor: AppColors.colorc7e,
                                radius: 60.sp,
                                backgroundImage: imageEncoded == null
                                    ? const AssetImage(
                                        ImagePath.webfacultyfLogo)
                                    : MemoryImage(bytesFromPicker!)
                                        as ImageProvider),
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
                            AppRichTextView(
                                title: "Student Id",
                                textColor: AppColors.colorc7e,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
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
                                                : "${DateTime.now().year}/${programProvider.selectedDept}/126",
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
                            Container(
                              color: AppColors.colorc7e,
                              height: 70.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Date of Admission",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This DOB is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        style: GoogleFonts.roboto(
                                            color: AppColors.colorWhite,
                                            fontSize: 15.sp),
                                        controller: dateinput,
                                        decoration: InputDecoration(
                                            errorStyle: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.colorRed),
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
                                  height: 70.h,
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
                                                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                                              ],
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return ToastHelper().errorToast("First Name is Required");
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
                                                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
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
                                                 FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                                  height: 80.h,
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
                                  height: 70.h,
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
                                  height: 70.h,
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
                                                title: "Tution Fee",
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
                                                 FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                                              .tutionfeecontroller = p0!,
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
                                  height: 70.h,
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
                                                 FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                                                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
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
                                    if (_formKey.currentState!.validate() &&
                                        context.mounted) {
                                      // Save the form
                                      _formKey.currentState!.save();
                                      if (context.mounted) {
                                        showTermsDialog(
                                            context,
                                            studentProvider,
                                            token,
                                            programProvider);
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
                            width: 120.w,
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

  Widget columnWrapper(BuildContext context, int columnIndex, Widget child) {
    const padding = EdgeInsets.symmetric(horizontal: 10);
    switch (columnIndex) {
      case 0:
        return Container(
          width: 120,
          padding: padding,
          child: child,
        );
      case 1:
        return Container(
          width: 130,
          padding: padding,
          child: child,
        );
      case 2:
        return Container(
          width: 130,
          padding: padding,
          child: child,
        );
      case 3:
        return Container(
          width: 170,
          padding: padding,
          child: child,
        );
      case 4:
        return Container(
          width: 130,
          padding: padding,
          child: child,
        );
      default:
        return Expanded(
          child: Container(
            padding: padding,
            child: child,
          ),
        );
    }
  }
}
