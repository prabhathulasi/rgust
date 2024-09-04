import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';

import 'package:rugst_alliance_academia/data/model/gender_model.dart';
import 'package:rugst_alliance_academia/data/provider/staff_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_radiobutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddStaffView extends StatefulWidget {
  const AddStaffView({super.key});

  @override
  State<AddStaffView> createState() => _AddFacultyViewState();
}

class _AddFacultyViewState extends State<AddStaffView> {
  final _formKey = GlobalKey<FormState>();
  List<Gender> genders = [];
  List<JobType> jobType = [];

  String? genderValue;
  String? jobTypeValue;

  String? randomString;

  @override
  void initState() {
    genders.add(Gender("Male", false));
    genders.add(Gender("Female", false));
    jobType.add(JobType("Full-Time", false));
    jobType.add(JobType("Part-Time", false));

    setState(() {
      randomString = generateRandomString(4);
    });
    super.initState();
  }

  String generateRandomString(int length) {
    const String chars = '0123456789';
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
     final staffProvider = Provider.of<StaffProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          color: AppColors.color0ec,
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(29.sp),
              child: Column(
                children: [
                  Center(
                    child: AppRichTextView(
                        title: "Add New Staff",
                        textColor: AppColors.colorc7e,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700),
                  ),
               
                  Center(
                    child: AppRichTextView(
                        title: "PROFILE IMAGE",
                        textColor: AppColors.colorc7e,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: CircleAvatar(
                        backgroundColor: AppColors.colorc7e,
                        radius: 60.sp,
                        backgroundImage: imageEncoded == null
                            ? const AssetImage(ImagePath.webfacultyfLogo)
                            : MemoryImage(bytesFromPicker!) as ImageProvider),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () async {
                      bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
                      imageEncoded = base64.encode(bytesFromPicker!);
              
                      setState(() {});
                    },
                    child: AppRichTextView(
                        title: "Change Profile Image",
                        textColor: AppColors.color582,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  Expanded(
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Staff Id",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                        child: AppTextFormFieldWidget(
                                          
                                          enable: false,
                                          textStyle:  TextStyle(
                                              color: AppColors.colorWhite,fontSize: 15.sp),
                                          onSaved: (p0) {},
                                          inputDecoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Rgust-028-$randomString",
                                              hintStyle: const TextStyle(
                                                  color: AppColors.colorGrey)),
                                          obscureText: false,
                                        ),
                                      ),
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
                                  padding: EdgeInsets.all(8.0.sp),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "First Name",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite,fontSize: 15.sp),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This FirstName is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (p0) {
                                          staffProvider.setfirstName(p0!);
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Last Name",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite, fontSize: 15.sp),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This LastName is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (p0) {
                                          staffProvider.setLastName(p0!);
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Email Address",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite, fontSize: 15.sp),
                                        validator: (value) {
                                          return EmailFormFieldValidator.validate(
                                              value);
                                        },
                                        onSaved: (p0) {
                                          staffProvider.setemail(p0!);
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Mobile Number",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite, fontSize: 15.sp),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This MobileNumber is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (p0) {
                                          staffProvider.setMobile(p0!);
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "DOB",
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
                                              color: AppColors.colorWhite,fontSize: 15.sp),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Starts On",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "This StartOn is Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          style: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,fontSize: 15.sp),
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
                                                    firstDate: DateTime(2010), //- not to allow to choose before today.
                                                    lastDate: DateTime.now() );
                                                        
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
                              Expanded(
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
                                            title: "Desigination",
                                            textColor: AppColors.colorWhite,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                        Expanded(
                                            child: AppTextFormFieldWidget(
                                          textStyle: GoogleFonts.roboto(
                                              color: AppColors.colorWhite,fontSize: 15.sp),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "This Desigination is Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onSaved: (p0) {
                                            staffProvider.setDesignation(p0!);
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
                                height: 95.h,
                                width: size.width * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                            padding:
                                                const EdgeInsets.only(left: 8.0),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Address",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite, fontSize: 15.sp),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This Address is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (p0) {
                                          staffProvider.setaddrss(p0!);
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Education qualification",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite, fontSize: 15.sp),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This Qualification is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (p0) {
                                          staffProvider.setqualification(p0!);
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Passport Number",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite, fontSize: 15.sp),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This PassportNumber is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (p0) {
                                          staffProvider.setpassport(p0!);
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
                                height: 95.h,
                                width: size.width * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                            padding:
                                                const EdgeInsets.only(left: 8.0),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                          title: "Citizenship",
                                          textColor: AppColors.colorWhite,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                      Expanded(
                                          child: AppTextFormFieldWidget(
                                        textStyle: GoogleFonts.roboto(
                                            color: AppColors.colorWhite, fontSize: 15.sp),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This Citizenship is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (p0) {
                                          staffProvider.setcitizen(p0!);
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
                
                 
                ],
              ),
            ),
            const VerticalDivider(),
            Expanded(child: Column(
              children: [
                Lottie.asset(LottiePath.uploadLottie,width: 600.w),
                 Expanded(
                   child: Row(
                      children: [
                        AppElevatedButon(
                            borderColor: AppColors.colorWhite,
                            title: "Hand in",
                            buttonColor: AppColors.colorc7e,
                            textColor: AppColors.colorWhite,
                            height: 50.h,
                            width: 160.w,
                            loading: staffProvider.isLoading,
                            onPressed: (context) async {
                              if (imageEncoded == null) {
                                ToastHelper().errorToast(
                                   "Please Select the User Image");
                              } else if (genderValue == null) {
                              ToastHelper().errorToast("Please Select the Gender");
                              } else if (jobTypeValue == null) {
                             ToastHelper().errorToast( "Please Select the job type");
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
                                }
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    var result = await staffProvider.createStaff(
                                        token,
                                      
                                        staffId:
                                            "Rgust-028-$randomString",
                                        gender: genderValue!,
                                        dob: dobinput.text,
                                        joiningDate: dateinput.text,
                                        userImage: imageEncoded!,
                                        jobType: jobTypeValue!);
                    

                                    if (result != null) {
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  }
                                }
                              }
                            ),
                        SizedBox(
                          width: 10.h,
                        ),
                        AppElevatedButon(
                          borderColor: AppColors.colorWhite,
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
            ))
          ],
        ),
      ),
    );
  }
}
