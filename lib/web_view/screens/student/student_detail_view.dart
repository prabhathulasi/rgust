import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:calendar_view/calendar_view.dart';

class StudentDetailView extends StatefulWidget {
  const StudentDetailView({super.key});

  @override
  State<StudentDetailView> createState() => _StudentDetailViewState();
}

class _StudentDetailViewState extends State<StudentDetailView> {
  @override
  Widget build(BuildContext context) {
    final event = CalendarEventData(
      title: "Anatomy-1",
      date: DateTime(2023, 8, 26),
    );
    // final List<CalendarEventData> events = [
    //   CalendarEventData(
    //       title: "Anatomy-1", date: DateTime(2023, 8, 26), event: "event1"),
    //   CalendarEventData(
    //       date: DateTime(2023, 8, 26), title: "Anatomy-2", event: "event2"),
    //   // Add more events as needed
    // ];

    CalendarControllerProvider.of(context).controller.add(event);
    // CalendarControllerProvider.of(context).controller.add(event2);
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.color927,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.sp)),
                    elevation: 1.0,
                    child: Container(
                      height: 400.h,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.sp)),
                      child: Padding(
                        padding: EdgeInsets.all(18.0.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40.h,
                                  width: 12.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.color927,
                                      borderRadius:
                                          BorderRadius.circular(10.sp)),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                AppRichTextView(
                                    title: "Student Details",
                                    textColor: AppColors.color927,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w700),
                                const Spacer(),
                                const Icon(
                                  Icons.edit_outlined,
                                  color: AppColors.color927,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 45.sp,
                                  child: Center(
                                    child: AppRichTextView(
                                        title: "K",
                                        textColor: AppColors.color927,
                                        fontSize: 35.sp,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppRichTextView(
                                        title: "Prabhakaran Thulasi",
                                        textColor: AppColors.color927,
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.w700),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppRichTextView(
                                                title: "Class",
                                                textColor: AppColors.colorGrey,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w500),
                                            AppRichTextView(
                                                title: "MD-1",
                                                textColor: AppColors.color927,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w700),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 60.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppRichTextView(
                                                title: "Phone Number",
                                                textColor: AppColors.colorGrey,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w500),
                                            AppRichTextView(
                                                title: "+917305822599",
                                                textColor: AppColors.color927,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w700),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 60.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppRichTextView(
                                                title: "Email Address",
                                                textColor: AppColors.colorGrey,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w500),
                                            AppRichTextView(
                                                title: "Prabha709@gmail.com",
                                                textColor: AppColors.color927,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w700),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 30.h),
                            Row(
                              children: [
                                Card(
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                  child: SizedBox(
                                    height: 100.h,
                                    child: Padding(
                                      padding: EdgeInsets.all(18.0.sp),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            ImagePath.webattendanceLogo,
                                            width: 50.w,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 8.0.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppRichTextView(
                                                    title: "302",
                                                    textColor:
                                                        AppColors.color927,
                                                    fontSize: 20.sp,
                                                    fontWeight:
                                                        FontWeight.w800),
                                                AppRichTextView(
                                                    title: "Total Attendance",
                                                    textColor:
                                                        AppColors.colorGrey,
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                  child: SizedBox(
                                    height: 100.h,
                                    child: Padding(
                                      padding: EdgeInsets.all(18.0.sp),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            ImagePath.webcheckInLogo,
                                            width: 50.w,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 8.0.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppRichTextView(
                                                    title: "8:42 AM",
                                                    textColor:
                                                        AppColors.color927,
                                                    fontSize: 20.sp,
                                                    fontWeight:
                                                        FontWeight.w800),
                                                AppRichTextView(
                                                    title:
                                                        "Averge Check In Time",
                                                    textColor:
                                                        AppColors.colorGrey,
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                  child: SizedBox(
                                    height: 100.h,
                                    child: Padding(
                                      padding: EdgeInsets.all(18.0.sp),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            ImagePath.webcheckOutLogo,
                                            width: 50.w,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 8.0.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppRichTextView(
                                                    title: "5:00 PM",
                                                    textColor:
                                                        AppColors.color927,
                                                    fontSize: 20.sp,
                                                    fontWeight:
                                                        FontWeight.w800),
                                                AppRichTextView(
                                                    title:
                                                        "Averge Check In Time",
                                                    textColor:
                                                        AppColors.colorGrey,
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
                child: Row(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.sp)),
                      child: Container(
                        height: size.height * 0.6,
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.sp)),
                        child: Padding(
                          padding: EdgeInsets.all(18.0.sp),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 12.w,
                                    decoration: BoxDecoration(
                                        color: AppColors.color927,
                                        borderRadius:
                                            BorderRadius.circular(10.sp)),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  AppRichTextView(
                                      title: "Campus In Out History",
                                      textColor: AppColors.color927,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w700),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Expanded(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: 18,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 2.5,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 4.0),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      elevation: 2.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                      ),
                                      child: SizedBox(
                                        height: 120.h,
                                        width: 250.w,
                                        child: Padding(
                                          padding: EdgeInsets.all(18.0.sp),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons.timer_outlined),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  AppRichTextView(
                                                      title: "March 07 2023",
                                                      textColor:
                                                          AppColors.color927,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                  const Spacer(),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .colorGreen
                                                            .shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.sp)),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          8.0.sp),
                                                      child: AppRichTextView(
                                                          title: "On Time",
                                                          textColor: AppColors
                                                              .colorGreen,
                                                          fontSize: 8.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      AppRichTextView(
                                                          title:
                                                              "Check In Time",
                                                          textColor: AppColors
                                                              .color927,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      AppRichTextView(
                                                          title: "8:00 AM",
                                                          textColor: AppColors
                                                              .color927,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      AppRichTextView(
                                                          title:
                                                              "Check Out Time",
                                                          textColor: AppColors
                                                              .color927,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      AppRichTextView(
                                                          title: "4:00 PM",
                                                          textColor: AppColors
                                                              .color927,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.sp)),
                        child: SizedBox(
                          height: size.height * 0.6,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(18.0.sp),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40.h,
                                      width: 12.w,
                                      decoration: BoxDecoration(
                                          color: AppColors.color927,
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    AppRichTextView(
                                        title: "Leave request",
                                        textColor: AppColors.color927,
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.w700),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Center(
                                child: Image.asset(
                                  ImagePath.webExitLogo,
                                  width: 300.w,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              AppRichTextView(
                                  title: "No Leave request",
                                  textColor: AppColors.color927,
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w700),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
