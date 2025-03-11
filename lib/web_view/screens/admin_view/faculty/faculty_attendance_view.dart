import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/faculty_model.dart';
import 'package:rugst_alliance_academia/data/provider/timesheet_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class FacultyAttendanceView extends StatefulWidget {
  final FacultyList facultyDetail;
  const FacultyAttendanceView({super.key, required this.facultyDetail});

  @override
  State<FacultyAttendanceView> createState() => _FacultyAttendanceViewState();
}

class _FacultyAttendanceViewState extends State<FacultyAttendanceView> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final timeSheetProvider =
        Provider.of<TimeSheetProvider>(context, listen: false);
    getEventsList() async {
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
        var result = await timeSheetProvider.getFacultyAttendance(
            widget.facultyDetail.userId!, token);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    return FutureBuilder(
        future: getEventsList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitSpinningLines(color: AppColors.colorWhite),
            );
          } else {
            return SfCalendar(
              onTap: (calendarTapDetails) {
                if (calendarTapDetails.appointments!.isEmpty) {
                  Container();
                } else if (calendarTapDetails.appointments!.length == 1) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: AppColors.colorWhite,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                              color: AppColors.colorc7e,
                              height: 150.h,
                              width: 300.w,
                              child: Column(
                                children: [
                                  Expanded(
                                      child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        calendarTapDetails.appointments!.length,
                                    itemBuilder: (context, index) {
                                      return Text(calendarTapDetails
                                          .appointments![index].eventName);
                                    },
                                  ))
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        DateTime now = calendarTapDetails.appointments![0].from;
                        String formattedDate =
                            DateFormat('EEE, MMM d, ' 'yyyy').format(now);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Dialog(
                              backgroundColor: AppColors.colorWhite,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  color: AppColors.colorc7e,
                                  height: 377.h,
                                  width: 328.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AppRichTextView(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          title: formattedDate,
                                          textColor: AppColors.colorWhite,
                                        ),
                                      ),
                                      Expanded(
                                          child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: calendarTapDetails
                                            .appointments!.length,
                                        itemBuilder: (context, index) {
                                          DateTime startTime =
                                              calendarTapDetails
                                                  .appointments![index].from;
                                          String startformattedtime =
                                              DateFormat('h:mm a')
                                                  .format(startTime);
                                          DateTime endTime = calendarTapDetails
                                              .appointments![index].to;
                                          String endformattedtime =
                                              DateFormat('h:mm a')
                                                  .format(endTime);
                                          return InkWell(
                                            onTap: () {},
                                            child: Card(
                                              child: ListTile(
                                                title: AppRichTextView(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    textColor:
                                                        AppColors.colorc7e,
                                                    title: calendarTapDetails
                                                        .appointments![index]
                                                        .eventName),
                                                subtitle: Row(
                                                  children: [
                                                    AppRichTextView(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        textColor:
                                                            AppColors.colorGrey,
                                                        title: "Lecturer: "),
                                                    AppRichTextView(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        textColor:
                                                            AppColors.colorc7e,
                                                        title: widget
                                                            .facultyDetail
                                                            .firstName!)
                                                  ],
                                                ),
                                                trailing: Column(
                                                  children: [
                                                    AppRichTextView(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        textColor:
                                                            AppColors.colorc7e,
                                                        title:
                                                            "Starts:$startformattedtime"),
                                                    AppRichTextView(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        textColor:
                                                            AppColors.colorc7e,
                                                        title:
                                                            "Ends:$endformattedtime"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: 230,
                              height: 464.h,
                              color: Colors.red,
                            ),
                          ],
                        );
                      });
                }
              },
              showNavigationArrow: true,
              todayHighlightColor: AppColors.color582,
              dataSource: MeetingDataSource(timeSheetProvider.getDataSource()),
              allowAppointmentResize: true,
              view: CalendarView.month,
              cellEndPadding: 15,
              cellBorderColor: AppColors.colorWhite,
              viewHeaderStyle: ViewHeaderStyle(
                dayTextStyle: GoogleFonts.roboto(color: AppColors.colorWhite),
              ),
              headerStyle: CalendarHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: GoogleFonts.roboto(color: AppColors.colorWhite)),
              monthViewSettings: MonthViewSettings(
                  appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                  // showAgenda: true,

                  agendaStyle: AgendaStyle(
                    backgroundColor: AppColors.colorc7e,
                    appointmentTextStyle:
                        GoogleFonts.roboto(color: AppColors.colorBlack),
                    dateTextStyle:
                        GoogleFonts.roboto(color: AppColors.colorWhite),
                    dayTextStyle:
                        GoogleFonts.roboto(color: AppColors.colorWhite),
                  ),
                  monthCellStyle: MonthCellStyle(
                      leadingDatesTextStyle:
                          GoogleFonts.roboto(color: AppColors.colorGrey),
                      trailingDatesTextStyle:
                          GoogleFonts.roboto(color: AppColors.colorGrey),
                      textStyle:
                          GoogleFonts.roboto(color: AppColors.colorWhite))),
              appointmentTextStyle: GoogleFonts.roboto(
                fontSize: 40.sp,
                color: AppColors.colorWhite,
              ),
            );
          }
        });
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.id, this.eventName, this.from, this.to, this.background,
      this.isAllDay);
  String id;
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
