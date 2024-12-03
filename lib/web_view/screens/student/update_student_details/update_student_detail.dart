import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/gender_model.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/provider/clincial_provider.dart';
import 'package:rugst_alliance_academia/data/provider/common_provider.dart';
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
import 'package:rugst_alliance_academia/web_view/screens/student/update_student_details/custom%20list/clinical_list.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/update_student_details/custom%20list/course_list.dart';
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

  

  @override
  Widget build(BuildContext context) {
    TextEditingController dateinput =
        TextEditingController(text: widget.studentDetails.admissionDate);
    TextEditingController dobinput =
        TextEditingController(text: widget.studentDetails.dOB);

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(color: AppColors.colorWhite),
        child: Consumer<StudentProvider>(
            builder: (context, studentConsumer, child) {
          return Row(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w, top: 5.h),
                  child: Container(
                    padding: EdgeInsets.all(19.sp),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.colorc7e, width: 3.w)),
                    child: Column(
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
                          children: [
                            Column(
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
                                    imageEncoded =
                                        base64.encode(bytesFromPicker!);

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
                        Form(
                          key: _formKey,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.colorWhite,
                                        border: Border.all(
                                            color: AppColors.colorc7e,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(8)),
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
                                              textColor: AppColors.colorBlack,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                          Expanded(
                                              child: AppTextFormFieldWidget(
                                            initialValue:
                                                widget.studentDetails.firstName,
                                            textStyle: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.colorc7e,
                                                fontSize: 15.sp),
                                            onSaved: (p0) {
                                              studentConsumer.setfirstName(p0!);
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
                                    decoration: BoxDecoration(
                                        color: AppColors.colorWhite,
                                        border: Border.all(
                                            color: AppColors.colorc7e,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(8)),
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
                                              textColor: AppColors.colorBlack,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                          Expanded(
                                              child: AppTextFormFieldWidget(
                                            initialValue:
                                                widget.studentDetails.lastName,
                                            textStyle: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.colorc7e,
                                                fontSize: 15.sp),
                                            onSaved: (p0) {
                                              studentConsumer.setLastName(p0!);
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
                                    decoration: BoxDecoration(
                                        color: AppColors.colorWhite,
                                        border: Border.all(
                                            color: AppColors.colorc7e,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(8)),
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
                                              textColor: AppColors.colorBlack,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                          Expanded(
                                              child: AppTextFormFieldWidget(
                                            initialValue:
                                                widget.studentDetails.email,
                                            textStyle: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.colorc7e,
                                                fontSize: 15.sp),
                                            validator: (value) {
                                              return EmailFormFieldValidator
                                                  .validate(value);
                                            },
                                            onSaved: (p0) {
                                              studentConsumer.setemail(p0!);
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
                                    decoration: BoxDecoration(
                                        color: AppColors.colorWhite,
                                        border: Border.all(
                                            color: AppColors.colorc7e,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(8)),
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
                                              textColor: AppColors.colorBlack,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                          Expanded(
                                              child: AppTextFormFieldWidget(
                                            initialValue: widget
                                                .studentDetails.mobileNumber
                                                .toString(),
                                            textStyle: GoogleFonts.roboto(
                                                color: AppColors.colorc7e,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.sp),
                                            onSaved: (p0) {
                                              studentConsumer.setMobile(p0!);
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
                                    decoration: BoxDecoration(
                                        color: AppColors.colorWhite,
                                        border: Border.all(
                                            color: AppColors.colorc7e,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(8)),
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
                                              textColor: AppColors.colorBlack,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold),
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
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.colorc7e,
                                                  fontSize: 15.sp),
                                              controller: dobinput,
                                              decoration: InputDecoration(
                                                  hintStyle: GoogleFonts.roboto(
                                                      color:
                                                          AppColors.colorGrey),
                                                  border: InputBorder.none),
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate: DateTime(
                                                            1900), //- not to allow to choose before today.
                                                        lastDate:
                                                            DateTime(2101));

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
                                    decoration: BoxDecoration(
                                        color: AppColors.colorWhite,
                                        border: Border.all(
                                            color: AppColors.colorc7e,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(8)),
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
                                              textColor: AppColors.colorBlack,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                          Expanded(
                                            child: TextFormField(
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.colorc7e,
                                                  fontSize: 15.sp),
                                              controller: dateinput,
                                              decoration: InputDecoration(
                                                  hintStyle: GoogleFonts.roboto(
                                                      color:
                                                          AppColors.colorGrey),
                                                  border: InputBorder.none),
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate: DateTime
                                                            .now(), //- not to allow to choose before today.
                                                        lastDate:
                                                            DateTime(2101));

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
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.colorWhite,
                                        border: Border.all(
                                            color: AppColors.colorc7e,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(8)),
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
                                              textColor: AppColors.colorBlack,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                          Expanded(
                                              child: AppTextFormFieldWidget(
                                            initialValue: widget
                                                .studentDetails.citizenship,
                                            textStyle: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.colorc7e,
                                                fontSize: 15.sp),
                                            onSaved: (p0) {
                                              studentConsumer.setcitizen(p0!);
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
                                ],
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.colorWhite,
                                        border: Border.all(
                                            color: AppColors.colorc7e,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(8)),
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
                                    decoration: BoxDecoration(
                                        color: AppColors.colorWhite,
                                        border: Border.all(
                                            color: AppColors.colorc7e,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(8)),
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
                                              textColor: AppColors.colorBlack,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                          Expanded(
                                              child: AppTextFormFieldWidget(
                                            maxLines: 3,
                                            initialValue:
                                                widget.studentDetails.address,
                                            textStyle: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.colorc7e,
                                                fontSize: 15.sp),
                                            onSaved: (p0) {
                                              studentConsumer
                                                  .setHomeaddrss(p0!);
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
                                    decoration: BoxDecoration(
                                        color: AppColors.colorWhite,
                                        border: Border.all(
                                            color: AppColors.colorc7e,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(8)),
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
                                              textColor: AppColors.colorBlack,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                          Expanded(
                                              child: AppTextFormFieldWidget(
                                            maxLines: 3,
                                            initialValue: widget
                                                .studentDetails.mailingAddress,
                                            textStyle: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.colorc7e,
                                                fontSize: 15.sp),
                                            onSaved: (p0) {
                                              studentConsumer
                                                  .setmailaddrss(p0!);
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
                                    decoration: BoxDecoration(
                                        color: AppColors.colorWhite,
                                        border: Border.all(
                                            color: AppColors.colorc7e,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(8)),
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
                                              textColor: AppColors.colorBlack,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                          Expanded(
                                              child: AppTextFormFieldWidget(
                                            initialValue: widget
                                                .studentDetails.passportNumber,
                                            textStyle: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.colorc7e,
                                                fontSize: 15.sp),
                                            onSaved: (p0) {
                                              studentConsumer.setpassport(p0!);
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
                                  Consumer<StudentProvider>(builder:
                                      (context, studentConsumer, child) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.colorWhite,
                                          border: Border.all(
                                              color: AppColors.colorc7e,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(8)),
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
                                                textColor: AppColors.colorBlack,
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
                                                          textColor: AppColors
                                                              .colorc7e,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            studentConsumer
                                                                .setEditStudentType(
                                                                    true);
                                                          },
                                                          child: Icon(
                                                            Icons.edit_outlined,
                                                            color: AppColors
                                                                .colorRed,
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
                                                            AppColors
                                                                .colorWhite,
                                                        dropdownColor: AppColors
                                                            .colorWhite,
                                                        isExpanded: true,

                                                        // Initial Value
                                                        value: studentConsumer
                                                            .studetnTypeValue,

                                                        // Down Arrow Icon
                                                        icon: const Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          color: AppColors
                                                              .colorc7e,
                                                        ),

                                                        // Array list of items
                                                        items: studentConsumer
                                                            .studentType
                                                            .map(
                                                                (String items) {
                                                          return DropdownMenuItem(
                                                            value: items,
                                                            child:
                                                                AppRichTextView(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              title: items,
                                                              textColor:
                                                                  AppColors
                                                                      .colorc7e,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        // After selecting the desired option,it will
                                                        // change button value to selected value
                                                        onChanged:
                                                            (String? newValue) {
                                                          studentConsumer
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
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            children: [
                              AppElevatedButon(
                                  borderColor: AppColors.colorc7e,
                                  title: "Save",
                                  buttonColor: AppColors.colorWhite,
                                  textColor: AppColors.colorc7e,
                                  height: 50.h,
                                  width: 150.w,
                                  loading: studentConsumer.isLoading,
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
                                        var result = await studentConsumer
                                            .updateStudentDetails(
                                                token, data.iD!.toString(),
                                                admissionDate:
                                                    dateinput.text.isEmpty
                                                        ? data.admissionDate!
                                                        : dateinput.text,
                                                dob: dobinput.text.isEmpty
                                                    ? data.dOB!
                                                    : dobinput.text,
                                                gender: data.gender!,
                                                studentType: studentConsumer
                                                            .isstudentTypeEdit ==
                                                        true
                                                    ? studentConsumer
                                                        .studetnTypeValue
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
                                borderColor: AppColors.colorRed,
                                title: "Cancel",
                                buttonColor: AppColors.colorWhite,
                                textColor: AppColors.colorRed,
                                height: 50.h,
                                width: 150.w,
                                onPressed: (context) {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(child: Consumer<ProgramProvider>(
                  builder: (context, programConsumer, child) {
                return Consumer<ClincialProvider>(
                    builder: (context, clincalConsumer, child) {
                  return Consumer<CommonProvider>(
                      builder: (context, commonConsumer, child) {
                    List<RegisteredCourse>? registeredCourse = studentConsumer
                        .studentDetailModel.studentDetail!.registeredCourse!;

                    return Padding(
                      padding: EdgeInsets.only(right: 5.w, top: 5.h),
                      child: Container(
                        height: size.height,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.colorc7e, width: 3.w)),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 19.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppRichTextView(
                                      title:
                                          studentConsumer.selectedCourseIndex ==
                                                  false
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
                                          if (studentConsumer
                                                  .selectedCourseIndex ==
                                              false) {
                                            programConsumer.newData.clear();
                                            studentConsumer
                                                .selectCourseIndex(true);
                                          } else {
                                            programConsumer.newData.clear();
                                            studentConsumer
                                                .selectCourseIndex(false);
                                          }
                                        },
                                        child: studentConsumer
                                                    .selectedCourseIndex ==
                                                false
                                            ? const Icon(
                                                Icons.edit_outlined,
                                                color: AppColors.colorRed,
                                              )
                                            : const Icon(
                                                Icons.close,
                                                color: AppColors.colorRed,
                                              ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              studentConsumer.selectedCourseIndex == false
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 18.0, left: 18),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.colorWhite,
                                            border: Border.all(
                                                color: AppColors.colorc7e,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        height: 75.h,
                                        width: size.width * 0.2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppRichTextView(
                                                  title: "Current Program",
                                                  textColor:
                                                      AppColors.colorBlack,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold),
                                              Expanded(
                                                  child: AppTextFormFieldWidget(
                                                enable: false,
                                                initialValue: widget
                                                    .studentDetails
                                                    .currentProgramName,
                                                textStyle: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.colorc7e,
                                                    fontSize: 15.sp),
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
                                    )
                                  : const Padding(
                                      padding:
                                          EdgeInsets.only(top: 18.0, left: 18),
                                      child: ProgramDropdown(),
                                    ),
                              SizedBox(
                                height: 15.h,
                              ),
                              studentConsumer.selectedCourseIndex == false
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 18),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.colorWhite,
                                            border: Border.all(
                                                color: AppColors.colorc7e,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        height: 70.h,
                                        width: size.width * 0.2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppRichTextView(
                                                  title: "Current class",
                                                  textColor:
                                                      AppColors.colorBlack,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold),
                                              Expanded(
                                                  child: AppTextFormFieldWidget(
                                                enable: false,
                                                initialValue: widget
                                                            .studentDetails
                                                            .currentProgramId ==
                                                        300
                                                    ? widget.studentDetails
                                                        .rotationName
                                                    : widget.studentDetails
                                                        .currentClassName,
                                                textStyle: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.colorc7e,
                                                    fontSize: 15.sp),
                                                onSaved: (p0) {
                                                  // facultyProvider.setLastName(p0!);
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
                                    )
                                  : programConsumer.selectedDept == "300"
                                      ? Container()
                                      : const Padding(
                                          padding: EdgeInsets.only(left: 18),
                                          child: ClassDropdown(
                                            isUpdatingStudent: true,
                                          ),
                                        ),
                              SizedBox(
                                height: 15.h,
                              ),
                              studentConsumer.selectedCourseIndex == false
                                  ? Container()
                                  : programConsumer.selectedDept == "300"
                                      ? Container()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18),
                                          child: Column(
                                            children: [
                                              const DynamicYearsDropdown(),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              const BatchDropdown(
                                                isUpdatingStudent: true,
                                              ),
                                            ],
                                          ),
                                        ),
                              SizedBox(
                                height: 15.h,
                              ),
                              (studentConsumer.selectedCourseIndex == false ||
                                      programConsumer.selectedBatch == null)
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 18),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            activeColor: AppColors.colorc7e,
                                            value: commonConsumer.isChecked,
                                            onChanged: (bool? value) {
                                              commonConsumer.toggleCheckbox(
                                                  value ?? false);
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
                              Divider(
                                height: 3.h,
                                color: AppColors.colorc7e,
                                thickness: 3,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              studentConsumer.selectedCourseIndex == true &&
                                      programConsumer.selectedDept == "300"
                                  ? const ClinicalList()
                                  : studentConsumer.selectedCourseIndex ==
                                              true &&
                                          programConsumer.selectedBatch != null
                                      ? const CourseList()
                                      : Container(),
                              programConsumer.selectedBatch != null ||
                                      programConsumer.selectedDept == "300"
                                  ? registeredCourse.any((course) =>
                                              course.classId.toString() ==
                                              programConsumer.selectedClass) ==
                                          false
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: 15.w, bottom: 15.h),
                                          child: Row(
                                            children: [
                                              AppElevatedButon(
                                                loading:
                                                    studentConsumer.isLoading,
                                                title: "Update",
                                                buttonColor:
                                                    AppColors.colorWhite,
                                                height: 50.h,
                                                width: 150.w,
                                                onPressed: (context) async {
                                                  var token =
                                                      await getTokenAndUseIt();
                                                  if (token == null) {
                                                    if (context.mounted) {
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteNames.login);
                                                    }
                                                  } else if (token ==
                                                      "Token Expired") {
                                                    ToastHelper().errorToast(
                                                        "Session Expired Please Login Again");

                                                    if (context.mounted) {
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteNames.login);
                                                    }
                                                  } else {
                                                    if (programConsumer
                                                            .selectedDept ==
                                                        "300") {
                                                      var result =
                                                          await clincalConsumer
                                                              .postClinicalCourse(
                                                                  token,
                                                                  widget
                                                                      .studentDetails
                                                                      .iD);
                                                      if (result == 201) {
                                                        await studentConsumer
                                                            .getStudent(token);
                                                        if (context.mounted) {
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      }
                                                    } else {
                                                      if (selectedIDs.isEmpty) {
                                                        ToastHelper().errorToast(
                                                            "Please Select the Course");
                                                      } else {
                                                        var result = await studentConsumer.updateStudentClass(
                                                            token,
                                                            batch: programConsumer.selectedBatch,
                                                            selectedCourseList:
                                                                selectedIDs,
                                                            programId: int.parse(
                                                                programConsumer
                                                                    .selectedDept!),
                                                            classId: int.parse(
                                                                programConsumer
                                                                    .selectedClass!),
                                                            studentId: widget
                                                                .studentDetails
                                                                .iD,
                                                            currentClass:
                                                                commonConsumer
                                                                    .isChecked);
                                                        if (result != null) {
                                                          if (context.mounted) {
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
                                                },
                                                borderColor: AppColors.color582,
                                                textColor: AppColors.color582,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              AppElevatedButon(
                                                title: "Cancel",
                                                buttonColor:
                                                    AppColors.colorWhite,
                                                height: 50.h,
                                                width: 150.w,
                                                onPressed: (context) {},
                                                borderColor: AppColors.colorRed,
                                                textColor: AppColors.colorRed,
                                              )
                                            ],
                                          ),
                                        )
                                      : Container()
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                });
              }))
            ],
          );
        }),
      ),
    );
  }
}
