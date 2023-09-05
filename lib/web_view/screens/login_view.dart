import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebLoginView extends StatefulWidget {
  const WebLoginView({super.key});

  @override
  State<WebLoginView> createState() => _WebLoginViewState();
}

class _WebLoginViewState extends State<WebLoginView> {
  String? userName;
  String? password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        backgroundColor: AppColors.color3e3,
        title: AppRichTextView(
            title: "Alliance academia",
            textColor: AppColors.colorf85,
            fontSize: 45.sp,
            fontWeight: FontWeight.w400),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.h),
              height: size.height,
              width: size.width / 1.8,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(30.sp)),
                color: AppColors.color3e3,
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0.sp),
                child: Image.asset(
                  ImagePath.webLoginLogo,
                ),
              ),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 40.w, right: 40.w, top: 30.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppRichTextView(
                        title: "Login",
                        textColor: AppColors.colorf85,
                        fontSize: 45.sp,
                        fontWeight: FontWeight.w400),
                    AppRichTextView(
                        title: "Welcome to Our Web Portal",
                        textColor: AppColors.colorf85,
                        fontSize: 45.sp,
                        fontWeight: FontWeight.w600),
                    AppRichTextView(
                        maxLines: 2,
                        title:
                            "Thank you for get back to Univeristy Management System,\nlets access your account",
                        textColor: AppColors.colorGrey,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400),
                    SizedBox(
                      height: 30.h,
                    ),
                    AppTextFormFieldWidget(
                      onSaved: (p0) => userName = p0,
                      obscureText: false,
                      inputDecoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        label: AppRichTextView(
                            title: "Enter Username",
                            textColor: AppColors.colorBlack,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w400),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 25.0.h, horizontal: 10.0.w),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.sp),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.sp))),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppTextFormFieldWidget(
                      onSaved: (p0) => password = p0,
                      // textValidator: (value) {
                      //   // return PasswordFormFieldValidator.validate(value!);
                      // },
                      obscureText: true,
                      inputDecoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        label: AppRichTextView(
                            title: "Enter Password",
                            textColor: AppColors.colorBlack,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w400),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 25.0.h, horizontal: 10.0.w),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.sp))),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Center(
                      child: AppElevatedButon(
                        title: "Login",
                        buttonColor: AppColors.colorPurple,
                        height: 100.h,
                        width: size.width / 4,
                        onPressed: (context) async {
                          Navigator.pushNamed(context, RouteNames.welcome);
                          // if (_formKey.currentState!.validate()) {
                          //   _formKey.currentState!.save();
                          // }
                        },
                        textColor: AppColors.colorWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
