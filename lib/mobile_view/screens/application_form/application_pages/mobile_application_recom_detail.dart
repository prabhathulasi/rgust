import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_login_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_recommendation_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/util/validator.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MobileApplicationRecomDetail extends StatelessWidget {
  final PageController pageController;
  const MobileApplicationRecomDetail({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var size = MediaQuery.sizeOf(context);
    return Consumer<AdmissionRecommendationProvider>(
        builder: (context, admissionRecommendationConsumer, child) {
      return SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 18.w,vertical: 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(ImagePath.webrgustLogo,
                                  width: 80.h),
                              SizedBox(
                                width: 15.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppRichTextView(
                                      title:
                                          "Rajiv Gandhi University of Science and Technology"
                                           ,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold),
                                  AppRichTextView(
                                    textColor: AppColors.colorRed,
                                    title: "A Brand for Quality Eduation",
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppRichTextView(
                        title: "Recommendation Details",
                        textColor: AppColors.colorc7e,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    const Spacer(),
                    SizedBox(
                      width: size.width / 4,
                      child: LinearProgressIndicator(
                        backgroundColor: AppColors.colorGrey,
                        borderRadius: BorderRadius.circular(20.sp),
                        color: AppColors.colorc7e,
                        minHeight: 15.sp,
                        value: 0.8,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                AppRichTextView(
                    maxLines: 10,
                    title:
                        "Please provide the name, employment position, address, and phone number of the person who will be forwarding official letters of recommendation from your pre-medical course professors. These letters must be on original letterhead stationery and sent directly from the person at Rajiv Gandhi University of Science and Technology or sent along with your application.",
                    textColor: AppColors.colorBlack,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppRichTextView(
                              title: "Name",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppTextFormFieldWidget(
                            onSaved: (p0) => admissionRecommendationConsumer
                                .recommendationName = p0,
                            validator: (p0) =>
                                p0!.isEmpty ? "Name is required" : null,
                            obscureText: false,
                            inputDecoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.colorc7e, width: 2.w)),
                                hintText: "Name",
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 12.sp, color: AppColors.colorGrey)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppRichTextView(
                              title: "Profession",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppTextFormFieldWidget(
                            onSaved: (p0) => admissionRecommendationConsumer
                                .recommendationDesignation = p0,
                            validator: (p0) =>
                                p0!.isEmpty ? "Profession is required" : null,
                            obscureText: false,
                            inputDecoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.colorc7e, width: 2.w)),
                                hintText: "Profession",
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 12.sp, color: AppColors.colorGrey)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppRichTextView(
                              title: "Work Phone",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppTextFormFieldWidget(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onSaved: (p0) => admissionRecommendationConsumer
                                .recommendationPhone = p0,
                            validator: (p0) => MobileNumberValidator.validate(p0),
                            obscureText: false,
                            inputDecoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.colorc7e, width: 2.w)),
                                hintText: "Work Phone",
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 12.sp, color: AppColors.colorGrey)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppRichTextView(
                              title: "Email",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(
                            height: 10.h,
                          ),
                          AppTextFormFieldWidget(
                            onSaved: (p0) => admissionRecommendationConsumer
                                .recommendationEmail = p0,
                            validator: (p0) =>
                                EmailFormFieldValidator.validate(p0),
                            obscureText: false,
                            inputDecoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.colorc7e, width: 2.w)),
                                hintText: "Email",
                                hintStyle: GoogleFonts.roboto(
                                    fontSize: 12.sp, color: AppColors.colorGrey)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                AppRichTextView(
                    title: "Address",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: 10.h,
                ),
                AppTextFormFieldWidget(
                  onSaved: (p0) => admissionRecommendationConsumer.recommendationAddress = p0,
                  validator: (p0) => p0!.isEmpty ? "Address is required" : null,
                  maxLines: 4,
                  obscureText: false,
                  inputDecoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.colorc7e, width: 2.w)),
                      hintText: "Address",
                      hintStyle: GoogleFonts.roboto(
                          fontSize: 12.sp, color: AppColors.colorGrey)),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Center(
                  child: Consumer<AdmissionLoginProvider>(
                    builder: (context, admissionLoginConsumer, child) {
                      return AppElevatedButon(
                        title: "Save & Continue",
                        buttonColor: AppColors.colorc7e,
                        onPressed: (context) async {
                            var applicationId =
                                        admissionLoginConsumer.applicationId;
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            var response = await admissionRecommendationConsumer
                                .postAdmissionReferenceDetails(int.parse(applicationId!));
                            if (response.statusCode == 201) {
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.easeIn);
                            } else {
                              ToastHelper().errorToast(response.body.toString());
                            }
                          }
                        },
                        textColor: AppColors.colorWhite,
                        height: 50.h,
                        width: 200.w,
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
