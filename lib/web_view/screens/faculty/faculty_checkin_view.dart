import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class FacultyCheckInView extends StatefulWidget {
  const FacultyCheckInView({super.key});

  @override
  State<FacultyCheckInView> createState() => _FacultyCheckInViewState();
}

class _FacultyCheckInViewState extends State<FacultyCheckInView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width,
        color: AppColors.colorc7e,
        child: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppRichTextView(
                title: "Campus In Out History",
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                textColor: AppColors.colorWhite,
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 126.h,
                width: 250.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: AppColors.colorWhite),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time_rounded),
                          SizedBox(
                            width: 10.w,
                          ),
                          AppRichTextView(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            title: "October 09 2023",
                            textColor: AppColors.colorBlack,
                          ),
                          const Spacer(),
                          Container(
                              decoration: const BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: AppColors.color582,
                                    blurRadius:10,
                                    spreadRadius: 2)
                              ]),
                              child: Icon(
                                Icons.circle,
                                size: 10.sp,
                                color: AppColors.color582,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        Column(
                          children: [
                             AppRichTextView(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              title: "CheckIn Time",
                              textColor: AppColors.colorBlack,
                            ),
                            AppRichTextView(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              title: "8.00AM",
                              textColor: AppColors.colorBlack,
                            ),
                          ],
                        ),
                         Column(
                          children: [
                             AppRichTextView(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              title: "CheckIn Out",
                              textColor: AppColors.colorBlack,
                            ),
                            AppRichTextView(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              title: "5.00PM",
                              textColor: AppColors.colorBlack,
                            ),
                          ],
                        )
                      ],),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
