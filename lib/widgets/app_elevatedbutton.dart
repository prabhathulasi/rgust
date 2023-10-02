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
      this.buttonColor})
      : super(key: key);
  final double? width;
  final double? height;
  final Function(BuildContext context)? onPressed;
  final String? title;
  final Color? textColor;
  final Color? buttonColor;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width!,
        height: height!,
        child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(2.0),
              foregroundColor: MaterialStateProperty.all<Color>(textColor!),
              backgroundColor: MaterialStateProperty.all<Color>(buttonColor!),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                          color: AppColors.coloraeb, width: 2.0)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppRichTextView(
                title: title!,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                textColor: textColor!,
              ),
              const SizedBox(
                width: 3.0,
              ),
              Visibility(
                  visible: loading,
                  child: SpinKitSpinningLines(
                    color: AppColors.coloraeb,
                    size: 25.sp,
                  )),
            ],
          ),
          onPressed: () {
            onPressed!(context);
          },
        ));
  }
}
