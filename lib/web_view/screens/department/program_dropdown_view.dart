import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/program_model.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
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
    return FutureBuilder(
        future: programProvider.getProgram(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: AppColors.color927,
                height: 60.h,
                width: size.width * 0.2,
                child: Center(
                    child: SpinKitSpinningLines(
                  color: AppColors.colorWhite,
                  size: 20.sp,
                )));
          } else {
            
            
          return programProvider.programModel.program== null? Container(
                color: AppColors.color927,
                height: 60.h,
                width: size.width * 0.2,
                child: Center(
                    child: SpinKitSpinningLines(
                  color: AppColors.colorWhite,
                  size: 20.sp,
                ))):  Consumer<ProgramProvider>(
              builder: (context, programProvider, child) {
                return Container(
                  color: AppColors.color927,
                  height: 60.h,
                  width: size.width * 0.2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        iconDisabledColor: AppColors.colorWhite,
                        dropdownColor: AppColors.color927,
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
                              textColor: AppColors.colorWhite,
                            ),
                          );
                        }).toList(),
                        hint: AppRichTextView(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          title: "Please Select the Program",
                          textColor: AppColors.colorWhite,
                        ),
                        onChanged: (String? value) {
                          programProvider.setSelectedDept(value!, context);
                          
                        },
                      ),
                    ),
                  ),
                );
              }
            );
          }
        });
  }
}