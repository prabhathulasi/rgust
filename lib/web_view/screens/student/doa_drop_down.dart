import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/common_provider.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class DoaDropdown extends StatelessWidget {
  const DoaDropdown({super.key});
  showAlert(CommonProvider commonConsumer, BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.green, // Change calendar header color

                colorScheme: const ColorScheme.light(
                    primary: AppColors.colorc7e), // Change days' colors
                buttonTheme: const ButtonThemeData(
                  textTheme: ButtonTextTheme.primary,
                ),
              ),
              child: child!);
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900), //- not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      //formatted date output using intl package =>  2021-03-16
      commonConsumer.selectdoa(formattedDate);
    } else {
      print("Date is not selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
decoration: BoxDecoration(
  color: AppColors.colorWhite,
   borderRadius: BorderRadius.circular(8.sp),
  border: Border.all(color: AppColors.colorc7e,width: 3.w)
),
      height: 70.h,
      width: size.width * 0.2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<CommonProvider>(builder: (context, commonConsumer, child) {
          return TextFormField(
            readOnly: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This DOB is Required";
              } else {
                return null;
              }
            },
            style: GoogleFonts.roboto(
                color: AppColors.colorBlack, fontSize: 15.sp),
            controller: commonConsumer.doaTextController,
            decoration: InputDecoration(
              hintText: "Please Select the date",
                errorStyle: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorRed),
                hintStyle:
                    GoogleFonts.roboto(color: AppColors.colorBlack ,fontWeight: FontWeight.bold, ),
                border: InputBorder.none),
            onTap: () {
              showAlert(commonConsumer, context);
            },
          );
        }),
      ),
    );
  }
}
