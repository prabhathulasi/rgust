import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/custom_plugin/commons/helper.dart';
import 'package:rugst_alliance_academia/custom_plugin/editable.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/gender_model.dart';
import 'package:rugst_alliance_academia/data/model/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/provider/common_provider.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/batch_dropdown.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/class_dropdown.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/program_dropdown_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/year_dropdown_view.dart';

import 'package:rugst_alliance_academia/web_view/screens/faculty/gender_view.dart';

import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateStudentDetails extends StatefulWidget {
  final StudentDetail studentDetails;
  const UpdateStudentDetails({super.key, required this.studentDetails});

  @override
  State<UpdateStudentDetails> createState() => _AddFacultyViewState();
}

class _AddFacultyViewState extends State<UpdateStudentDetails> {
  final _formKey = GlobalKey<FormState>();

  List<JobType> jobType = [];

  String? jobTypeValue;

  bool dropdownSelected = false;
  Uint8List? bytesFromPicker;
  String? imageEncoded;
  final _noneditableKey = GlobalKey<EditableState>();
  // List of items in our dropdown menu
  List rows = [];
  List filterdcols = [];
  addRow() {
    rows = addOneRow(filterdcols, rows);

    setState(() {});
  }

  @override
  void initState() {
    addRow();
    filterdcols = [
      {
        "title": 'Course Code',
        'widthFactor': 0.15,
        'key': 'coursecode',
      },
      {"title": 'Course Name', 'widthFactor': 0.2, 'key': 'coursename'},
      {"title": 'Credits', 'widthFactor': 0.1, 'key': 'credits'},
      {
        "title": 'Assigned Lectures',
        'widthFactor': 0.2,
        'key': 'lectures',
        'editable': false
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController dateinput =
        TextEditingController(text: widget.studentDetails.admissionDate);
    TextEditingController dobinput =
        TextEditingController(text: widget.studentDetails.dOB);

    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    final facultyProvider = Provider.of<FacultyProvider>(context);
    final prgProvider = Provider.of<ProgramProvider>(context);

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          color: AppColors.color0ec,
        ),
        child: Padding(
          padding: EdgeInsets.all(29.sp),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppRichTextView(
                      title: "Update Student",
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
                                    widget.studentDetails.userImage!))
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
                        width: 15.w,
                      ),
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
                    child: Form(
                      key: _formKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            child: Column(
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
                                          initialValue:
                                              widget.studentDetails.firstName,
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          onSaved: (p0) {
                                            facultyProvider.setfirstName(p0!);
                                          },
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
                                        AppRichTextView(
                                            title: "Last Name",
                                            textColor: AppColors.colorWhite,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          initialValue:
                                              widget.studentDetails.lastName,
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          onSaved: (p0) {
                                            facultyProvider.setLastName(p0!);
                                          },
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
                                        AppRichTextView(
                                            title: "Email Address",
                                            textColor: AppColors.colorWhite,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          initialValue:
                                              widget.studentDetails.email,
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
                                        AppRichTextView(
                                            title: "Mobile Number",
                                            textColor: AppColors.colorWhite,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          initialValue: widget
                                              .studentDetails.mobileNumber
                                              .toString(),
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          onSaved: (p0) {
                                            facultyProvider.setMobile(p0!);
                                          },
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
                                                hintStyle: GoogleFonts.roboto(
                                                    color:
                                                        AppColors.colorWhite),
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
                                            style: GoogleFonts.roboto(
                                                color: AppColors.colorWhite,
                                                fontSize: 15.sp),
                                            controller: dateinput,
                                            decoration: InputDecoration(
                                                hintStyle: GoogleFonts.roboto(
                                                    color:
                                                        AppColors.colorWhite),
                                                border: InputBorder.none),
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
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
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  color: AppColors.colorc7e,
                                  height: 70.h,
                                  width: size.width * 0.2,
                                  child: Padding(
                                      padding: EdgeInsets.all(8.0.sp),
                                      child: GenderView(
                                        gender: widget.studentDetails.gender!,
                                      )),
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
                                        AppRichTextView(
                                            title: "Home Address",
                                            textColor: AppColors.colorWhite,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          maxLines: 3,
                                          initialValue:
                                              widget.studentDetails.address,
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          onSaved: (p0) {
                                            facultyProvider.setaddrss(p0!);
                                          },
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
                                  height: 120.h,
                                  width: size.width * 0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppRichTextView(
                                            title: "Mailing Address",
                                            textColor: AppColors.colorWhite,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          maxLines: 3,
                                          initialValue: widget
                                              .studentDetails.mailingAddress,
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          onSaved: (p0) {
                                            facultyProvider
                                                .setqualification(p0!);
                                          },
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
                                        AppRichTextView(
                                            title: "Passport Number",
                                            textColor: AppColors.colorWhite,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          initialValue: widget
                                              .studentDetails.passportNumber,
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          onSaved: (p0) {
                                            facultyProvider.setpassport(p0!);
                                          },
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
                                        AppRichTextView(
                                            title: "Student-Type",
                                            textColor: AppColors.colorWhite,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                        studentProvider.isstudentTypeEdit ==
                                                false
                                            ? Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    AppRichTextView(
                                                      title: widget
                                                          .studentDetails
                                                          .studentType!,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      textColor:
                                                          AppColors.color0ec,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        studentProvider
                                                            .setEditStudentType(
                                                                true);
                                                      },
                                                      child: Icon(
                                                        Icons.edit,
                                                        color:
                                                            AppColors.color0ec,
                                                        size: 20.sp,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Expanded(
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    iconDisabledColor:
                                                        AppColors.colorWhite,
                                                    dropdownColor:
                                                        AppColors.colorc7e,
                                                    isExpanded: true,

                                                    // Initial Value
                                                    value: studentProvider
                                                        .studetnTypeValue,

                                                    // Down Arrow Icon
                                                    icon: const Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color:
                                                          AppColors.colorWhite,
                                                    ),

                                                    // Array list of items
                                                    items: studentProvider
                                                        .studentType
                                                        .map((String items) {
                                                      return DropdownMenuItem(
                                                        value: items,
                                                        child: AppRichTextView(
                                                          fontSize: 15.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          title: items,
                                                          textColor: AppColors
                                                              .colorWhite,
                                                        ),
                                                      );
                                                    }).toList(),
                                                    // After selecting the desired option,it will
                                                    // change button value to selected value
                                                    onChanged:
                                                        (String? newValue) {
                                                      studentProvider
                                                          .setStudentType(
                                                              newValue!);
                                                    },
                                                  ),
                                                ),
                                              )
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
                                          initialValue:
                                              widget.studentDetails.citizenship,
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,
                                              fontSize: 15.sp),
                                          onSaved: (p0) {
                                            facultyProvider.setcitizen(p0!);
                                          },
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
                            width: 150.w,
                            loading: facultyProvider.isLoading,
                            onPressed: (context) async {
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
                                // if (_formKey.currentState!.validate()) {
                                //       _formKey.currentState!.save();
                                //              var data = widget.facultyDetail;
                                //     var result = await facultyProvider.updateFacultyDetails(token,
                                // updatedaddress: facultyProvider.address.isEmpty ? data.address! : facultyProvider.addresscontroller!,
                                // updatedcitizenship: facultyProvider.cizizen.isEmpty ? data.citizenship!: facultyProvider.citizenshipcontroller!,
                                // updatedemail: facultyProvider.email.isEmpty? data.email!:facultyProvider.emailcontroller!,
                                // updatedfirstName: facultyProvider.firstname.isEmpty? data.firstName!: facultyProvider.firstNamecontroller!,
                                // updatedlastName: facultyProvider.lastname.isEmpty? data.lastName!: facultyProvider.lastNamecontroller!,
                                // updatedmobile: facultyProvider.mobile.isEmpty? data.mobile!: facultyProvider.mobileController!,
                                // updatedpassportNumber: facultyProvider.passport.isEmpty? data.passportNumber!: facultyProvider.passportcontroller!,
                                // updatedQualifiation: facultyProvider.qualification.isEmpty? data.qualifiation!: facultyProvider.qualificationcontroller! ,
                                // updatedfacultyId: data.facultyId!,
                                // updatedgender: data.gender!,
                                // updateddob: data.dob!, updatedjoiningDate: data.joiningDate!,
                                // updateduserImage: data.userImage!,
                                // updatedjobType: facultyProvider.isjobTypeEdit == false? data.jobType!:jobTypeValue!,
                                // id: data.iD!);

                                //        if(result!=null && context.mounted) {

                                //         Navigator.pop(context);

                                //        }
                                //       }
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
              SizedBox(
                width: 5.w,
              ),
              const VerticalDivider(
                color: AppColors.colorBlack,
                width: 2,
              ),
              Expanded(child: Consumer<StudentProvider>(
                  builder: (context, studentConsumer, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppRichTextView(
                          title: studentConsumer.selectedCourseIndex == false
                              ? "Current Class"
                              : "Update Class",
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          textColor: AppColors.colorc7e,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        InkWell(
                            onTap: () {
                              if (studentConsumer.selectedCourseIndex ==
                                  false) {
                                studentConsumer.selectCourseIndex(true);
                              } else {
                                prgProvider.newData.clear();
                                studentConsumer.selectCourseIndex(false);
                              }
                            },
                            child: studentConsumer.selectedCourseIndex == false
                                ? const Icon(
                                    Icons.edit,
                                    color: AppColors.colorc7e,
                                  )
                                : const Icon(
                                    Icons.close,
                                    color: AppColors.colorc7e,
                                  ))
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    studentConsumer.selectedCourseIndex == false
                        ? Padding(
                            padding: const EdgeInsets.only(top: 18.0, left: 18),
                            child: Container(
                              color: AppColors.colorc7e,
                              height: 75.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Current Program",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                        child: AppTextFormFieldWidget(
                                      enable: false,
                                      initialValue: widget
                                          .studentDetails.currentProgramName,
                                      textStyle: GoogleFonts.roboto(
                                          color: AppColors.colorWhite,
                                          fontSize: 15.sp),
                                      onSaved: (p0) {
                                        // facultyProvider.setLastName(p0!);
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
                          )
                        : const Padding(
                            padding: EdgeInsets.only(top: 18.0, left: 18),
                            child: ProgramDropdown(),
                          ),
                    SizedBox(
                      height: 15.h,
                    ),
                    studentConsumer.selectedCourseIndex == false
                        ? Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Container(
                              color: AppColors.colorc7e,
                              height: 70.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Current class",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                        child: AppTextFormFieldWidget(
                                      enable: false,
                                      initialValue: widget
                                          .studentDetails.currentClassName,
                                      textStyle: GoogleFonts.roboto(
                                          color: AppColors.colorWhite,
                                          fontSize: 15.sp),
                                      onSaved: (p0) {
                                        // facultyProvider.setLastName(p0!);
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
                          )
                        : const Padding(
                            padding: EdgeInsets.only(left: 18),
                            child: ClassDropdown(),
                          ),
                    SizedBox(
                      height: 15.h,
                    ),
                    studentConsumer.selectedCourseIndex == false
                        ? Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Container(
                              color: AppColors.colorc7e,
                              height: 70.h,
                              width: size.width * 0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Batch",
                                        textColor: AppColors.colorWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    Expanded(
                                        child: AppTextFormFieldWidget(
                                      enable: false,
                                      initialValue: widget.studentDetails.batch,
                                      textStyle: GoogleFonts.roboto(
                                          color: AppColors.colorWhite,
                                          fontSize: 15.sp),
                                      onSaved: (p0) {
                                        // facultyProvider.setLastName(p0!);
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
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Column(
                              children: [
                                const DynamicYearsDropdown(),
                                SizedBox(
                                  height: 10.h,
                                ),
                                const BatchDropdown(),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 15.h,
                    ),
                    (studentConsumer.selectedCourseIndex == false ||
                            prgProvider.selectedBatch == null)
                        ? Container()
                        : Consumer<CommonProvider>(
                            builder: (context, checkboxModel, _) => Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Row(
                                children: [
                                  Checkbox(
                                    activeColor: AppColors.colorc7e,
                                    value: checkboxModel.isChecked,
                                    onChanged: (bool? value) {
                                      checkboxModel
                                          .toggleCheckbox(value ?? false);
                                    },
                                  ),
                                  AppRichTextView(
                                    title: "Current Class",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    textColor: AppColors.colorc7e,
                                  )
                                ],
                              ),
                            ),
                          ),
                    Divider(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    studentConsumer.selectedCourseIndex == true &&
                            prgProvider.selectedBatch != null
                        ? Center(
                            child: (widget.studentDetails.currentClassId
                                            .toString() ==
                                        prgProvider.selectedClass &&
                                    widget.studentDetails.batch ==
                                        prgProvider.selectedBatch)
                                ? AppRichTextView(
                                    title: "Current Class",
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                    textColor: AppColors.colorGreen,
                                  )
                                : prgProvider.newData.isEmpty
                                    ? AppRichTextView(
                                        title:
                                            "No Course Found Kindly add the Course in the Department Section",
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorRed,
                                      )
                                    : AppRichTextView(
                                        title: "Registered Course",
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorc7e,
                                      ))
                        : Container(),
                    prgProvider.newData.isEmpty
                        ? Container()
                        : Expanded(
                            child: Consumer<ProgramProvider>(
                                builder: (context, departmentProvider, child) {
                              return Editable(
                                enabled: false,
                                key: _noneditableKey,
                                showRemoveIcon: false,
                                columns: filterdcols,
                                rows: departmentProvider.newData,
                                zebraStripe: true,
                                stripeColor1: AppColors.colorc7e,
                                stripeColor2: AppColors.colorc7e,
                                onRowSaved: (value) async {
                                  //   await departmentProvider.patchCoursesList(context,
                                  //  courseName: value["coursename"],
                                  // courseid: value["coursecode"],
                                  // credits: int.parse(value["credits"]));
                                },
                                onSubmitted: (value) {
                                  print(value);
                                },

                                borderColor: Colors.blueGrey,
                                tdStyle: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.colorWhite),
                                trHeight: 100.h,
                                thStyle: TextStyle(
                                    fontSize: 18.sp,
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
                                tdPaddingTop: 10.h,
                                tdPaddingBottom: 14.h,
                                tdPaddingLeft: 10.w,
                                tdPaddingRight: 8.w,
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0))),
                              );
                            }),
                          ),
                    prgProvider.newData.isEmpty
                        ? Container()
                        : widget.studentDetails.currentClassId.toString() ==
                                prgProvider.selectedClass
                            ? Container()
                            : widget.studentDetails.registeredCourse!
                                    .where((element) =>
                                        element.classId.toString() ==
                                            prgProvider.selectedClass ||
                                        element.batch ==
                                            prgProvider.selectedBatch)
                                    .toList()
                                    .isEmpty
                                ? Row(
                                    children: [
                                      AppElevatedButon(
                                        loading: studentProvider.isLoading,
                                        title: "Amend",
                                        buttonColor: AppColors.colorc7e,
                                        height: 50.h,
                                        width: 150.w,
                                        onPressed: (context) async {
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
                                            var result = await studentProvider
                                                .updateStudentClass(token,
                                                    programId: int.parse(
                                                        prgProvider
                                                            .selectedDept!),
                                                    batch: prgProvider
                                                        .selectedBatch,
                                                    classId: int.parse(
                                                        prgProvider
                                                            .selectedClass!),
                                                    currentClass: false,
                                                    studentId: widget
                                                        .studentDetails.iD);
                                       if (result != null) {
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    }
                                          }
                                        },
                                        borderColor: AppColors.colorWhite,
                                        textColor: AppColors.colorWhite,
                                      ),
                                      AppElevatedButon(
                                        title: "Cancel",
                                        buttonColor: AppColors.colorc7e,
                                        height: 50.h,
                                        width: 150.w,
                                        onPressed: (context) {},
                                        borderColor: AppColors.colorWhite,
                                        textColor: AppColors.colorWhite,
                                      )
                                    ],
                                  )
                                : AppRichTextView(
                                    title:
                                        "Already Courses are Registered in the Selected batch",
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                    textColor: AppColors.colorRed,
                                  )
                  ],
                );
              }))
            ],
          ),
        ),
      ),
    );
  }
}
