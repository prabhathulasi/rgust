import 'package:flutter/material.dart';
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
            size: 15,
            color: widget.gender!.isSelected
                ? AppColors.color582
                : AppColors.colorWhite),
        const SizedBox(
          width: 10,
        ),
        Text(
          widget.gender!.name,
          style: TextStyle(
              color: widget.gender!.isSelected
                  ? AppColors.color582
                  : AppColors.colorWhite),
        )
      ],
    ):Row(
      children: [
        Icon(Icons.circle,
            size: 15,
            color: widget.jobType!.isSelected
                ? AppColors.color582
                : AppColors.colorWhite),
        const SizedBox(
          width: 10,
        ),
        Text(
          widget.jobType!.name,
          style: TextStyle(
              color: widget.jobType!.isSelected
                  ? AppColors.color582
                  : AppColors.colorWhite),
        )
      ],
    ) ;
  }
}
