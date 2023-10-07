import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/faculty_model.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/faculty/add_new_faculty_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/faculty/faculty_detail_view.dart';
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
      child: SizedBox(
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final facultyProvider = Provider.of<FacultyProvider>(context);
    final programProvider = Provider.of<ProgramProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                width: 300.w,
                height: 54.h,
                decoration: BoxDecoration(
                    color: AppColors.colorc7e,
                    borderRadius: BorderRadius.circular(10.sp)),
                child: Padding(
                  padding: EdgeInsets.only(left: 18.0.w, right: 18.w),
                  child: AppTextFormFieldWidget(
                    textStyle: GoogleFonts.oswald(color: AppColors.colorWhite),
                    inputDecoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.search_outlined,
                          color: AppColors.colorWhite,
                        ),
                        hintText: "Search by Name or Mail id",
                        hintStyle:
                            GoogleFonts.oswald(color: AppColors.colorWhite)),
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
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: facultyProvider.facultyModel.facultyList!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width <= 1400 ? 4 : 6,
                  //  childAspectRatio:
                  childAspectRatio: size.width <= 1400 ? 1 / 0.9 : 1 / 1.3),
              itemBuilder: (context, index) {
                var facultydata =
                    facultyProvider.facultyModel.facultyList![index];
                return InkWell(
                  onTap: () {
                    showDetailAlertDialog(context, facultydata);
                  },
                  child: Card(
                    color: AppColors.colorc7e,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.sp)),
                    child: FacultyCardWidget(
                        userImage: facultydata.userImage!,
                        facultyName:
                            facultydata.firstName! + facultydata.lastName!,
                        assignedSubject:
                            facultydata.registeredCourse![0].courseName!,
                        facultyType: facultydata.jobType!,
                        gender: facultydata.gender!,
                        mobileNumber: facultydata.mobile!,
                        email: facultydata.email!,
                        citizenship: facultydata.citizenship!,
                        dob: facultydata.dob!,
                        batch: facultydata.registeredCourse![0].batch!,
                        address: facultydata.address!,
                        pasportNumber: facultydata.passportNumber!),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.colorc7e,
          onPressed: () async {
            programProvider.selectedDept = null;
            programProvider.selectedClass = null;
            programProvider.selectedBatch = null;
            programProvider.selectedCourse = null;
            programProvider.newData.clear();
            showAddAlertDialog(context);
          },
          child: const Icon(
            Icons.person_add_alt_1_outlined,
            color: AppColors.colorWhite,
          )),
    );
  }
}
