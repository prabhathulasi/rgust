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
import 'package:rugst_alliance_academia/data/provider/faculty_provider.dart';
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
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            color: AppColors.color0ec,),
         
        child: Padding(
          padding: EdgeInsets.all(29.sp),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                            backgroundImage:
                             imageEncoded == null
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
                        width: 15.w,
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
                                        initialValue:
                                            widget.facultyDetail.firstName,
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite),
                                      
                                       
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
                                        initialValue:
                                            widget.facultyDetail.lastName,
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite),
                                     
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
                                        initialValue:
                                            widget.facultyDetail.email,
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
                                        initialValue:
                                            widget.facultyDetail.mobile,
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite),
                               
                                     
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
                                child:  Padding(
                                  padding: EdgeInsets.all(8.0.sp),
                                  child: GenderView(gender: widget.facultyDetail.gender!,)
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
                                        initialValue:
                                            widget.facultyDetail.address,
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite),
                                     
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
                                        initialValue:
                                            widget.facultyDetail.qualifiation,
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite),
                                      
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
                                        initialValue:
                                            widget.facultyDetail.passportNumber,
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite),
                                      
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
                                      facultyProvider.isjobTypeEdit == false? Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppRichTextView(
                                              title:
                                                  widget.facultyDetail.jobType!,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.color0ec,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                facultyProvider.updateJobType(true);
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                color: AppColors.color0ec,
                                              ),
                                            )
                                          ],
                                        ),
                                      ):
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
                                        initialValue:
                                            widget.facultyDetail.citizenship,
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite),
                                       
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
                            }else{
                              if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                           var data = widget.facultyDetail;
                                  var result = await facultyProvider.updateFacultyDetails(token, 
                              updatedaddress: facultyProvider.address.isEmpty ? data.address! : facultyProvider.addresscontroller!,
                              updatedcitizenship: facultyProvider.cizizen.isEmpty ? data.citizenship!: facultyProvider.citizenshipcontroller!,
                              updatedemail: facultyProvider.email.isEmpty? data.email!:facultyProvider.emailcontroller!,
                              updatedfirstName: facultyProvider.firstname.isEmpty? data.firstName!: facultyProvider.firstNamecontroller!,
                              updatedlastName: facultyProvider.lastname.isEmpty? data.lastName!: facultyProvider.lastNamecontroller!,
                              updatedmobile: facultyProvider.mobile.isEmpty? data.mobile!: facultyProvider.mobileController!,
                              updatedpassportNumber: facultyProvider.passport.isEmpty? data.passportNumber!: facultyProvider.passportcontroller!,
                              updatedQualifiation: facultyProvider.qualification.isEmpty? data.qualifiation!: facultyProvider.qualificationcontroller! ,
                              updatedfacultyId: data.facultyId!, 
                              updatedgender: data.gender!, 
                              updateddob: data.dob!, 
                              updatedjoiningDate: data.joiningDate!, 
                              updateduserImage: data.userImage!, 
                              updatedjobType: facultyProvider.isjobTypeEdit == false? data.jobType!:jobTypeValue!, 
                              id: data.iD!);

                                     if(result!=null && context.mounted) {
                                      
                                      Navigator.pop(context);
                                    
                                     }
                                    }
                                  
                      
                       

                           
                            }
                            
                            }
                            ),
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
                child: Column(
                  children: [
                    AppRichTextView(title: "Registered Course", fontSize: 25.sp, fontWeight: FontWeight.bold,textColor: AppColors.colorc7e,),
                    SizedBox(height: 10.h,),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.facultyDetail.registeredCourse!.length,
                        itemBuilder: (context, index) {
                          var registeredCourseList = widget.facultyDetail.registeredCourse![index];
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  facultyProvider.selectedCourseIndex == index?const ProgramDropdown(): Padding(
                                     padding:  EdgeInsets.all(8.0.sp),
                                     child: Container(
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
                                                  title: "Program Name",
                                                  textColor: AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                                     Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                       children: [
                                                         AppRichTextView(
                                                  title: registeredCourseList.programName!,
                                                  textColor: AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w800),
                                                  InkWell(
                                                    onTap: () {
                                                    facultyProvider.selectCourseIndex(index);
                                                    },
                                                    child: Icon(
                                                      
                                                      Icons.edit,size: 15.sp,color: AppColors.colorWhite)),
                                                       ],
                                                     ),
                                             
                                            ],
                                          ),
                                        ),
                                      ),
                                   ),
                                ],
                              ),

                               Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    facultyProvider.selectedCourseIndex == index? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: ClassDropdown(isUpdatingStudent: true,),
                                    ): Padding(
                                     padding:  EdgeInsets.all(8.0.sp),
                                     child: Container(
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
                                                  title: "Class Name",
                                                  textColor: AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                                     AppRichTextView(
                                                  title: registeredCourseList.className!,
                                                  textColor: AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w800),
                                             
                                            ],
                                          ),
                                        ),
                                      ),
                                   ),
                                ],
                              ),
                               Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  facultyProvider.selectedCourseIndex == index? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: DynamicYearsDropdown(),
                                  ): Padding(
                                     padding:  EdgeInsets.all(8.0.sp),
                                     child: Container(
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
                                                  title: "Year",
                                                  textColor: AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                                     AppRichTextView(
                                                  title: DateTime.parse(registeredCourseList.updatedAt!).year.toString(),
                                                  textColor: AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w800),
                                             
                                            ],
                                          ),
                                        ),
                                      ),
                                   ),
                                ],
                              ),
                               Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                facultyProvider.selectedCourseIndex == index? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: BatchDropdown(isUpdatingStudent: true,),
                                ):   Padding(
                                     padding:  EdgeInsets.all(8.0.sp),
                                     child: Container(
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
                                                  title: "Batch",
                                                  textColor: AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                                     AppRichTextView(
                                                  title:registeredCourseList.batch!,
                                                  textColor: AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w800),
                                             
                                            ],
                                          ),
                                        ),
                                      ),
                                   ),
                                ],
                              ),
                               Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   facultyProvider.selectedCourseIndex == index?  Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child:programProvider.selectedBatch == null? Container(): const CourseDropDown(),
                                   ):Padding(
                                     padding:  EdgeInsets.all(8.0.sp),
                                     child: Container(
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
                                                  title: "Course Name",
                                                  textColor: AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                                     AppRichTextView(
                                                  title: registeredCourseList.courseName!,
                                                  textColor: AppColors.colorWhite,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w800),
                                             
                                            ],
                                          ),
                                        ),
                                      ),
                                   ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    )

                   
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
