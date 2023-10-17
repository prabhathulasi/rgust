import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/web_view/screens/faculty/faculty_list_view.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class FacultyAccountCreationView extends StatelessWidget {
 const  FacultyAccountCreationView({super.key});
  
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String? password;
    String? userName;
  showCreateAccountDialogue(BuildContext context, String email) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width / 4,
         height: MediaQuery.sizeOf(context).height / 2.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AppRichTextView(
                    title: "Create Account",
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold),
 SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.colorc7e,
                      borderRadius: BorderRadius.circular(18.sp)),
                  child: AppTextFormFieldWidget(
              
                    textStyle: GoogleFonts.roboto(
                      color: AppColors.colorWhite,
                    ),
                    validator: (value) {
                      if(value== null){
                        return "UserName is Required";
                      }else{
                         return null;
                      }


                      
                    },
                  onSaved: (p0) => userName = p0,
                    obscureText: false,
                    inputDecoration: InputDecoration(
                        errorStyle: GoogleFonts.oswald(
                            color: AppColors.colorRed,
                            fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Enter UserName",
                        hintStyle:
                            GoogleFonts.oswald(color: AppColors.colorWhite),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 25.0.h, horizontal: 10.0.w),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.colorc7e,
                      borderRadius: BorderRadius.circular(18.sp)),
                  child: AppTextFormFieldWidget(
                    enable: false,
                    textStyle: GoogleFonts.roboto(
                      color: AppColors.colorWhite,
                    ),
                    // validator: (value) {
                    //   return EmailFormFieldValidator.validate(value!);
                    // },
                    // onSaved: (p0) => userName = p0,
                    obscureText: false,
                    inputDecoration: InputDecoration(
                        errorStyle: GoogleFonts.oswald(
                            color: AppColors.colorRed,
                            fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: email,
                        hintStyle:
                            GoogleFonts.oswald(color: AppColors.colorWhite),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 25.0.h, horizontal: 10.0.w),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.colorc7e,
                      borderRadius: BorderRadius.circular(18.sp)),
                  child: AppTextFormFieldWidget(
                    textStyle: GoogleFonts.oswald(
                      color: AppColors.colorWhite,
                    ),
                    onSaved: (p0) => password = p0,
                    validator: (value) {
                      return PasswordFormFieldValidator.validate(value!);
                    },
                    obscureText: true,
                    inputDecoration: InputDecoration(
                      errorStyle: GoogleFonts.oswald(
                          color: AppColors.colorRed,
                          fontWeight: FontWeight.bold),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Enter Password",
                      hintStyle:
                          GoogleFonts.oswald(color: AppColors.colorWhite),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 25.0.h, horizontal: 10.0.w),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Consumer<FacultyProvider>(
                        builder: (context, facultyProvider, child) {
                      return AppElevatedButon(
                        title: "Create",
                        buttonColor: AppColors.colorc7e,
                        height: 50.h,
                        width: 120.w,
                        textColor: AppColors.colorWhite,
                        onPressed: (context) async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            var token = await getTokenAndUseIt();
                            if (token == null) {
                              if (context.mounted) {
                                Navigator.pushNamed(context, RouteNames.login);
                              }
                            } else if (token == "Token Expired") {
                              ToastHelper().errorToast(
                                  "Session Expired Please Login Again");

                              if (context.mounted) {
                                Navigator.pushNamed(context, RouteNames.login);
                              }
                            } else {
                              var result = await facultyProvider.createAccount(
                                  token,
                                 email,
                                  password!,
                                  userName!
                                 );
                              if (result != null) {
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              }
                            }
                          }
                        },
                      );
                    }),
                    SizedBox(
                      width: 10.w,
                    ),
                    AppElevatedButon(
                      title: "cancel",
                      buttonColor: AppColors.colorc7e,
                      height: 50.h,
                      width: 120.w,
                      textColor: AppColors.colorWhite,
                      onPressed: (context) {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
        final facultyProvider =
        Provider.of<FacultyProvider>(context, listen: false);
      Future getFacultyList() async {
      var token = await getTokenAndUseIt();
      if (token == null) {
        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }
      } else if (token == "Token Expired") {
        ToastHelper().errorToast("Session Expired Please Login Again");

        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }
      } else {
        var result = await facultyProvider.getFaculty(token);
         if(result =="Invalid Token"){
           ToastHelper().errorToast("Session Expired Please Login Again");
           if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }}
      }
    }
    return FutureBuilder(
          future: getFacultyList(),
          builder: (context, snapshot) {
    
             if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitSpinningLines(
                  color: AppColors.colorc7e,
                  size: 60.sp,
                ),
              );
            } else{
              return facultyProvider.facultyModel.facultyList == null
                  ? Center(
                      child: Column(
                      children: [
                        Expanded(child: Image.asset(ImagePath.webNoDataLogo)),
                        AppElevatedButon(
                          title: "Add New Faculty",
                          buttonColor: AppColors.colorc7e,
                          height: 50.h,
                          width: 200.w,
                          onPressed: (context) {
                            showAddAlertDialog(context);
                          },
                          textColor: AppColors.colorWhite,
                        )
                      ],
                    ))
                  : Consumer<FacultyProvider>(
                    builder: (context,facultyListProvider,child) {
                      return ListView.builder(
                        itemCount: facultyListProvider.facultyModel.facultyList!.where((element) => element.accountCreated == false).length,
                        itemBuilder: (context, index) {
                         var data= facultyListProvider.facultyModel.facultyList![index];
                          return Card(
                            elevation: 10.0,
                            child: Container(
                              height: 200.h,
                              color: AppColors.colorc7e,
                 child:Padding(
                       padding: const EdgeInsets.all(18.0),
                       child: Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                             backgroundImage: MemoryImage(base64Decode(data.userImage!)),
                          ),
                          SizedBox(width: 15.w,),
                          Expanded(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                 AppRichTextView(
                                          title: data.firstName!.toUpperCase() + data.lastName!.toUpperCase(),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorWhite,
                                        ),
                                        SizedBox(height: 10.h,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Icon(Icons.mail,color: AppColors.colorWhite,),
                                            SizedBox(width: 5.w,),
                                            const Icon(Icons.phone,color: AppColors.colorWhite,)
                                          ],
                                        ),
                                         SizedBox(height: 10.h,),
                                        AppElevatedButon(title: "Create",
                                        textColor: AppColors.colorc7e,
                                        
                                        borderColor: AppColors.colorGreen,
                                        buttonColor: AppColors.color0ec,
                                        height: 50.h,
                                        width: 100.w,
                                        onPressed: (context) {
                                          showCreateAccountDialogue(context,data.email!);
                                        },
                                        )
                              ],
                            ),
                          )
                        ],
                       ),
                 ) ,
                              
                            ),
                          );
                        },
                      );
                    }
                  );
            }
          });
  }
}