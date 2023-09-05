import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';
import 'package:rugst_alliance_academia/widgets/dummy_data.dart';
import 'package:scalable_data_table/scalable_data_table.dart';

class DepartmentView extends StatefulWidget {
  const DepartmentView({super.key});

  @override
  State<DepartmentView> createState() => _DepartmentViewState();
}

class _DepartmentViewState extends State<DepartmentView> {
  String? programValue;
  String? classValue;
  String? yearValue;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(18.0.sp),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppRichTextView(
                      title: "Program",
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    color: AppColors.color927,
                    height: 60.h,
                    width: size.width * 0.2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppRichTextView(
                              title: "Program",
                              textColor: AppColors.colorWhite,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                value: programValue,
                                items: <String>[
                                  'Pre-Medicines',
                                  'School of Medicines',
                                ]
                                    .map((String val) =>
                                        DropdownMenuItem<String>(
                                          value: val,
                                          child: Text(
                                            val,
                                            style: TextStyle(
                                              color: val == programValue
                                                  ? AppColors.colorWhite
                                                  : AppColors.color927,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                hint: const Text(
                                  'Please Select the Program',
                                  style: TextStyle(color: AppColors.colorWhite),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    programValue = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppRichTextView(
                      title: "Class",
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    color: AppColors.color927,
                    height: 60.h,
                    width: size.width * 0.2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppRichTextView(
                              title: "Class",
                              textColor: AppColors.colorWhite,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                value: classValue,
                                items: <String>[
                                  'MD1',
                                  'MD2',
                                  'MD3',
                                  "MD4",
                                  'MD5',
                                  'MD6',
                                  "MD7",
                                  "BMR"
                                ]
                                    .map((String val) =>
                                        DropdownMenuItem<String>(
                                          value: val,
                                          child: Text(
                                            val,
                                            style: TextStyle(
                                              color: val == classValue
                                                  ? AppColors.colorWhite
                                                  : AppColors.color927,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                hint: const Text(
                                  'Please Select the Class',
                                  style: TextStyle(color: AppColors.colorWhite),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    classValue = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppRichTextView(
                      title: "Year",
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    color: AppColors.color927,
                    height: 60.h,
                    width: size.width * 0.2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppRichTextView(
                              title: "Year",
                              textColor: AppColors.colorWhite,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                value: yearValue,
                                items: <String>[
                                  '2017',
                                  '2018',
                                  '2019',
                                  "2020",
                                  '2021',
                                  '2022',
                                  "2023",
                                ]
                                    .map((String val) =>
                                        DropdownMenuItem<String>(
                                          value: val,
                                          child: Text(
                                            val,
                                            style: TextStyle(
                                              color: val == yearValue
                                                  ? AppColors.colorWhite
                                                  : AppColors.color927,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                hint: const Text(
                                  'Please Select the Year',
                                  style: TextStyle(color: AppColors.colorWhite),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    yearValue = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  programValue == null
                      ? Container()
                      : AppRichTextView(
                          title: "Syllabus of $programValue",
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500),
                  SizedBox(
                    height: 10.h,
                  ),
                  programValue == null
                      ? Container()
                      : Expanded(
                          child: FutureBuilder<List<User>>(
                            future: createUsers(),
                            builder: (context, snapshot) => ScalableDataTable(
                              loadingBuilder: (p0) {
                                return SpinKitSpinningLines(
                                  color: AppColors.color927,
                                  size: 90.sp,
                                );
                              },
                              header: DefaultTextStyle(
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                                child: ScalableTableHeader(
                                  columnWrapper: columnWrapper,
                                  children: const [
                                    Text("Subject Code"),
                                    Text('Course Name'),
                                    Text('Credits'),
                                  ],
                                ),
                              ),
                              rowBuilder: (context, index) {
                                final user = snapshot.data![index];
                                return ScalableTableRow(
                                  columnWrapper: columnWrapper,
                                  color: MaterialStateColor.resolveWith(
                                      (states) => Colors.transparent),
                                  children: [
                                    Text('${user.index}.'),
                                    Text(user.name),
                                    Text(user.surname),
                                    const Icon(
                                      Icons.edit_outlined,
                                      color: AppColors.color927,
                                    ),
                                  ],
                                );
                              },
                              emptyBuilder: (context) =>
                                  const Text('No users yet...'),
                              itemCount: snapshot.data?.length ?? -1,
                              minWidth:
                                  500, // max(MediaQuery.of(context).size.width, 1000),
                              textStyle: TextStyle(
                                  color: Colors.grey[700], fontSize: 14),
                            ),
                          ),
                        ),
                  classValue == null || yearValue == null
                      ? Container()
                      : AppElevatedButon(
                          title: "Add New Course",
                          buttonColor: AppColors.color927,
                          height: 50.h,
                          width: 200.w,
                          onPressed: (context) {},
                          textColor: AppColors.colorWhite,
                        )
                ],
              ),
            ),
            const VerticalDivider(),
            Expanded(
                child: programValue == null
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: AppRichTextView(
                                title: "Current Students of $programValue",
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 400.w,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.sp)),
                                    elevation: 2.0,
                                    color: AppColors.color927,
                                    child: Container(
                                      height: 160.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.sp),
                                        color: AppColors.color927,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 40.sp,
                                              child: Center(
                                                child: AppRichTextView(
                                                  title: "PK",
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: AppColors.color927,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30.w,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppRichTextView(
                                                  title: "Name:Prabhakran",
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                                AppRichTextView(
                                                  title: "Class:MD-1",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                                AppRichTextView(
                                                  title: "Email: Prabhakaran",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                                AppRichTextView(
                                                  title: "Phone: +917305822599",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 400.w,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.sp)),
                                    elevation: 2.0,
                                    color: AppColors.color927,
                                    child: Container(
                                      height: 160.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.sp),
                                        color: AppColors.color927,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 40.sp,
                                              child: Center(
                                                child: AppRichTextView(
                                                  title: "PK",
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: AppColors.color927,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30.w,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppRichTextView(
                                                  title: "Name:Prabhakran",
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                                AppRichTextView(
                                                  title: "Class:MD-1",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                                AppRichTextView(
                                                  title: "Email: Prabhakaran",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                                AppRichTextView(
                                                  title: "Phone: +917305822599",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 400.w,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.sp)),
                                    elevation: 2.0,
                                    color: AppColors.color927,
                                    child: Container(
                                      height: 160.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.sp),
                                        color: AppColors.color927,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 40.sp,
                                              child: Center(
                                                child: AppRichTextView(
                                                  title: "PK",
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: AppColors.color927,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30.w,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppRichTextView(
                                                  title: "Name:Prabhakran",
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                                AppRichTextView(
                                                  title: "Class:MD-1",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                                AppRichTextView(
                                                  title: "Email: Prabhakaran",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                                AppRichTextView(
                                                  title: "Phone: +917305822599",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 400.w,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.sp)),
                                    elevation: 2.0,
                                    color: AppColors.color927,
                                    child: Container(
                                      height: 160.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.sp),
                                        color: AppColors.color927,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 40.sp,
                                              child: Center(
                                                child: AppRichTextView(
                                                  title: "PK",
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: AppColors.color927,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30.w,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppRichTextView(
                                                  title: "Name:Prabhakran",
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                                AppRichTextView(
                                                  title: "Class:MD-1",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                                AppRichTextView(
                                                  title: "Email: Prabhakaran",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                                AppRichTextView(
                                                  title: "Phone: +917305822599",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 400.w,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.sp)),
                                    elevation: 2.0,
                                    color: AppColors.color927,
                                    child: Container(
                                      height: 160.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.sp),
                                        color: AppColors.color927,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 40.sp,
                                              child: Center(
                                                child: AppRichTextView(
                                                  title: "PK",
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: AppColors.color927,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30.w,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppRichTextView(
                                                  title: "Name:Prabhakran",
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                                AppRichTextView(
                                                  title: "Class:MD-1",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                                AppRichTextView(
                                                  title: "Email: Prabhakaran",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                ),
                                                AppRichTextView(
                                                  title: "Phone: +917305822599",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                      AppColors.colorWhite,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ))
          ],
        ),
      ),
    );
  }

  Widget columnWrapper(BuildContext context, int columnIndex, Widget child) {
    const padding = EdgeInsets.symmetric(horizontal: 10);
    switch (columnIndex) {
      case 0:
        return Container(
          width: 160,
          padding: padding,
          child: child,
        );
      case 1:
        return Container(
          width: 160,
          padding: padding,
          child: child,
        );
      case 5:
        return Expanded(
          flex: 1,
          child: Container(
            padding: padding,
            child: child,
          ),
        );
      default:
        return Expanded(
          child: Container(
            padding: padding,
            child: child,
          ),
        );
    }
  }
}
