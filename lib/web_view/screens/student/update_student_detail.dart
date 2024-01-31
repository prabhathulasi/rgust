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

  List<int> selectedIDs = [];

  @override
  Widget build(BuildContext context) {
    TextEditingController dateinput =
        TextEditingController(text: widget.studentDetails.admissionDate);
    TextEditingController dobinput =
        TextEditingController(text: widget.studentDetails.dOB);

    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    
    final prgProvider = Provider.of<ProgramProvider>(context);
 final commonProvider = Provider.of<CommonProvider>(context);
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
                                            studentProvider.setfirstName(p0!);
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
                                            studentProvider.setLastName(p0!);
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
                                            studentProvider.setemail(p0!);
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
                                            studentProvider.setMobile(p0!);
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
                                            title: "Admission Date",
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
                                            studentProvider.setHomeaddrss(p0!);
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
                                            studentProvider.setmailaddrss(p0!);
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
                                            studentProvider.setpassport(p0!);
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
                                Consumer<StudentProvider>(
                                    builder: (context, studentConsumer, child) {
                                  return Container(
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
                                          studentConsumer.isstudentTypeEdit ==
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
                                                          studentConsumer
                                                              .setEditStudentType(
                                                                  true);
                                                        },
                                                        child: Icon(
                                                          Icons.edit,
                                                          color: AppColors
                                                              .color0ec,
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
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: AppColors
                                                            .colorWhite,
                                                      ),

                                                      // Array list of items
                                                      items: studentProvider
                                                          .studentType
                                                          .map((String items) {
                                                        return DropdownMenuItem(
                                                          value: items,
                                                          child:
                                                              AppRichTextView(
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
                                  );
                                }),
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
                                            studentProvider.setcitizen(p0!);
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
                            loading: studentProvider.isLoading,
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
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  var data = widget.studentDetails;
                                  var result = await studentProvider
                                      .updateStudentDetails(token,

                                      data.iD!.toString(),
                                          admissionDate: dateinput.text.isEmpty
                                              ? data.admissionDate!
                                              : dateinput.text,
                                          dob: dobinput.text.isEmpty
                                              ? data.dOB!
                                              : dobinput.text,
                                          gender: data.gender!,
                                 
                                          studentType: studentProvider
                                                      .isstudentTypeEdit ==
                                                  true
                                              ? studentProvider.studetnTypeValue
                                              : data.studentType!,
                                          userImage: data.userImage!);

                                  if (result != null && context.mounted) {
                                    Navigator.pop(context);
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
                          width: 150.w,
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
                        :prgProvider.selectedDept == "300"? Container():   const Padding(
                            padding: EdgeInsets.only(left: 18),
                            child: ClassDropdown(),
                          ),
                    SizedBox(
                      height: 15.h,
                    ),
                    studentConsumer.selectedCourseIndex == false
                        ? Container()
                        : prgProvider.selectedDept == "300"? Container():Padding(
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
                  prgProvider.selectedDept=="300"? Text("Data"):  prgProvider.newData.isEmpty
                        ? Container()
                        : Expanded(
                            child: Consumer<ProgramProvider>(
                                builder: (context, departmentProvider, child) {
                                return   ListView.builder(
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
                                      side: MaterialStateBorderSide.resolveWith(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppRichTextView(
                                            title: currentItem.courseId!,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            textColor: AppColors.colorWhite,
                                          ),
                                          AppRichTextView(
                                            title:
                                                "Assigned Lecture: ${currentItem.assignedLec! == "" ? "Not Assigned" : currentItem.assignedLec!}",
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            textColor:
                                                currentItem.assignedLec! == ""
                                                    ? AppColors.colorRed
                                                    : AppColors.colorWhite,
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
                                          if (selectedIDs.isEmpty) {
                                            ToastHelper().errorToast(
                                                "Please Select the Course");
                                          } else {
                                            var token =
                                                await getTokenAndUseIt();
                                            if (token == null) {
                                              if (context.mounted) {
                                                Navigator.pushNamed(
                                                    context, RouteNames.login);
                                              }
                                            } else if (token ==
                                                "Token Expired") {
                                              ToastHelper().errorToast(
                                                  "Session Expired Please Login Again");

                                              if (context.mounted) {
                                                Navigator.pushNamed(
                                                    context, RouteNames.login);
                                              }
                                            } else {
                                              var result = await studentProvider
                                                  .updateStudentClass(token,
                                                      selectedCourseList:
                                                          selectedIDs,
                                                      programId: int.parse(
                                                          prgProvider
                                                              .selectedDept!),
                                                      classId: int.parse(
                                                          prgProvider
                                                              .selectedClass!),
                                                      studentId: widget
                                                          .studentDetails.iD,
                                                          currentClass: commonProvider.isChecked
                                                          );
                                              if (result != null) {
                                           
                                                if (context.mounted) {
                                                  Navigator.pop(context);
                                                }
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
