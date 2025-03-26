import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/program_model.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class ProgramDropdown extends StatefulWidget {
  const ProgramDropdown({super.key});

  @override
  State<ProgramDropdown> createState() => _ProgramDropdownState();
}

class _ProgramDropdownState extends State<ProgramDropdown> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    final programProvider =
        Provider.of<ProgramProvider>(context, listen: false);

    Future getProgramList() async {
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
        var result = await programProvider.getProgram(token);
        if (result == "Invalid token") {
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    return FutureBuilder(
        future: getProgramList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.color446, width: 3.w),
                    borderRadius: BorderRadius.circular(8.sp)),
                height: 60.h,
                width: size.width * 0.2,
                child: Center(
                    child: SpinKitSpinningLines(
                  color: AppColors.colorc7e,
                  size: 20.sp,
                )));
          } else {
            return programProvider.programModel.program == null
                ? Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.color446, width: 3.w),
                        borderRadius: BorderRadius.circular(8.sp)),
                    height: 60.h,
                    width: size.width * 0.2,
                    child: Center(
                        child: SpinKitSpinningLines(
                      color: AppColors.color446,
                      size: 20.sp,
                    )))
                : Consumer<ProgramProvider>(
                    builder: (context, programProvider, child) {
                    return Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.color446, width: 3.w),
                          borderRadius: BorderRadius.circular(8.sp)),
                      height: 60.h,
                      width: size.width * 0.2,
                      child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            iconSize: 34.sp,
                            iconEnabledColor: AppColors.color446,
                            dropdownColor: AppColors.colorWhite,
                            isExpanded: true,
                            value: programProvider.selectedDept,
                            items: programProvider.programModel.program!
                                .map((Program department) {
                              return DropdownMenuItem<String>(
                                value: department.programId.toString(),
                                child: AppRichTextView(
                                  fontSize: 15.sp,
                                  title: department.programname!,
                                  fontWeight: FontWeight.w700,
                                  textColor: AppColors.colorBlack,
                                ),
                              );
                            }).toList(),
                            hint: AppRichTextView(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              title: "Please Select the Program",
                              textColor: AppColors.colorBlack,
                            ),
                            onChanged: (String? value) async {
                              print(value);
                              var token = await getTokenAndUseIt();
                              if (token == null) {
                                if (context.mounted) {
                                  Navigator.pushNamed(
                                      context, RouteNames.login);
                                }
                              } else if (token == "Token Expired") {
                                ToastHelper().errorToast(
                                    "Session Expired Please Login Again");

                                if (context.mounted) {
                                  Navigator.pushNamed(
                                      context, RouteNames.login);
                                }
                              } else {
                                programProvider.setSelectedDept(value!, token);
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  });
          }
        });
  }
}
