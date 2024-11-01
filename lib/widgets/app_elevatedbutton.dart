import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class AppElevatedButon extends StatelessWidget {
  const AppElevatedButon(
      {Key? key,
      this.onPressed,
      required this.title,
      this.width,
      this.height,
      this.loading = false,
      this.textColor,
      this.borderColor,
      this.buttonColor})
      : super(key: key);
  final double? width;
  final double? height;
  final Function(BuildContext context)? onPressed;
  final String? title;
  final Color? textColor;
  final Color? buttonColor;
  final bool loading;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width!,
        height: height!,
        child: ElevatedButton(
          style: ButtonStyle(
              elevation: WidgetStateProperty.all<double>(2.0),
              foregroundColor: WidgetStateProperty.all<Color>(textColor!),
              backgroundColor: WidgetStateProperty.all<Color>(buttonColor!),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side:  BorderSide(
                          color:borderColor ?? AppColors.coloraeb, width: 3.0)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppRichTextView(
                title: title!,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                textColor: textColor!,
              ),
              const SizedBox(
                width: 3.0,
              ),
              Visibility(
                  visible: loading,
                  child: Expanded(
                    child: SpinKitSpinningLines(
                      color: AppColors.colorc7e,
                      size: 20.sp,
                    ),
                  )),
            ],
          ),
          onPressed: () {
            onPressed!(context);
          },
        ));
  }
}
