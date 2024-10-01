import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendationForm extends StatelessWidget {
  final PageController pageController;
  const RecommendationForm({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppRichTextView(
                  title: "Recommendation Details",
                  textColor: AppColors.colorc7e,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold),
              SizedBox(
                width: size.width * 0.2,
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.colorGrey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.sp),
                  color: AppColors.colorc7e,
                  minHeight: 15.sp,
                  value: 0.8,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          AppRichTextView(
              maxLines: 3,
              title:
                  "Please provide the name, employment position, address, and phone number of the person who will be forwarding official letters of\nrecommendation from your pre-medical course professors. These letters must be on original letterhead stationery and sent directly from the\nperson at Rajiv Gandhi University of Science and Technology or sent along with your application.",
              textColor: AppColors.colorBlack,
              fontSize: size.width * 0.012,
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
                        title: "Member Position",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppTextFormFieldWidget(
                      obscureText: false,
                      inputDecoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.colorc7e, width: 2.w)),
                          hintText: "Member Position",
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
                        title: "College/ University",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppTextFormFieldWidget(
                      obscureText: false,
                      inputDecoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.colorc7e, width: 2.w)),
                          hintText: "College/ University",
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
              title: "Address", fontSize: 15.sp, fontWeight: FontWeight.bold),
          SizedBox(
            height: 10.h,
          ),
          AppTextFormFieldWidget(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppElevatedButon(
                borderColor: AppColors.colorc7e,
                title: "Back",
                buttonColor: AppColors.colorWhite,
                onPressed: (context) {
                  pageController.previousPage(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOut);
                },
                textColor: AppColors.colorc7e,
                height: 50.h,
                width: 120.w,
              ),
              AppElevatedButon(
                title: "Save & Continue",
                buttonColor: AppColors.colorc7e,
                onPressed: (context) async {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeIn);
                },
                textColor: AppColors.colorWhite,
                height: 50.h,
                width: 200.w,
              ),
            ],
          )
        ],
      ),
    );
  }
}
