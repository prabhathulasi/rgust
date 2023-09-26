
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/faculty_model.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/index.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

import 'package:rugst_alliance_academia/web_view/screens/faculty/add_new_faculty_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/faculty/faculty_detail_view.dart';

import 'package:rugst_alliance_academia/widgets/app_formfield.dart';

import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';
import 'package:rugst_alliance_academia/widgets/faculty_card.dart';

class FacultyListView extends StatefulWidget {
  const FacultyListView({Key? key}) : super(key: key);

  @override
  State<FacultyListView> createState() => _FacultyListViewState();
}

class _FacultyListViewState extends State<FacultyListView> {
  showDetailAlertDialog(BuildContext context, FacultyList details) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width * 0.68,
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
                      backgroundColor: AppColors.color927,
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
                    backgroundColor: AppColors.color927,
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

  @override
  Widget build(BuildContext context) {
    final facultyProvider =
        Provider.of<FacultyProvider>(context, listen: false);

    Future getFacultyList() async {
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
        await facultyProvider.getFaculty(token);
      }
    }

    const double itemHeight = 255;
    const double itemWidth = 220;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(18.0.sp),
        child: FutureBuilder(
          future: getFacultyList(),
          builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return   Center(
                child: SpinKitSpinningLines(
                  color: AppColors.color927,
                  size: 60.sp,
                ),
              );
        } else {
    
          return facultyProvider.facultyModel.facultyList == null
                  ? Center(
                      child: Image.asset(ImagePath.webNoDataLogo)
                    )
                  :   Column(
                    children: [
                        Row(
                              children: [
                                Container(
                                  width: 300.w,
                                  height: 54.h,
                                  decoration: BoxDecoration(
                                      color: AppColors.color927,
                                      borderRadius:
                                          BorderRadius.circular(10.sp)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 18.0.w, right: 18.w),
                                    child: AppTextFormFieldWidget(
                                      textStyle: GoogleFonts.oswald(
                                          color: AppColors.colorWhite),
                                      inputDecoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: const Icon(
                                            Icons.search_outlined,
                                            color: AppColors.colorWhite,
                                          ),
                                          hintText: "Search by Name or Mail id",
                                          hintStyle: GoogleFonts.oswald(
                                              color: AppColors.colorWhite)),
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
                      Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: facultyProvider
                              .facultyModel.facultyList!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6,
                                  childAspectRatio:
                                      (itemWidth / itemHeight)),
                          itemBuilder: (context, index) {
                            var facultydata = facultyProvider
                                .facultyModel.facultyList![index];
                            return InkWell(
                              onTap: () {
                                showDetailAlertDialog(context, facultydata);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(18.sp)),
                                child: Container(
                                  height: 530.h,
                                  width: 330.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.color927,
                                      borderRadius:
                                          BorderRadius.circular(18.sp)),
                                  child: FacultyCardWidget(
                                      userImage: facultydata.userImage!,
                                      facultyName: facultydata.firstName! +
                                          facultydata.lastName!,
                                      assignedSubject:
                                          facultydata.courseName!,
                                      facultyType: facultydata.jobType!,
                                      gender: facultydata.gender!,
                                      mobileNumber: facultydata.mobile!,
                                      email: facultydata.email!,
                                      citizenship: facultydata.citizenship!,
                                      dob: facultydata.dob!,
                                      batch: facultydata.batch!,
                                      address: facultydata.address!,
                                      pasportNumber:
                                          facultydata.passportNumber!),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
        }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.color927,
          onPressed: () {
            showAddAlertDialog(context);
          },
          child: const Icon(
            Icons.person_add_alt_1_outlined,
            color: AppColors.colorWhite,
          )),
    );
  }
}
