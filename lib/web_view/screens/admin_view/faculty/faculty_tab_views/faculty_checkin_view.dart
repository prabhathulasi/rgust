import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class FacultyCheckInView extends StatefulWidget {
  final int facultyId;
  const FacultyCheckInView({super.key, required this.facultyId});

  @override
  State<FacultyCheckInView> createState() => _FacultyCheckInViewState();
}

class _FacultyCheckInViewState extends State<FacultyCheckInView> {
  getAttendanceList() async {
    var facultyProvider = Provider.of<FacultyProvider>(context, listen: false);

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
      var result =
          await facultyProvider.getAttendanceList(token, widget.facultyId);

      if (result == "Invalid Token") {
        ToastHelper().errorToast("Session Expired Please Login Again");
        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAttendanceList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Consumer<FacultyProvider>(
                builder: (context, facultyProvider, child) {
              if (facultyProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (facultyProvider.attendanceModel.sessions == null) {
                  return const Center(child: Text("No Checkin Data Found"));
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ListView.builder(
                              itemCount: facultyProvider
                                  .attendanceModel.sessions?.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Card(
                                    child: ListTile(
                                  isThreeLine: true,
                                  leading:
                                      const Icon(Icons.access_time_rounded),
                                  title: AppRichTextView(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    title: DateFormat.yMMMEd().format(
                                        DateTime.parse(facultyProvider
                                            .attendanceModel
                                            .sessions![index]
                                            .startTime
                                            .toString())),
                                    textColor: AppColors.colorBlack,
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          AppRichTextView(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                            title: "In Time",
                                            textColor: AppColors.colorGreen,
                                          ),
                                          AppRichTextView(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            title: DateFormat('jm').format(
                                                DateTime.parse(facultyProvider
                                                    .attendanceModel
                                                    .sessions![index]
                                                    .startTime!)),
                                            textColor: AppColors.colorBlack,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 20.w),
                                      Column(
                                        children: [
                                          AppRichTextView(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                            title: "Out Time",
                                            textColor: AppColors.colorRed,
                                          ),
                                          facultyProvider
                                                          .attendanceModel
                                                          .sessions![index]
                                                          .endTime ==
                                                      null ||
                                                  facultyProvider
                                                          .attendanceModel
                                                          .sessions![index]
                                                          .endTime ==
                                                      ""
                                              ? Container()
                                              : AppRichTextView(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                  title: DateFormat('jm')
                                                      .format(DateTime.parse(
                                                          facultyProvider
                                                              .attendanceModel
                                                              .sessions![index]
                                                              .endTime!
                                                              .toString())),
                                                  textColor:
                                                      AppColors.colorBlack,
                                                ),
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                              }),
                        ),
                      ),
                      const VerticalDivider(),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            AppRichTextView(
                              title: "Sort By",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.color446,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppRichTextView(
                                        title: "Start Date",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        textColor: AppColors.color446,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      TextFormField(
                                        readOnly: true, // <<<<< ADD THIS
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This DOB is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        style: GoogleFonts.roboto(
                                            color: AppColors.colorBlack,
                                            fontSize: 15.sp),
                                        controller: facultyProvider.startDate,
                                        decoration: InputDecoration(
                                            hintText: "Enter Start Date",
                                            hintStyle: GoogleFonts.roboto(
                                                color: AppColors.color446),
                                            border: const OutlineInputBorder()),
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  builder:
                                                      (BuildContext context,
                                                          Widget? child) {
                                                    return Theme(
                                                      data: ThemeData.light()
                                                          .copyWith(
                                                        primaryColor:
                                                            AppColors.color446,
                                                        colorScheme:
                                                            const ColorScheme
                                                                    .light()
                                                                .copyWith(
                                                          primary: AppColors
                                                              .color446,
                                                        ),
                                                        buttonTheme:
                                                            const ButtonThemeData(
                                                                textTheme:
                                                                    ButtonTextTheme
                                                                        .primary),
                                                      ),
                                                      child: child!,
                                                    );
                                                  },
                                                  barrierDismissible: false,
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2025),
                                                  lastDate:
                                                      DateTime(2025 + 20));

                                          if (pickedDate != null) {
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);

                                            facultyProvider
                                                .setStartDate(formattedDate);
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      
                                      AppRichTextView(
                                        title: "End Date",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        textColor: AppColors.color446,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      TextFormField(
                                        readOnly: true, // <<<<< ADD THIS
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This DOB is Required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        style: GoogleFonts.roboto(
                                            color: AppColors.colorBlack,
                                            fontSize: 15.sp),
                                        controller: facultyProvider.endDate,
                                        decoration: InputDecoration(
                                            hintText: "Enter End Date",
                                            hintStyle: GoogleFonts.roboto(
                                                color: AppColors.color446),
                                            border: const OutlineInputBorder()),
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.parse(
                                                      facultyProvider
                                                          .startDate.text),
                                                  firstDate: DateTime.parse(
                                                      facultyProvider
                                                          .startDate.text),
                                                  lastDate:
                                                      DateTime(2025 + 20));

                                          if (pickedDate != null) {
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                            facultyProvider
                                                .setEndDate(formattedDate);
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                    ],
                  );
                }
              }
            });
          }
        });
  }
}
