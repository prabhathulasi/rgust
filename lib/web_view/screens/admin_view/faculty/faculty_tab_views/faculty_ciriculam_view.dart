
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/faculty_registered_course_model.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/faculty_tab_views/faculty_ciriculam_list.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class FacultyCiriculamView extends StatefulWidget {
  final int? facultyId;

  const FacultyCiriculamView({super.key, required this.facultyId});

  @override
  State<FacultyCiriculamView> createState() => _FacultyCiriculamViewState();
}

class _FacultyCiriculamViewState extends State<FacultyCiriculamView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<FacultyProvider>(
        builder: (context, facultyConsumer, child) {
          if(facultyConsumer.isLoading == true){
            return const Center(
              child: SpinKitSpinningLines(
                color: AppColors.color446,
                size: 50.0,
              ),
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                      color: AppColors.colorWhite,
                      child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                  Center(
                                    child: AppRichTextView(
                                      title: "Select Course",
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.color446,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0.sp),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: AppColors.color446),
                                        borderRadius: BorderRadius.circular(10.sp),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          padding: EdgeInsets.all(8.0.sp),
                                          hint: AppRichTextView(
                                            title: "Select Course",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            textColor: AppColors.color446,
                                          ),
                                          iconEnabledColor: AppColors.color446,
                                          iconSize: 34.sp,
                                          dropdownColor: AppColors.colorWhite,
                                          isExpanded: true,
                                          value: facultyConsumer
                                              .selectedCuriculumCourse,
                                          onChanged: (int? newValue) {
                                            facultyConsumer
                                                .setSelectedCiriculumCourse(
                                                    newValue, context);
                                          },
                                          items: facultyConsumer
                                              .facultyRegisteredCourseModel.data!
                                              .map((Data data) {
                                            return DropdownMenuItem<int>(
                                              value: data.courseId,
                                              child: AppRichTextView(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700,
                                                title: data.courseName!,
                                                textColor: AppColors.colorBlack,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  facultyConsumer.selectedCuriculumCourse == null ||
                                          facultyConsumer.selectedCuriculumCourse ==
                                              0
                                      ? Container()
                                      : Column(
                                          children: [
                                            Center(
                                              child: AppRichTextView(
                                                title: "Upload Ciriculam",
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor: AppColors.color446,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
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
                                                        textColor:
                                                            AppColors.color446,
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      TextFormField(
                                                        readOnly:
                                                            true, // <<<<< ADD THIS
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return "This DOB is Required";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        style: GoogleFonts.roboto(
                                                            color: AppColors
                                                                .colorBlack,
                                                            fontSize: 15.sp),
                                                        controller: facultyConsumer
                                                            .startDate,
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                "Enter Start Date",
                                                            hintStyle:
                                                                GoogleFonts.roboto(
                                                                    color: AppColors
                                                                        .color446),
                                                            border:
                                                                const OutlineInputBorder()),
                                                        onTap: () async {
                                                          DateTime? pickedDate =
                                                              await showDatePicker(
                                                                  builder: (BuildContext
                                                                          context,
                                                                      Widget?
                                                                          child) {
                                                                    return Theme(
                                                                      data: ThemeData
                                                                              .light()
                                                                          .copyWith(
                                                                        primaryColor:
                                                                            AppColors
                                                                                .color446,
                                                                        colorScheme:
                                                                            const ColorScheme.light()
                                                                                .copyWith(
                                                                          primary:
                                                                              AppColors
                                                                                  .color446,
                                                                        ),
                                                                        buttonTheme:
                                                                            const ButtonThemeData(
                                                                                textTheme:
                                                                                    ButtonTextTheme.primary),
                                                                      ),
                                                                      child: child!,
                                                                    );
                                                                  },
                                                                  barrierDismissible:
                                                                      false,
                                                                  context: context,
                                                                  initialDate:
                                                                      DateTime
                                                                          .now(),
                                                                  firstDate:
                                                                      DateTime(
                                                                          2025),
                                                                  lastDate:
                                                                      DateTime(
                                                                          2025 +
                                                                              20));
          
                                                          if (pickedDate != null) {
                                                            String formattedDate =
                                                                DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(
                                                                        pickedDate);
          
                                                            facultyConsumer
                                                                .setStartDate(
                                                                    formattedDate);
                                                          } else {
                                                            print(
                                                                "Date is not selected");
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
                                                        textColor:
                                                            AppColors.color446,
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      TextFormField(
                                                        readOnly:
                                                            true, // <<<<< ADD THIS
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return "This DOB is Required";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        style: GoogleFonts.roboto(
                                                            color: AppColors
                                                                .colorBlack,
                                                            fontSize: 15.sp),
                                                        controller:
                                                            facultyConsumer.endDate,
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                "Enter End Date",
                                                            hintStyle:
                                                                GoogleFonts.roboto(
                                                                    color: AppColors
                                                                        .color446),
                                                            border:
                                                                const OutlineInputBorder()),
                                                        onTap: () async {
                                                          DateTime? pickedDate = await showDatePicker(
                                                              context: context,
                                                              initialDate:
                                                                  DateTime.parse(
                                                                      facultyConsumer
                                                                          .startDate
                                                                          .text),
                                                              firstDate:
                                                                  DateTime.parse(
                                                                      facultyConsumer
                                                                          .startDate
                                                                          .text),
                                                              lastDate: DateTime(
                                                                  2025 + 20));
          
                                                          if (pickedDate != null) {
                                                            String formattedDate =
                                                                DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(
                                                                        pickedDate);
                                                            facultyConsumer
                                                                .setEndDate(
                                                                    formattedDate);
                                                          } else {
                                                            print(
                                                                "Date is not selected");
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            facultyConsumer.ciriculamList.isEmpty
                                                ? Container()
                                                : ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: facultyConsumer
                                                        .ciriculamList.length,
                                                    itemBuilder: (context, index) {
                                                      return ListTile(
                                                        trailing: InkWell(
                                                          onTap: () {
                                                            facultyConsumer
                                                                .deleteCiriculam(
                                                                    index);
                                                          },
                                                          child: const Icon(
                                                              Icons.delete,
                                                              color: AppColors
                                                                  .colorRed),
                                                        ),
                                                        title: AppRichTextView(
                                                          title:
                                                              "${index + 1}. ${facultyConsumer.ciriculamList[index]}",
                                                          fontSize: 15.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          textColor:
                                                              AppColors.color446,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Form(
                                              key: facultyConsumer.ciriculamKey,
                                              child: AppTextFormFieldWidget(
                                                inputDecoration: InputDecoration(
                                                  hintText: "Enter Ciriculam",
                                                  border: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10)),
                                                    borderSide: BorderSide(
                                                        color: AppColors.color446),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(10)),
                                                    borderSide: BorderSide(
                                                        width: 3.w,
                                                        color: AppColors.color446),
                                                  ),
                                                ),
                                                validator: (p0) {
                                                  if (p0!.isEmpty) {
                                                    return "Please Enter Ciriculam";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onSaved: (p0) {
                                                  facultyConsumer.setCiriculam(p0!);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: AppElevatedButon(
                                                title: "Add",
                                                onPressed: (context) async {
                                                  facultyConsumer
                                                      .handleCiriculam(context);
                                                },
                                                buttonColor: AppColors.color446,
                                                textColor: AppColors.colorWhite,
                                                height: 35.h,
                                                width: 80.w,
                                              ),
                                            ),
                                            facultyConsumer.ciriculamList.isEmpty
                                                ? Container()
                                                : Center(
                                                    child: AppElevatedButon(
                                                      loading:
                                                          facultyConsumer.isLoading,
                                                      title: "Upload",
                                                      onPressed: (context) async {
                                                        var token =
                                                            await getTokenAndUseIt();
                                                        if (token == null) {
                                                          if (context.mounted) {
                                                            Navigator.pushNamed(
                                                                context,
                                                                RouteNames.login);
                                                          }
                                                        } else if (token ==
                                                            "Token Expired") {
                                                          ToastHelper().errorToast(
                                                              "Session Expired Please Login Again");
          
                                                          if (context.mounted) {
                                                            Navigator.pushNamed(
                                                                context,
                                                                RouteNames.login);
                                                          }
                                                        } else {
                                                          var result = await facultyConsumer
                                                              .postCiricullam(
                                                                  context, token,
                                                                  courseId:
                                                                      facultyConsumer
                                                                          .selectedCuriculumCourse!,
                                                                  facultyId: widget
                                                                      .facultyId!);
                                                          if (result ==
                                                              "Invalid Token") {
                                                            ToastHelper().errorToast(
                                                                "Session Expired Please Login Again");
                                                            if (context.mounted) {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  RouteNames.login);
                                                            }
                                                          }
                                                        }
          
                                                  
                                                      },
                                                      buttonColor:
                                                          AppColors.color446,
                                                      textColor:
                                                          AppColors.colorWhite,
                                                      height: 40.h,
                                                      width: 100.w,
                                                    ),
                                                  )
                                          ],
                                        )
                                ]))
                          )
                          )),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: facultyConsumer.selectedCuriculumCourse == null ||
                        facultyConsumer.selectedCuriculumCourse == 0
                    ? Container()
                    : FacultyCiriculamList(
                        facultyId: widget.facultyId,
                      ),
              ),
            ],
          );
        }
      ),
    );
  }
}
