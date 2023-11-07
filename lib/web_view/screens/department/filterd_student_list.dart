import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';


class FilteredStudentView extends StatefulWidget {
  const FilteredStudentView({super.key});

  @override
  State<FilteredStudentView> createState() => _FilteredStudentViewState();
}

class _FilteredStudentViewState extends State<FilteredStudentView> {
  @override
  Widget build(BuildContext context) {
    /*24 is for notification bar on Android*/
    final double itemHeight = 260.h;
    final double itemWidth = 200.w;
    return Scaffold(
        body: GridView.builder(
      itemCount: 16,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: (itemWidth / itemHeight)),
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.sp)),
          child: Container(
            height: 530.h,
            width: 330.w,
            decoration: BoxDecoration(
                color: AppColors.colorc7e,
                borderRadius: BorderRadius.circular(18.sp)),
            // child: const StudentCardWidget(
            //   userImage: ,
            //     studentName: "Prabhakaran.T",
            //     studentStatus: "Active",
            //     studentType: "Regular Student",
            //     mobileNumber: "+917305822599",
            //     email: "Prabha709@gmail.com",
            //     citizenship: "Indian",
            //     dob: "02/04/1996",
            //     program: "School of Medicine",
            //     currentClass: "MD-1",
            //     address: "No.22 gangai amman street urappakkam chennai",
            //     pasportNumber: "S12345"),
          ),
        );
      },
    ));
  }
}
