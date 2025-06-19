import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/faculty_model.dart';
import 'package:rugst_alliance_academia/data/model/gender_model.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/department/batch_dropdown.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/department/class_dropdown.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/department/program_dropdown_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/department/year_dropdown_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/course_dropdown.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/gender_view.dart';

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

  List<JobType> jobType = [];
  List filterdcols = [];

  String? jobTypeValue;

  @override
  void initState() {
    jobType.add(JobType("Full-Time", false));
    jobType.add(JobType("Part-Time", false));
    jobType.add(JobType("Resigned", false));

    super.initState();
  }

  bool dropdownSelected = false;
  Uint8List? bytesFromPicker;
  String? imageEncoded;

  @override
  Widget build(BuildContext context) {
    TextEditingController dateinput =
        TextEditingController(text: widget.facultyDetail.joiningDate);
    TextEditingController dobinput =
        TextEditingController(text: widget.facultyDetail.dob);

    final programProvider = Provider.of<ProgramProvider>(context);
    final facultyProvider = Provider.of<FacultyProvider>(context);

    var size = MediaQuery.of(context).size;
    var facultyData = widget.facultyDetail;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(color: AppColors.colorWhite),
        child: Padding(
          padding: EdgeInsets.all(29.sp),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppRichTextView(
                          title: "Update Faculty",
                          textColor: AppColors.color446,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w700),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppRichTextView(
                                  title: "PROFILE IMAGE",
                                  textColor: AppColors.color446,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w800),
                              SizedBox(
                                height: 10.h,
                              ),
                              CircleAvatar(
                                backgroundColor: AppColors.color446,
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
                                  imageEncoded =
                                      base64.encode(bytesFromPicker!);

                                  setState(() {});
                                },
                                child: AppRichTextView(
                                    title: "Change Profile Image",
                                    textColor: AppColors.colorRed,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
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
                      SizedBox(
                        height: 10.h,
                      ),
                      AppRichTextView(
                        title: facultyData.firstName! + facultyData.lastName!,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.color446,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: "DOB:",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.colorBlack,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: facultyData.dob!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.color446,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: "Gender :",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.colorBlack,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: facultyData.gender!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.color446,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: "Mobile Number:",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.colorBlack,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: facultyData.mobile!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.color446,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: "Email Address:",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.colorBlack,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: facultyData.email!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.color446,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: "Job Type:",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.colorBlack,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: facultyData.jobType!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.color446,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: "Joining Date:",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.colorBlack,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: facultyData.joiningDate!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.color446,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Important
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: "Address",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.colorBlack,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              child: AppRichTextView(
                                maxLines: 5,
                                title: facultyData.address!,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.color446,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Important
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: "Qualification",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              textColor: AppColors.colorBlack,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              child: AppRichTextView(
                                maxLines: 5,
                                title: facultyData.qualifiation!,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.color446,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: [
                            AppElevatedButon(
                                title: "Update",
                                borderColor: AppColors.color446,
                                buttonColor: AppColors.colorWhite,
                                textColor: AppColors.color446,
                                height: 50.h,
                                width: 140.w,
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
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      var data = widget.facultyDetail;
                                      var result = await facultyProvider.updateFacultyDetails(token,
                                          updatedaddress: facultyProvider.address.isEmpty
                                              ? data.address!
                                              : facultyProvider
                                                  .addresscontroller!,
                                          updatedcitizenship: facultyProvider.cizizen.isEmpty
                                              ? data.citizenship!
                                              : facultyProvider
                                                  .citizenshipcontroller!,
                                          updatedemail: facultyProvider.email.isEmpty
                                              ? data.email!
                                              : facultyProvider
                                                  .emailcontroller!,
                                          updatedfirstName: facultyProvider.firstname.isEmpty
                                              ? data.firstName!
                                              : facultyProvider
                                                  .firstNamecontroller!,
                                          updatedlastName: facultyProvider.lastname.isEmpty
                                              ? data.lastName!
                                              : facultyProvider
                                                  .lastNamecontroller!,
                                          updatedmobile: facultyProvider.mobile.isEmpty
                                              ? data.mobile!
                                              : facultyProvider
                                                  .mobileController!,
                                          updatedpassportNumber:
                                              facultyProvider.passport.isEmpty
                                                  ? data.passportNumber!
                                                  : facultyProvider.passportcontroller!,
                                          updatedQualifiation: facultyProvider.qualification.isEmpty ? data.qualifiation! : facultyProvider.qualificationcontroller!,
                                          updatedfacultyId: data.facultyId!,
                                          updatedgender: data.gender!,
                                          updateddob: data.dob!,
                                          updatedjoiningDate: data.joiningDate!,
                                          updateduserImage: imageEncoded ?? data.userImage!,
                                          updatedjobType: facultyProvider.isjobTypeEdit == false ? data.jobType! : jobTypeValue!,
                                          id: data.iD!);

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
                              buttonColor: AppColors.colorWhite,
                              textColor: AppColors.colorRed,
                              borderColor: AppColors.colorRed,
                              height: 50.h,
                              width: 120.w,
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
              ),
              const VerticalDivider(),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppRichTextView(
                        title: "Update Faculty Details",
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.color446,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Form(
                        key: _formKey,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.color446,
                                            width: 3.w),
                                        borderRadius:
                                            BorderRadius.circular(8.sp)),
                                    height: 50.h,
                                    child: AppTextFormFieldWidget(
                                      initialValue:
                                          widget.facultyDetail.firstName,
                                      textStyle: GoogleFonts.roboto(
                                          color: AppColors.colorBlack),
                                      onSaved: (p0) {
                                        facultyProvider.setfirstName(p0!);
                                      },
                                      inputDecoration: const InputDecoration(
                                          labelText: "First Name",
                                          contentPadding: EdgeInsets.all(8),
                                          hintText: "First Name",
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.color446,
                                            width: 3.w),
                                        borderRadius:
                                            BorderRadius.circular(8.sp)),
                                    height: 50.h,
                                    child: AppTextFormFieldWidget(
                                      initialValue:
                                          widget.facultyDetail.lastName,
                                      textStyle: GoogleFonts.roboto(
                                          color: AppColors.colorBlack),
                                      onSaved: (p0) {
                                        facultyProvider.setLastName(p0!);
                                      },
                                      inputDecoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(8),
                                          hintText: "Last Name",
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.color446,
                                            width: 3.w),
                                        borderRadius:
                                            BorderRadius.circular(8.sp)),
                                    height: 50.h,
                                    child: AppTextFormFieldWidget(
                                      initialValue: widget.facultyDetail.email,
                                      textStyle: GoogleFonts.roboto(
                                          color: AppColors.colorBlack),
                                      validator: (value) {
                                        return EmailFormFieldValidator.validate(
                                            value);
                                      },
                                      onSaved: (p0) {
                                        facultyProvider.setemail(p0!);
                                      },
                                      inputDecoration: const InputDecoration(
                                          hintText: "Email",
                                          contentPadding: EdgeInsets.all(8),
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.color446,
                                            width: 3.w),
                                        borderRadius:
                                            BorderRadius.circular(8.sp)),
                                    height: 50.h,
                                    child: AppTextFormFieldWidget(
                                      initialValue: widget.facultyDetail.mobile,
                                      textStyle: GoogleFonts.roboto(
                                          color: AppColors.colorBlack),
                                      onSaved: (p0) {
                                        facultyProvider.setMobile(p0!);
                                      },
                                      inputDecoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(8),
                                          hintText: "Mobile Number",
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.color446,
                                            width: 3.w),
                                        borderRadius:
                                            BorderRadius.circular(8.sp)),
                                    height: 50.h,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "This DOB is Required";
                                        } else {
                                          return null;
                                        }
                                      },
                                      style: GoogleFonts.roboto(
                                          color: AppColors.colorBlack),
                                      controller: dobinput,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(8),
                                          hintStyle: GoogleFonts.roboto(
                                              color: AppColors.colorBlack),
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
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.color446,
                                            width: 3.w),
                                        borderRadius:
                                            BorderRadius.circular(8.sp)),
                                    height: 50.h,
                                    child: TextFormField(
                                      style: GoogleFonts.roboto(
                                          color: AppColors.colorBlack),
                                      controller: dateinput,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(8),
                                          hintStyle: GoogleFonts.roboto(
                                              color: AppColors.colorGrey),
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
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.color446,
                                            width: 3.w),
                                        borderRadius:
                                            BorderRadius.circular(8.sp)),
                                    height: 50.h,
                                    child: Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: GenderView(
                                          gender: widget.facultyDetail.gender!,
                                        )),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.color446,
                                            width: 3.w),
                                        borderRadius:
                                            BorderRadius.circular(8.sp)),
                                    height: 100.h,
                                    child: AppTextFormFieldWidget(
                                      maxLines: 5,
                                      initialValue:
                                          widget.facultyDetail.address,
                                      textStyle: GoogleFonts.roboto(
                                          color: AppColors.colorBlack),
                                      onSaved: (p0) {
                                        facultyProvider.setaddrss(p0!);
                                      },
                                      inputDecoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(8),
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.color446,
                                            width: 3.w),
                                        borderRadius:
                                            BorderRadius.circular(8.sp)),
                                    height: 100.h,
                                    child: AppTextFormFieldWidget(
                                      initialValue:
                                          widget.facultyDetail.qualifiation,
                                      textStyle: GoogleFonts.roboto(
                                          color: AppColors.colorBlack),
                                      onSaved: (p0) {
                                        facultyProvider.setqualification(p0!);
                                      },
                                      inputDecoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(8),
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.color446,
                                            width: 3.w),
                                        borderRadius:
                                            BorderRadius.circular(8.sp)),
                                    height: 50.h,
                                    child: AppTextFormFieldWidget(
                                      initialValue:
                                          widget.facultyDetail.passportNumber,
                                      textStyle: GoogleFonts.roboto(
                                          color: AppColors.colorBlack),
                                      onSaved: (p0) {
                                        facultyProvider.setpassport(p0!);
                                      },
                                      inputDecoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(8),
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.color446,
                                            width: 3.w),
                                        borderRadius:
                                            BorderRadius.circular(8.sp)),
                                    height: 50.h,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: facultyProvider.isjobTypeEdit ==
                                              false
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AppRichTextView(
                                                  title: widget
                                                      .facultyDetail.jobType!,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                  textColor:
                                                      AppColors.colorBlack,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    facultyProvider
                                                        .updateJobType(true);
                                                  },
                                                  child: Icon(
                                                    size: 20.sp,
                                                    Icons.edit_outlined,
                                                    color: AppColors.colorRed,
                                                  ),
                                                )
                                              ],
                                            )
                                          : Align(
                                              alignment: Alignment.topLeft,
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
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.color446,
                                            width: 3.w),
                                        borderRadius:
                                            BorderRadius.circular(8.sp)),
                                    height: 50.h,
                                    child: AppTextFormFieldWidget(
                                      initialValue:
                                          widget.facultyDetail.citizenship,
                                      textStyle: GoogleFonts.roboto(
                                          color: AppColors.colorBlack),
                                      onSaved: (p0) {
                                        facultyProvider.setcitizen(p0!);
                                      },
                                      inputDecoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(8),
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: AppColors.colorGrey)),
                                      obscureText: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            // ignore: prefer_const_constructors
                            Expanded(flex: 1, child: const FacultyCourseList())

                            // Row(
                            //   crossAxisAlignment:
                            //       CrossAxisAlignment.start,
                            //   children: [
                            //     facultyProvider.selectedCourseIndex ==
                            //             index
                            //         ? const Padding(
                            //             padding: EdgeInsets.all(8.0),
                            //             child: ClassDropdown(
                            //               isUpdatingStudent: true,
                            //             ),
                            //           )
                            //         : Padding(
                            //             padding:
                            //                 EdgeInsets.all(8.0.sp),
                            //             child: Container(
                            //               color: AppColors.colorc7e,
                            //               height: 70.h,
                            //               width: size.width * 0.2,
                            //               child: Padding(
                            //                 padding: EdgeInsets.all(
                            //                     8.0.sp),
                            //                 child: Column(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment
                            //                           .start,
                            //                   children: [
                            //                     AppRichTextView(
                            //                         title:
                            //                             "Class Name",
                            //                         textColor: AppColors
                            //                             .colorWhite,
                            //                         fontSize: 14.sp,
                            //                         fontWeight:
                            //                             FontWeight
                            //                                 .w500),
                            //                     AppRichTextView(
                            //                         title:
                            //                             registeredCourseList
                            //                                 .className!,
                            //                         textColor: AppColors
                            //                             .colorWhite,
                            //                         fontSize: 14.sp,
                            //                         fontWeight:
                            //                             FontWeight
                            //                                 .w800),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //   ],
                            // ),
                            // Row(
                            //   crossAxisAlignment:
                            //       CrossAxisAlignment.start,
                            //   children: [
                            //     facultyProvider.selectedCourseIndex ==
                            //             index
                            //         ? const Padding(
                            //             padding: EdgeInsets.all(8.0),
                            //             child: DynamicYearsDropdown(),
                            //           )
                            //         : Padding(
                            //             padding:
                            //                 EdgeInsets.all(8.0.sp),
                            //             child: Container(
                            //               color: AppColors.colorc7e,
                            //               height: 70.h,
                            //               width: size.width * 0.2,
                            //               child: Padding(
                            //                 padding: EdgeInsets.all(
                            //                     8.0.sp),
                            //                 child: Column(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment
                            //                           .start,
                            //                   children: [
                            //                     AppRichTextView(
                            //                         title: "Year",
                            //                         textColor: AppColors
                            //                             .colorWhite,
                            //                         fontSize: 14.sp,
                            //                         fontWeight:
                            //                             FontWeight
                            //                                 .w500),
                            //                     AppRichTextView(
                            //                         title: DateTime.parse(
                            //                                 registeredCourseList
                            //                                     .updatedAt!)
                            //                             .year
                            //                             .toString(),
                            //                         textColor: AppColors
                            //                             .colorWhite,
                            //                         fontSize: 14.sp,
                            //                         fontWeight:
                            //                             FontWeight
                            //                                 .w800),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //   ],
                            // ),
                            // Row(
                            //   crossAxisAlignment:
                            //       CrossAxisAlignment.start,
                            //   children: [
                            //     facultyProvider.selectedCourseIndex ==
                            //             index
                            //         ? const Padding(
                            //             padding: EdgeInsets.all(8.0),
                            //             child: BatchDropdown(
                            //               isUpdatingStudent: true,
                            //             ),
                            //           )
                            //         : Padding(
                            //             padding:
                            //                 EdgeInsets.all(8.0.sp),
                            //             child: Container(
                            //               color: AppColors.colorc7e,
                            //               height: 70.h,
                            //               width: size.width * 0.2,
                            //               child: Padding(
                            //                 padding: EdgeInsets.all(
                            //                     8.0.sp),
                            //                 child: Column(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment
                            //                           .start,
                            //                   children: [
                            //                     AppRichTextView(
                            //                         title: "Batch",
                            //                         textColor: AppColors
                            //                             .colorWhite,
                            //                         fontSize: 14.sp,
                            //                         fontWeight:
                            //                             FontWeight
                            //                                 .w500),
                            //                     AppRichTextView(
                            //                         title:
                            //                             registeredCourseList
                            //                                 .batch!,
                            //                         textColor: AppColors
                            //                             .colorWhite,
                            //                         fontSize: 14.sp,
                            //                         fontWeight:
                            //                             FontWeight
                            //                                 .w800),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //   ],
                            // ),
                            // Row(
                            //   crossAxisAlignment:
                            //       CrossAxisAlignment.start,
                            //   children: [
                            //     facultyProvider.selectedCourseIndex ==
                            //             index
                            //         ? Padding(
                            //             padding:
                            //                 const EdgeInsets.all(8.0),
                            //             //  child:programProvider.selectedBatch == null? Container(): const CourseDropDown(),
                            //           )
                            //         : Padding(
                            //             padding:
                            //                 EdgeInsets.all(8.0.sp),
                            //             child: Container(
                            //               color: AppColors.colorc7e,
                            //               height: 70.h,
                            //               width: size.width * 0.2,
                            //               child: Padding(
                            //                 padding: EdgeInsets.all(
                            //                     8.0.sp),
                            //                 child: Column(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment
                            //                           .start,
                            //                   children: [
                            //                     AppRichTextView(
                            //                         title:
                            //                             "Course Name",
                            //                         textColor: AppColors
                            //                             .colorWhite,
                            //                         fontSize: 14.sp,
                            //                         fontWeight:
                            //                             FontWeight
                            //                                 .w500),
                            //                     AppRichTextView(
                            //                         title: registeredCourseList
                            //                             .courseName!,
                            //                         textColor: AppColors
                            //                             .colorWhite,
                            //                         fontSize: 14.sp,
                            //                         fontWeight:
                            //                             FontWeight
                            //                                 .w800),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
