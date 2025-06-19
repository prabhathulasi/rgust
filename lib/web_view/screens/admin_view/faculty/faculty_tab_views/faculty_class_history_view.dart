import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class FacultyClassHistoryView extends StatefulWidget {
  final int? facultyId;

  const FacultyClassHistoryView({super.key, required this.facultyId});

  @override
  State<FacultyClassHistoryView> createState() =>
      _FacultyClassHistoryViewState();
}

class _FacultyClassHistoryViewState extends State<FacultyClassHistoryView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<FacultyProvider>(
        builder: (context, facultyProvider, child) {
      if (facultyProvider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else {
        if (facultyProvider.attendanceModel.sessions == null) {
          return const Center(child: Text("No Class Session Data Found"));
        } else {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView.builder(
                itemCount: facultyProvider.attendanceModel.sessions?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                      child: ExpansionTile(
                        backgroundColor: AppColors.colorWhite,
                    onExpansionChanged: (value) {
                      facultyProvider.getClassSessions(
                          context,
                          widget.facultyId!,
                          DateFormat('yyyy-MM-dd').format(DateTime.parse(
                              facultyProvider.attendanceModel.sessions![index]
                                  .startTime!)));
                    },
                    leading: const Icon(Icons.access_time_rounded),
                    title: AppRichTextView(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      title: DateFormat.yMMMEd().format(DateTime.parse(
                          facultyProvider
                              .attendanceModel.sessions![index].startTime
                              .toString())),
                      textColor: AppColors.colorBlack,
                    ),
                    children: [
                      facultyProvider.isExpansionTileLoading == true
                          ? const Center(
                              child: SpinKitSpinningLines(
                                  color: AppColors.colorWhite),
                            )
                          : SizedBox(
                              height: 400.h,
                              width: size.width,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AppRichTextView(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            title: "Start Time: ",
                                            textColor: AppColors.colorBlack,
                                          ),
                                          AppRichTextView(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            title: DateFormat("hh:mm a").format(
                                                DateTime.parse(facultyProvider
                                                    .attendanceModel
                                                    .sessions![index]
                                                    .startTime
                                                    .toString())),
                                            textColor: AppColors.colorBlack,
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          AppRichTextView(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            title: "End Time: ",
                                            textColor: AppColors.colorBlack,
                                          ),
                                        facultyProvider
                                                    .attendanceModel
                                                    .sessions![index].endTime == null || facultyProvider
                                                      .attendanceModel
                                                      .sessions![index]
                                                      .endTime == "" ?Container():  AppRichTextView(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            title: DateFormat("hh:mm a").format(
                                                DateTime.parse(facultyProvider
                                                    .attendanceModel
                                                    .sessions![index]
                                                    .endTime
                                                    .toString())),
                                            textColor: AppColors.colorBlack,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      AppRichTextView(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        title: "Topics Covered",
                                        textColor: AppColors.colorBlack,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      facultyProvider.classSessionModel
                                                  .curriculums ==
                                              null
                                          ? Container()
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: facultyProvider
                                                  .classSessionModel
                                                  .curriculums!
                                                  .length,
                                              itemBuilder:
                                                  (context, topicIndex) {
                                                return Card(
                                                  child: ListTile(
                                                    title: AppRichTextView(
                                                      fontSize: 15.sp,
                                                      fontWeight: FontWeight.bold,
                                                      title: facultyProvider
                                                          .classSessionModel
                                                          .curriculums![topicIndex]
                                                          .name!,
                                                      textColor:
                                                          AppColors.colorBlack,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                             SizedBox(
                                        height: 10.h,
                                      ),
                                      AppRichTextView(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        title: "Students Attended",
                                        textColor: AppColors.colorBlack,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      facultyProvider.classSessionModel
                                                  .students ==
                                              null
                                          ? Container()
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: facultyProvider
                                                  .classSessionModel
                                                  .students!
                                                  .length,
                                              itemBuilder:
                                                  (context, studentIndex) {
                                                return Card(
                                                  child: ListTile(
                                                    title: AppRichTextView(
                                                      fontSize: 15.sp,
                                                      fontWeight: FontWeight.bold,
                                                      title: "${facultyProvider
                                                          .classSessionModel
                                                          .students![studentIndex]
                                                          .firstName!} ${facultyProvider
                                                          .classSessionModel
                                                          .students![studentIndex]
                                                          .lastName!}",
                                                      textColor:
                                                          AppColors.colorBlack,
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            )
                    ],
                  ));
                }),
          );
        }
      }
    });
  }
}
