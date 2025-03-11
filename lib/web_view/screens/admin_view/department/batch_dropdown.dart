import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class BatchDropdown extends StatefulWidget {
   final bool isUpdatingStudent;
  const BatchDropdown({super.key, required this.isUpdatingStudent});

  @override
  State<BatchDropdown> createState() => _BatchDropdownState();
}

class _BatchDropdownState extends State<BatchDropdown> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final programProvider = Provider.of<ProgramProvider>(context);
    return programProvider.selectedClass == null
        ? Container()
        : Container(
             decoration: BoxDecoration(
                    border: Border.all(color: AppColors.colorc7e, width: 3.w),
                    borderRadius: BorderRadius.circular(8.sp)),
            height: 60.h,
            width: size.width * 0.2,
            child: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  iconSize: 34.sp,
                  iconEnabledColor: AppColors.colorc7e,
                  dropdownColor: AppColors.colorWhite,
                  isExpanded: true,
                  value: programProvider.selectedBatch,
                  items: <String>[
                    "Janurary-${programProvider.selectedYear.toString()}",
                    "May-${programProvider.selectedYear.toString()}",
                    "September-${programProvider.selectedYear.toString()}"
                  ]
                      .map((String val) => DropdownMenuItem<String>(
                            value: val,
                            child: AppRichTextView(
                              fontSize: 15.sp,
                              textColor: AppColors.colorBlack,
                              fontWeight: FontWeight.w700,
                              title: val,
                            ),
                          ))
                      .toList(),
                  hint: AppRichTextView(
                    fontSize: 15.sp,
                    textColor: AppColors.colorBlack,
                    fontWeight: FontWeight.w700,
                    title: "Please Select the Batch",
                  ),
                  onChanged: (String? value) async {
                    var token = await getTokenAndUseIt();
                    if (token == null) {
                      if (context.mounted) {
                        Navigator.pushNamed(context, RouteNames.login);
                      }
                    } else if (token == "Token Expired") {
                      ToastHelper()
                          .errorToast("Session Expired Please Login Again");

                      if (context.mounted) {
                        Navigator.pushNamed(context, RouteNames.login);
                      }
                    } else {
                      programProvider.setSelectedBatch(value!, token, widget.isUpdatingStudent);
                    }
                  },
                ),
              ),
            ),
          );
  }
}
