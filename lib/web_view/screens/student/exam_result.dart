import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class ExamResult extends StatefulWidget {
  const ExamResult({super.key});

  @override
  State<ExamResult> createState() => _ExamResultState();
}

class _ExamResultState extends State<ExamResult> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: AppRichTextView(
          title: "No Results Added Yet",
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          textColor: AppColors.colorBlack,
        )
        ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: const Icon(Icons.upload),
      ),
    );
  }
}