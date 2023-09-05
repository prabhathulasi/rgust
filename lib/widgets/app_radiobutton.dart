import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/gender_model.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';

class AppRadioButton extends StatefulWidget {
  final Gender? gender;
  const AppRadioButton({super.key, this.gender});

  @override
  State<AppRadioButton> createState() => _AppRadioButtonState();
}

class _AppRadioButtonState extends State<AppRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
