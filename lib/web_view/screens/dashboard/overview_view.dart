import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
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
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 300.sp,
                width: size.width,
                color: AppColors.color927,
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
                            textColor: AppColors.color927,
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
                      const Spacer(),
                      Container(
                        width: 180.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.colorWhite,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0.w),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: classValue,

                              items: <String>[
                                'All Classes',
                                'MD1',
                                'MD2',
                                'MD3',
                                'MD4'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: value == classValue
                                          ? AppColors.colorWhite
                                          : AppColors.color927,
                                    ),
                                  ),
                                );
                              }).toList(),
                              // Step 5.
                              onChanged: (String? newValue) {
                                setState(() {
                                  classValue = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      SizedBox(
                          height: 35.h,
                          child: AppElevatedButon(
                            title: "Filter",
                            buttonColor: AppColors.color582,
                            height: 50.h,
                            width: 100.w,
                            onPressed: (context) {},
                            textColor: AppColors.colorWhite,
                          ))
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(38.w, 220.h),
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
                            size: 60.sp,
                            color: AppColors.color582,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppRichTextView(
                                title: "47",
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w600,
                                textColor: AppColors.color927,
                              ),
                              AppRichTextView(
                                title: "Total Students",
                                fontSize: 25.sp,
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
              Transform.translate(
                offset: Offset(400.w, 220.h),
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
                            size: 60.sp,
                            color: AppColors.color582,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppRichTextView(
                                title: "27",
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w600,
                                textColor: AppColors.color927,
                              ),
                              AppRichTextView(
                                title: "Total Faculties",
                                fontSize: 25.sp,
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
              Transform.translate(
                offset: Offset(760.w, 220.h),
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
                            size: 60.sp,
                            color: AppColors.color582,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppRichTextView(
                                title: "2",
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w600,
                                textColor: AppColors.color927,
                              ),
                              AppRichTextView(
                                title: "Absent Today",
                                fontSize: 25.sp,
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
              Transform.translate(
                offset: Offset(1120.w, 220.h),
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
                            FontAwesomeIcons.businessTime,
                            size: 60.sp,
                            color: AppColors.color582,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppRichTextView(
                                title: "2",
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w600,
                                textColor: AppColors.color927,
                              ),
                              AppRichTextView(
                                title: "Late Today",
                                fontSize: 25.sp,
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
          SizedBox(
            height: 100.h,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 38.0.w),
                child: Card(
                  elevation: 4.0,
                  child: SizedBox(
                    height: 450.h,
                    width: 400.w,
                    // color: Colors.amber,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0.w),
                          child: AppRichTextView(
                            title: "Students by Class",
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.color927,
                          ),
                        ),
                        Expanded(child: AppBarChart()),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 38.0.w),
                child: Card(
                  elevation: 4.0,
                  child: SizedBox(
                    height: 450.h,
                    width: 400.w,
                    // color: Colors.amber,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0.w),
                          child: AppRichTextView(
                            title: "Students by Gender",
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.color927,
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
                                backgroundColor: AppColors.color927,
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
                                offset: Offset(-40, 90),
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
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  color: AppColors.color927,
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
                              textColor: AppColors.color927,
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
                              textColor: AppColors.color927,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 38.0.w),
                child: Card(
                  elevation: 4.0,
                  child: SizedBox(
                    height: 450.h,
                    width: 400.w,
                    // color: Colors.amber,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0.w),
                          child: AppRichTextView(
                            title: "Top 6 Attendant",
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.color927,
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(),
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
                                      textColor: AppColors.color927,
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
          )
        ],
      ),
    );
  }
}
