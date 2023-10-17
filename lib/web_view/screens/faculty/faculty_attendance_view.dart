import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class FacultyAttendanceView extends StatefulWidget {
  const FacultyAttendanceView({super.key});

  @override
  State<FacultyAttendanceView> createState() => _FacultyAttendanceViewState();
}

class _FacultyAttendanceViewState extends State<FacultyAttendanceView> {
  bool showClassDetails = false;
  List<dynamic> classList = [];

  @override
  Widget build(BuildContext context) {
    final List<Appointment> events = <Appointment>[
      Appointment(
        startTime: DateTime(2023, 9, 20, 10, 0), // Start time of the event
        endTime: DateTime(2023, 9, 20, 11, 0), // End time of the event
        subject: 'Meeting', // Event subject or title
        color: Colors.blue, // Event color
      ),
      // Add more events as needed
    ];
    return SfCalendar(
      onTap: (calendarTapDetails) {
        if (calendarTapDetails.appointments!.length == 1) {
          classList.clear();
          setState(() {
            showClassDetails = true;
            classList = calendarTapDetails.appointments!;
          });
        }
      },
      showNavigationArrow: true,
      todayHighlightColor: AppColors.color582,
      dataSource: AppointmentDataSource(events),
      // allowAppointmentResize: true,
      view: CalendarView.month,
      cellEndPadding: 15,
      cellBorderColor: AppColors.colorWhite,
      viewHeaderStyle: ViewHeaderStyle(
        dayTextStyle:
            GoogleFonts.roboto(color: AppColors.colorWhite),
      ),
      headerStyle: CalendarHeaderStyle(
          textAlign: TextAlign.center,
          textStyle:
              GoogleFonts.roboto(color: AppColors.colorWhite)),
      monthViewSettings: MonthViewSettings(
          appointmentDisplayMode:
              MonthAppointmentDisplayMode.appointment,
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
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
