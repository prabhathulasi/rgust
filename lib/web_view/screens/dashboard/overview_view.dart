import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_linechart.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class OverviewView extends StatefulWidget {
  const OverviewView({super.key});

  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {
  String classValue = "All Classes";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context,constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 300.h ,
                    width: constraints.maxWidth,
                    color: AppColors.colorc7e,
                    child: Padding(
                      padding: EdgeInsets.only(left: 38.0.w, right: 20.w),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40.sp,
                            child: Center(
                              child: AppRichTextView(
                                title: "P",
                                fontSize: 35.sp,
                                textColor: AppColors.colorc7e,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppRichTextView(
                                title: "Hello Prabha! 👋",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                                textColor: AppColors.colorWhite,
                              ),
                              AppRichTextView(
                                title: "We hope you're having a great day.",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w300,
                                textColor: AppColors.colorWhite,
                              ),
                            ],
                          ),
                      
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform.translate(
                      offset: Offset(0,220.h),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.sp)),
                            child: Container(
                              height: 150.h,
                              width: 310.w,
                              decoration: BoxDecoration(
                             color: AppColors.colorWhite,
                             borderRadius: BorderRadius.circular(15.sp)),
                              child: Padding(
                                padding: EdgeInsets.only(left: 35.0.w),
                                child: Row(
                             children: [
                               FaIcon(
                                 FontAwesomeIcons.userGraduate,
                                 size: 40.sp,
                                 color: AppColors.color582,
                               ),
                               SizedBox(
                                 width: 10.w,
                               ),
                               Expanded(
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     AppRichTextView(
                                       title: "47",
                                       fontSize: 30.sp,
                                       fontWeight: FontWeight.bold,
                                       textColor: AppColors.colorc7e,
                                     ),
                                     AppRichTextView(
                                       title: "Total Students",
                                       fontSize: 20.sp,
                                       fontWeight: FontWeight.w400,
                                       textColor: AppColors.colorGrey,
                                     ),
                                   ],
                                 ),
                               )
                             ],
                                ),
                              ),
                            ),
                                              ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Card(
                                                elevation: 4.0,
                                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.sp)),
                                                child: Container(
                            height: 150.h,
                            width: 310.w,
                            decoration: BoxDecoration(
                                color: AppColors.colorWhite,
                                borderRadius: BorderRadius.circular(15.sp)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 35.0.w),
                              child: Row(
                                children: [
                             FaIcon(
                               FontAwesomeIcons.chalkboardUser,
                               size: 40.sp,
                               color: AppColors.color582,
                             ),
                             SizedBox(
                               width: 10.w,
                             ),
                             Expanded(
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   AppRichTextView(
                                     title: "27",
                                     fontSize: 30.sp,
                                     fontWeight: FontWeight.bold,
                                     textColor: AppColors.colorc7e,
                                   ),
                                   AppRichTextView(
                                     title: "Total Faculties",
                                     fontSize: 20.sp,
                                     fontWeight: FontWeight.w400,
                                     textColor: AppColors.colorGrey,
                                   ),
                                 ],
                               ),
                             )
                                ],
                              ),
                            ),
                                                ),
                                              ),
                          ),
                      Expanded(
                        flex: 1,
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.sp)),
                          child: Container(
                            height: 150.h,
                            width: 310.w,
                            decoration: BoxDecoration(
                                color: AppColors.colorWhite,
                                borderRadius: BorderRadius.circular(15.sp)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 35.0.w),
                              child: Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.faceSadTear,
                                    size: 40.sp,
                                    color: AppColors.color582,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                        title: "2",
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorc7e,
                                      ),
                                      AppRichTextView(
                                        title: "Absent Today",
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w400,
                                        textColor: AppColors.colorGrey,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    
                        ],
                      ),
                    ),
                  )

          
                ],
              ),
              SizedBox(
                height: 100.h,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 38.0.w),
                        child: Card(
                          elevation: 4.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0.w),
                                child: AppRichTextView(
                                  title: "Students by Class",
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w600,
                                  textColor: AppColors.colorc7e,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: AppBarChart()),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 38.0.w),
                        child: Card(
                          elevation: 4.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0.w),
                                child: AppRichTextView(
                                  title: "Students by Gender",
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w600,
                                  textColor: AppColors.colorc7e,
                                ),
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              Center(
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundColor: AppColors.colorc7e,
                                      child: Center(
                                        child: AppRichTextView(
                                          title: "45%",
                                          fontSize: 25.sp,
                                          fontWeight: FontWeight.w700,
                                          textColor: AppColors.colorWhite,
                                        ),
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: const Offset(-40, 90),
                                      child: CircleAvatar(
                                        radius: 70,
                                        backgroundColor: AppColors.color582,
                                        child: Center(
                                          child: AppRichTextView(
                                            title: "55%",
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.w700,
                                            textColor: AppColors.colorWhite,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 110.h,
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 10.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                        color: AppColors.colorc7e,
                                        borderRadius: BorderRadius.circular(5.sp)),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  AppRichTextView(
                                    title: "Male",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    textColor: AppColors.colorGrey,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  AppRichTextView(
                                    title: "25",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    textColor: AppColors.colorc7e,
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Container(
                                    height: 10.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                        color: AppColors.color582,
                                        borderRadius: BorderRadius.circular(5.sp)),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  AppRichTextView(
                                    title: "Female",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    textColor: AppColors.colorGrey,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  AppRichTextView(
                                    title: "22",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    textColor: AppColors.colorc7e,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 38.0.w),
                        child: Card(
                          elevation: 4.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0.w),
                                child: AppRichTextView(
                                  title: "Top 6 Attendant",
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w600,
                                  textColor: AppColors.colorc7e,
                                ),
                              ),
                              Expanded(
                                  child: ListView.builder(
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      leading: const CircleAvatar(),
                                      trailing: AppRichTextView(
                                        title: "30 Days",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        textColor: AppColors.colorBlack,
                                      ),
                                      title: Row(
                                        children: [
                                          AppRichTextView(
                                            title: "Prabhakaran",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            textColor: AppColors.colorc7e,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.colorGrey,
                                                borderRadius:
                                                    BorderRadius.circular(8.sp)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: AppRichTextView(
                                                title: "100%",
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600,
                                                textColor: AppColors.colorBlack,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,)
            ],
          );
        }
      ),
    );
  }
}
