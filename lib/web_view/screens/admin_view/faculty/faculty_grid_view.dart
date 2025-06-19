import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/faculty_model.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/add_new_faculty_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/faculty_detail_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/faculty/update_faculty_view.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/faculty_card.dart';

class FacultyGridView extends StatefulWidget {
  const FacultyGridView({super.key});

  @override
  State<FacultyGridView> createState() => _FacultyGridViewState();
}

class _FacultyGridViewState extends State<FacultyGridView> {
  showAddAlertDialog(BuildContext context) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Stack(
        children: [
          const AddFacultyView(),
          Transform.translate(
            offset: Offset(10.w, -13.h),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: AppColors.colorc7e,
                    child: Icon(Icons.close, color: AppColors.color582),
                  ),
                )),
          )
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDetailAlertDialog(BuildContext context, FacultyList details) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        color: AppColors.color446,
        child: Stack(
          children: [
            FacultyDetailView(facultyDetail: details),
            Transform.translate(
              offset: Offset(10.w, -13.h),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 14.0,
                      backgroundColor: AppColors.colorc7e,
                      child: Icon(Icons.close, color: AppColors.color582),
                    ),
                  )),
            )
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showUpdateAlertDialog(BuildContext context, FacultyList details) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Stack(
        children: [
          UpdateFacultyView(facultyDetail: details),
          Transform.translate(
            offset: Offset(10.w, -13.h),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: AppColors.colorc7e,
                    child: Icon(Icons.close, color: AppColors.color582),
                  ),
                )),
          )
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((value) {
      setState(() {});
    });
  }

  final GlobalKey<FormFieldState<String>> textFieldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final facultyProvider = Provider.of<FacultyProvider>(context);
    final programProvider = Provider.of<ProgramProvider>(context);

    return Scaffold(
      body: Container(
        color: AppColors.colorWhite,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 300.w,
                  height: 54.h,
                  decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      border: Border.all(color: AppColors.color446, width: 2.w),
                      borderRadius: BorderRadius.circular(10.sp)),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 18.0.w, right: 18.w),
                      child: AppTextFormFieldWidget(
                        key: textFieldKey,
                        onChanged: (p0) {
                          facultyProvider.setEnableFilter(true);
                          facultyProvider.filterFaculty(p0);
                        },
                        textStyle: GoogleFonts.oswald(
                            color: AppColors.color446, fontSize: 15.sp),
                        inputDecoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.search,
                              color: AppColors.colorGrey,
                              size: 25.sp,
                            ),
                            border: InputBorder.none,
                            hintText: "Search by Name",
                            hintStyle: GoogleFonts.oswald(
                                color: AppColors.colorGrey, fontSize: 18.sp)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      color: AppColors.contentColorOrange,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    AppRichTextView(
                        title: "Part-Time",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold)
                  ],
                ),
                SizedBox(
                  width: 10.w,
                ),
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      color: AppColors.color582,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    AppRichTextView(
                        title: "Full-Time",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold)
                  ],
                ),
                SizedBox(
                  width: 10.w,
                ),
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      color: AppColors.colorRed,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    AppRichTextView(
                        title: "Resigned",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold)
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            facultyProvider.filteredEnable == true
                ? Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: facultyProvider.filteredList.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200, // Max width per item
                        childAspectRatio: 3 / 2, // Width / Height ratio
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        var facultydata = facultyProvider.filteredList[index];
                        var memoryImagedata =
                            base64Decode(facultydata.userImage!);
                        return InkWell(
                          onTap: () {
                               facultyProvider.clearCiriculumCourse();
                               
                            showDetailAlertDialog(context, facultydata);
                          },
                          child: Card(
                            color: AppColors.color446,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.sp)),
                            child: FacultyCardWidget(
                                onTap: () {
                                 
                                  facultyProvider.updateJobType(false);
                                  facultyProvider.updateGender(false);
                                  showUpdateAlertDialog(context, facultydata);
                                },
                                index: index,
                                isMultipleCourse:
                                    facultydata.registeredCourse!.length > 1
                                        ? true
                                        : false,
                                userImage: memoryImagedata,
                                facultyName: facultydata.firstName! +
                                    facultydata.lastName!,
                                facultyType: facultydata.jobType!,
                                gender: facultydata.gender!,
                                mobileNumber: facultydata.mobile!,
                                email: facultydata.email!,
                                citizenship: facultydata.citizenship!,
                                dob: facultydata.dob!,
                                registeredCourse: facultydata.registeredCourse,
                                address: facultydata.address!,
                                employeeId: facultydata.facultyId!),
                          ),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount:
                          facultyProvider.facultyModel.facultyList!.length,
                    gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 340, // Max width per item
                        childAspectRatio: 3/ 3.6, // Width / Height ratio
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        var facultydata =
                            facultyProvider.facultyModel.facultyList![index];
                        var memoryImagedata =
                            base64Decode(facultydata.userImage!);
                        return InkWell(
                          onTap: () {
                               facultyProvider.clearCiriculumCourse();
                                  log(facultyProvider.selectedCuriculumCourse.toString());
                            showDetailAlertDialog(context, facultydata);
                          },
                          child: Card(
                            color: AppColors.colorWhite,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.sp)),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.sp),
                                border: Border.all(
                                    color: AppColors.color446, width: 2.w),
                              ),
                              child: FacultyCardWidget(
                                  onTap: () {
                                    
                                    facultyProvider.updateJobType(false);
                                    facultyProvider.updateGender(false);
                                    showUpdateAlertDialog(context, facultydata);
                                  },
                                  index: index,
                                  isMultipleCourse:
                                      facultydata.registeredCourse!.length > 1
                                          ? true
                                          : false,
                                  userImage: memoryImagedata,
                                  facultyName:"${facultydata.firstName!} ${facultydata.lastName!}",
                                  facultyType: facultydata.jobType!,
                                  gender: facultydata.gender!,
                                  mobileNumber: facultydata.mobile!,
                                  email: facultydata.email!,
                                  citizenship: facultydata.citizenship!,
                                  dob: facultydata.dob!,
                                  registeredCourse: facultydata.registeredCourse,
                                  address: facultydata.address!,
                                  employeeId: facultydata.facultyId!),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: AppColors.colorWhite,
            border: Border.all(color: AppColors.color446, width: 3.w),
            borderRadius: BorderRadius.circular(18.sp)
            ),
        child: FloatingActionButton(
            backgroundColor: AppColors.colorWhite,
            onPressed: () async {
              programProvider.selectedDept = null;
              programProvider.selectedClass = null;
              programProvider.selectedBatch = null;
              programProvider.selectedCourse = null;
              facultyProvider.selectTile(-1);
              programProvider.newData.clear();
              showAddAlertDialog(context);
            },
            child: const Icon(
              Icons.person_add_alt_1_outlined,
              color: AppColors.color446,
            )),
      ),
    );
  }
}
