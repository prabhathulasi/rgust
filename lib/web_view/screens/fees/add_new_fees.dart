import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class AddNewFees extends StatefulWidget {
  const AddNewFees({super.key});

  @override
  State<AddNewFees> createState() => _AddNewFeesState();
}
String ? feesName;
int? semCount1;
int? tutionFee1;
int? semCount2;
int? tutionFee2;
int? semCount3;
int? tutionFee3;

int ? premedNstudentfee;
int? premedNonetimeFee;
int? premedNappFee;
int? premedNmatFee;
int ? premedNseatFee;
int? premedNinsuranceFee;
int ? premedNexamFee;
int ? preClinicalNstudentfee;
int? preClinicalNonetimeFee;
int? preClinicalNappFee;
int? preClinicalNmatFee;
int ? preClinicalNseatFee;
int? preClinicalNinsuranceFee;
int ? preClinicalNexamFee;
int ? clinicalNstudentfee;
int? clinicalNonetimeFee;
int? clinicalNappFee;
int? clinicalNmatFee;
int ? clinicalNseatFee;
int? clinicalNinsuranceFee;
int ? clinicalNexamFee;


int ? premedInstudentfee;
int? premedInonetimeFee;
int? premedInappFee;
int? premedInmatFee;
int ? premedInseatFee;
int? premedIninsuranceFee;
int ? premedInexamFee;
int ? preClinicalInstudentfee;
int? preClinicalInonetimeFee;
int? preClinicalInappFee;
int? preClinicalInmatFee;
int ? preClinicalInseatFee;
int? preClinicalIninsuranceFee;
int ? preClinicalInexamFee;
int ? clinicalInstudentfee;
int? clinicalInonetimeFee;
int? clinicalInappFee;
int? clinicalInmatFee;
int ? clinicalInseatFee;
int? clinicalIninsuranceFee;
int ? clinicalInexamFee;
int ? visaFee;
 final _formKey = GlobalKey<FormState>();
class _AddNewFeesState extends State<AddNewFees> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: AppRichTextView(
                    title: "Add New Fees Structure",
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.colorc7e,
                  )),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppRichTextView(
                    title: "Doctor of Medicine Degree Program (5½ Years)",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.colorc7e,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Fees Type",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => feesName = newValue,
                            decoration: InputDecoration(
                                hintText: "Standard",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Pre-Med:",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => semCount1 = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "No of Semester",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => tutionFee1 = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Tuition cost per Semester( US\$)",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Basic Sciences:",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => semCount2 = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "No of Semester",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => tutionFee2 = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Tuition cost per Semester( US\$)",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Clinical Sciences:",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => semCount3 = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "No of Semester",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => tutionFee3 = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Tuition cost per Semester( US\$)",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const Divider(),
                  AppRichTextView(
                    title:
                        "National Students: Miscellaneous Fees (Per Semester US\$)",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.colorc7e,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Student Government Fee",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => premedNstudentfee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre- Medicine",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => preClinicalNstudentfee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre-Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => clinicalNstudentfee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "One-Time Registration Fee",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => premedNonetimeFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre- Medicine",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => preClinicalNonetimeFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre-Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => clinicalNonetimeFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                   SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Application Fee",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => premedNappFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre- Medicine",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => preClinicalNappFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre-Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => clinicalNappFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                   SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Matriculation Fee",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => premedNmatFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre- Medicine",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => preClinicalNmatFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre-Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => clinicalNmatFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                   SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Seat Deposit Fee",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => premedNseatFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre- Medicine",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => preClinicalNseatFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre-Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => clinicalNseatFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                   SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Health Insurance",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => premedNinsuranceFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre- Medicine",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => preClinicalNinsuranceFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre-Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) =>clinicalNinsuranceFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Examination Fee",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => premedNexamFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre- Medicine",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => preClinicalNexamFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre-Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => clinicalNexamFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
      
      
                  SizedBox(
                    height: 20.h,
                  ),
                  const Divider(),
                  AppRichTextView(
                    title:
                        "InterNational Students: Miscellaneous Fees (Per Semester US\$)",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.colorc7e,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Student Government Fee",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => premedInstudentfee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre- Medicine",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => preClinicalInstudentfee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre-Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => clinicalInstudentfee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "One-Time Registration Fee",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => premedInonetimeFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre- Medicine",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => preClinicalInonetimeFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre-Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => clinicalInonetimeFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                   SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Application Fee",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => premedInappFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre- Medicine",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => preClinicalInappFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre-Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => clinicalInappFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                   SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Matriculation Fee",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => premedInmatFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre- Medicine",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => preClinicalInmatFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre-Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => clinicalInmatFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                   SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Seat Deposit Fee",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => premedInseatFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre- Medicine",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => preClinicalInseatFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre-Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => clinicalInseatFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                   SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Health Insurance",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => premedIninsuranceFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre- Medicine",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => preClinicalIninsuranceFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre-Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => clinicalIninsuranceFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Examination Fee",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => premedInexamFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre- Medicine",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => preClinicalInexamFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Pre-Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.15,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => clinicalInexamFee = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Clinicals",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          ))
                    ],
                  ),
                   SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      AppRichTextView(
                        title: "Visa Fee",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.colorBlack,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                          height: 70.h,
                          width: size.width * 0.1,
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return "This Field is Required";
                              }else{
                                 return null;
                              }
                            },
                            onSaved: (newValue) => visaFee  = int.parse(newValue!),
                            decoration: InputDecoration(
                                hintText: "Visa Fee",
                                hintStyle: TextStyle(fontSize: 15.sp)),
                          )),
                    
                      
                    ],
                  ),
                  SizedBox(height: 20.h,),

                  AppElevatedButon(title: "Submit",
                  borderColor: AppColors.colorWhite,
                  buttonColor: AppColors.colorc7e,
                  height: 50.h,
                  width: 150.w,
                  textColor: AppColors.colorWhite,
                  onPressed: (context) {
                    Map bodydata ={
                   "FeesList":   [

                      
               {       
"FeesType":feesName,
"ProgramName":"Pre-Medicine",
"SemCount":semCount1,
"Year":DateTime.now().year,
"TutionFee":tutionFee1,
"ProgramId":100
               },
                  {       
"FeesType":feesName,
"ProgramName":"Basic Sciences",
"SemCount":semCount2,
"Year":DateTime.now().year,
"TutionFee":tutionFee2,
"ProgramId":200
               },
               {       
"FeesType":feesName,
"ProgramName":"Clinical Sciences",
"SemCount":semCount3,
"Year":DateTime.now().year,
"TutionFee":tutionFee3,
"ProgramId":300
               }
                      
                    ],
                     "Miscellaneous Fees":[
 {       
"Detail":"Student Government Fee",
"IsNational":false,
"ProgramId":100,
"MiscFee":premedNstudentfee

               },
                {       
"Detail":"Student Government Fee",
"IsNational":false,
"ProgramId":100,
"MiscFee":premedNonetimeFee

               },
                {       
"Detail":"Student Government Fee",
"IsNational":false,
"ProgramId":100,
"MiscFee":premedNappFee

               },
                    ]
                    };
                  },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
