
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget(
      {super.key,
      this.onPressed,
      required this.title,
      this.width,
      this.height,
      this.textColor,
      this.buttonImage,
      this.buttonColor});
  final double? width;
  final double? height;
  final Function(BuildContext context)? onPressed;
  final String? title;
  final Color? textColor;
  final Color? buttonColor;
  final String? buttonImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(color: AppColors.colorca1, width: 0.25.sp),
          borderRadius: BorderRadius.circular(15.sp)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.sp),
        onTap: () {
          onPressed!(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              buttonImage!,
              width: 24.w,
            ),
            SizedBox(
              width: 11.w,
            ),
            Text(
              title!,
              style: TextStyle(
                  fontFamily: "WorkSans",
                  color: textColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}