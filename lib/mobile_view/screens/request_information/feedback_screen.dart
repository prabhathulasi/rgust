import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rugst_alliance_academia/routes/app_router.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MobileFeedbackScreen extends StatefulWidget {
  const MobileFeedbackScreen({super.key});

  @override
  State<MobileFeedbackScreen> createState() => _MobileFeedbackScreenState();
}

class _MobileFeedbackScreenState extends State<MobileFeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.colorPurple,
          title: const AppRichTextView(
            title: "FeedBack",
            fontSize: 20,
            fontWeight: FontWeight.w400,
            textColor: AppColors.colorWhite,
          ),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.sp)),
                child: SizedBox(
                  height: 100.h,
                  width: size.width,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.colorPurple,
                          radius: 30.sp,
                          child: AppRichTextView(
                            title: "T",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppRichTextView(
                              title: "Dr.Tom",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.colorBlack,
                            ),
                            AppRichTextView(
                              textColor: AppColors.colorGrey,
                              title: "Neurology and Health Science",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            AppRichTextView(
                              textColor: AppColors.colorBlack,
                              title: "Campus Check in Time: 9:00AM",
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 2.0,
                      child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Column(children: [
                          AppRichTextView(
                            title: "Class Start Time",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.colorBlack,
                          ),
                          AppRichTextView(
                            textColor: AppColors.colorBlack,
                            title: "10:00AM",
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 2.0,
                      child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Column(children: [
                          AppRichTextView(
                            title: "Class End Time",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.colorBlack,
                          ),
                          AppRichTextView(
                            maxLines: 2,
                            textColor: AppColors.colorBlack,
                            title: "12:00PM",
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.w),
              child: AppRichTextView(
                textColor: AppColors.colorBlack,
                title: "Students",
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Card(
                      color: AppColors.colorWhite,
                      child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: AppRichTextView(
                          textColor: AppColors.colorGreen,
                          fontSize: 15.sp,
                          title: "Studnet1",
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                  Card(
                      color: AppColors.colorWhite,
                      child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: AppRichTextView(
                          textColor: AppColors.colorGreen,
                          fontSize: 15.sp,
                          title: "Studnet2",
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                  Card(
                      color: AppColors.colorWhite,
                      child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: AppRichTextView(
                          textColor: AppColors.colorGreen,
                          fontSize: 15.sp,
                          title: "Studnet3",
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                  Card(
                      color: AppColors.colorWhite,
                      child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: AppRichTextView(
                          textColor: AppColors.colorGreen,
                          fontSize: 15.sp,
                          title: "Studnet4",
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                  Card(
                      color: AppColors.colorWhite,
                      child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: AppRichTextView(
                          textColor: AppColors.colorRed,
                          fontSize: 15.sp,
                          title: "Studnet6",
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 15.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.w),
              child: const AppRichTextView(
                textColor: AppColors.colorBlack,
                title: "Comment",
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: AppTextFormFieldWidget(
                maxLines: 8,
                textStyle: GoogleFonts.oswald(
                    color: AppColors.colorPurple, fontSize: 15.sp),
                inputDecoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Comments",
                    hintStyle: GoogleFonts.oswald(
                        color: AppColors.colorGrey, fontSize: 15.sp)),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
          ]),
        ),
        persistentFooterButtons: [
          Center(
            child: AppElevatedButon(
              title: "Submit",
              buttonColor: AppColors.colorPurple,
              textColor: AppColors.colorWhite,
              onPressed: (context) {
                Navigator.of(context).push(AppRouter.mobileLogin());
              },
              height: 35.h,
              width: 160.w,
            ),
          ),
        ]);
  }
}
