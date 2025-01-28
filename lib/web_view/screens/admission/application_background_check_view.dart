import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_criminal_check_provider.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationBackgroundCheckView extends StatefulWidget {
  const ApplicationBackgroundCheckView({super.key});

  @override
  State<ApplicationBackgroundCheckView> createState() =>
      _ApplicationBackgroundCheckViewState();
}

class _ApplicationBackgroundCheckViewState
    extends State<ApplicationBackgroundCheckView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdmissionCriminalCheckProvider>(
        builder: (context, admissionCriminalCheckConsumer, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 150.w),
        child: Column(
          children: [
            Center(
              child: AppRichTextView(
                title: "Background Check",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              color: AppColors.colorBlack,
            ),
            SizedBox(
              height: 15.h,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: admissionCriminalCheckConsumer.dataList.length,
              itemBuilder: (context, index) => CheckboxListTile(
                enabled: false,
                activeColor: AppColors.colorc7e,
                value: true,
                onChanged: (value) {},
                title: AppRichTextView(
                    maxLines: 4,
                    title: admissionCriminalCheckConsumer.dataList[index]
                        ["title"],
                    textColor: AppColors.colorBlack,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      );
    });
  }
}
