import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/data/model/gender_model.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';

class AppRadioButton extends StatefulWidget {
  final Gender? gender;
  final JobType ?jobType;
  const AppRadioButton({super.key, this.gender, this.jobType});

  @override
  State<AppRadioButton> createState() => _AppRadioButtonState();
}

class _AppRadioButtonState extends State<AppRadioButton> {
  @override
  Widget build(BuildContext context) {
   return widget.gender!=null?  Row(
    
      children: [
        Icon(Icons.circle,
            size: 15.sp,
            color: widget.gender!.isSelected
                ? AppColors.color446
                : AppColors.colorGrey),
        const SizedBox(
          width: 10,
        ),
        Text(
          widget.gender!.name,
          style: TextStyle(
            fontSize: 13.sp,
              color: widget.gender!.isSelected
                  ? AppColors.color446
                  : AppColors.colorGrey),
        )
      ],
    ):Row(
      
      children: [
        Icon(Icons.circle,
            size: 15.sp,
            color: widget.jobType!.isSelected
                ? AppColors.color446
                : AppColors.colorGrey),
        const SizedBox(
          width: 10,
        ),
        Text(
          widget.jobType!.name,
          style: TextStyle(
            fontSize: 13.sp,
              color: widget.jobType!.isSelected
                  ? AppColors.color446
                  : AppColors.colorGrey),
        )
      ],
    ) ;
  }
}
