import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/invoice_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/department/program_dropdown_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class ProgramComponent extends StatelessWidget {
  const ProgramComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.h,
        ),
        AppRichTextView(
            title: "Please Select Program",
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            textColor: AppColors.colorBlack),
        SizedBox(
          height: 10.h,
        ),
        const ProgramDropdown(),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
