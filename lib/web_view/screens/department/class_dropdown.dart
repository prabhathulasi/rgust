import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/program_class_model.dart';

import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class ClassDropdown extends StatefulWidget {
  final bool isUpdatingStudent;
  const ClassDropdown({super.key, required this.isUpdatingStudent});

  @override
  State<ClassDropdown> createState() => _ClassDropdownState();
}

class _ClassDropdownState extends State<ClassDropdown> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    final programProvider = Provider.of<ProgramProvider>(context);
    return programProvider.selectedDept == null
        ? Container()
        : programProvider.programClassModel.programClass == null
            ? Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.colorc7e, width: 3.w),
                    borderRadius: BorderRadius.circular(8.sp)),
                height: 60.h,
                width: size.width * 0.2,
                child: Center(
                    child: SpinKitSpinningLines(
                  color: AppColors.colorWhite,
                  size: 20.sp,
                )))
            : Consumer<ProgramProvider>(
                builder: (context, programProvider, child) {
                return Consumer<StudentProvider>(
                    builder: (context, studentConsumer, child) {
                  return Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.colorc7e, width: 3.w),
                        borderRadius: BorderRadius.circular(8.sp)),
                    height: 60.h,
                    width: size.width * 0.2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          iconEnabledColor: AppColors.colorc7e,
                          iconSize: 34.sp,
                          dropdownColor: AppColors.colorWhite,
                          isExpanded: true,
                          value: programProvider.selectedClass,
                          items: programProvider.programClassModel.programClass!
                              .map((ProgramClass programClass) {
                            return DropdownMenuItem<String>(
                              value: programClass.classId.toString(),
                              child: AppRichTextView(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                title: programClass.className!,
                                textColor: AppColors.colorBlack,
                              ),

                              //  child: Text(programClass.className!,
                              //      style: const TextStyle(
                              //          color: AppColors.colorWhite)),
                            );
                          }).toList(),
                          hint: AppRichTextView(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            title: "Please Select the Class",
                            textColor: AppColors.colorBlack,
                          ),
                          onChanged: (String? value) async {
                        
                            var token = await getTokenAndUseIt();
                            if (token == null) {
                              if (context.mounted) {
                                Navigator.pushNamed(context, RouteNames.login);
                              }
                            } else if (token == "Token Expired") {
                              ToastHelper().errorToast(
                                  "Session Expired Please Login Again");

                              if (context.mounted) {
                                Navigator.pushNamed(context, RouteNames.login);
                              }
                            } else {
                             
                              programProvider.setSelectedClass(
                                  value!, token, widget.isUpdatingStudent);
                            }
                          },
                        ),
                      ),
                    ),
                  );
                });
              });
  }
}
