import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';



class BatchDropdown extends StatefulWidget {
  const BatchDropdown({super.key});

  @override
  State<BatchDropdown> createState() => _BatchDropdownState();
}

class _BatchDropdownState extends State<BatchDropdown> {
  @override
  Widget build(BuildContext context) {
  var size = MediaQuery.sizeOf(context);
     final programProvider = Provider.of<ProgramProvider>(context);
    return               programProvider.selectedClass == null
                      ? Container()
                      : Container(
                        color: AppColors.color927,
                        height: 60.h,
                        width: size.width * 0.2,
                        child: Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: AppColors.color927,
                              isExpanded: true,
                              value: programProvider.selectedBatch,
                              items: <String>[
                                "Janurary-${programProvider.selectedYear.toString()}",
                                "May-${programProvider.selectedYear.toString()}",
                                "September-${programProvider.selectedYear.toString()}"
                              ]
                                  .map((String val) =>
                                      DropdownMenuItem<String>(
                                        value: val,
                                        child: AppRichTextView(
                                          fontSize: 15.sp,
                                          textColor: AppColors.colorWhite,
                                          fontWeight: FontWeight.w700,
                                          title: val,
                                        ),
                                      
                                      ))
                                  .toList(),
                              hint:  AppRichTextView(
                                          fontSize: 15.sp,
                                          textColor: AppColors.colorWhite,
                                          fontWeight: FontWeight.w700,
                                          title: "Please Select the Batch",
                                        ),
                              onChanged: (String? value) async{
                                
                                  programProvider.setSelectedBatch(value!, context);
                                // await programProvider.getCoursesList();
                               
                              },
                            ),
                          ),
                        ),
                      );
  }
}