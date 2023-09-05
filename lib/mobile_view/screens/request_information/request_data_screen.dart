import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rugst_alliance_academia/routes/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_formfield.dart';

import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class MobileRequestDataScreen extends StatefulWidget {
  const MobileRequestDataScreen({super.key});

  @override
  State<MobileRequestDataScreen> createState() =>
      _MobileRequestDataScreenState();
}

class _MobileRequestDataScreenState extends State<MobileRequestDataScreen> {
  String? classValue;
  String? courseValue;
  Map<String, bool> values = {
    'Student1': false,
    'Student2': false,
    'Student3': false,
    'Student4': false,
    'Student5': false,
    'Student6': false,
    'Student7': false,
  };

  @override
  Widget build(BuildContext context) {
    bool startClass = true;

    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.colorPurple,
        title: AppRichTextView(
          title: "Lecturer's Time Sheet",
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
          textColor: AppColors.colorWhite,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.sp)),
                child: SizedBox(
                  height: 100.h,
                  width: size.width,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.colorPurple,
                          radius: 30.sp,
                          child: AppRichTextView(
                            title: "T",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppRichTextView(
                              title: "Dr.Tom",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.colorBlack,
                            ),
                            AppRichTextView(
                              textColor: AppColors.colorGrey,
                              title: "Neurology and Health Science",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            AppRichTextView(
                              textColor: AppColors.colorBlack,
                              title: "Campus Check in Time: 9:00AM",
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.w),
              child: AppRichTextView(
                textColor: AppColors.colorBlack,
                title: "Class",
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
              child: SizedBox(
                width: size.width,
                child: DropdownButton<String>(
                  hint: const Text("Select Class"),
                  isExpanded: true,
                  value: classValue,

                  items: <String>['MD1', 'MD2', 'MD3', 'MD4']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 30.sp),
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (String? newValue) {
                    setState(() {
                      classValue = newValue!;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.w),
              child: AppRichTextView(
                textColor: AppColors.colorBlack,
                title: "Course",
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
              child: SizedBox(
                width: size.width,
                child: DropdownButton<String>(
                  hint: const Text("Select Course"),
                  isExpanded: true,
                  value: courseValue,

                  items: <String>[
                    'anatomy',
                    'health and science',
                    'psycology',
                    'neurology'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 30.sp),
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (String? newValue) {
                    setState(() {
                      courseValue = newValue!;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.w),
              child: AppRichTextView(
                textColor: AppColors.colorBlack,
                title: "Activity",
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: AppTextFormFieldWidget(
                maxLines: 5,
                textStyle: GoogleFonts.oswald(
                    color: AppColors.colorPurple, fontSize: 15.sp),
                inputDecoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Activity Description",
                    hintStyle: GoogleFonts.oswald(
                        color: AppColors.colorGrey, fontSize: 15.sp)),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.w),
              child: AppRichTextView(
                textColor: AppColors.colorBlack,
                title: "Students",
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: values.keys.map((String key) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Card(
                    color: key == "Student6"
                        ? AppColors.colorGrey
                        : AppColors.colorWhite,
                    child: CheckboxListTile(
                      title: Text(key),
                      value: values[key],
                      onChanged: (value) {
                        key == "Student6"
                            ? null
                            : setState(() {
                                values[key] = value!;
                              });
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.w),
              child: const AppRichTextView(
                textColor: AppColors.colorBlack,
                title: "Signature",
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Container(
                height: 160.h,
                decoration: BoxDecoration(border: Border.all()),
                width: size.width,
                child: Signature(
                  color: Colors.black, // Color of the drawing path
                  strokeWidth: 5.0, // with
                  backgroundPainter:
                      null, // Additional custom painter to draw stuff like watermark
                  onSign: null, // Callback called on user pan drawing
                  key:
                      null, // key that allow you to provide a GlobalKey that'll let you retrieve the image once user has signed
                ),
              ),
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        AppElevatedButon(
          title: "Start Class",
          buttonColor:
              startClass == true ? AppColors.colorGrey : AppColors.colorPurple,
          textColor: AppColors.colorWhite,
          onPressed: (context) {},
          height: 35.h,
          width: 160.w,
        ),
        AppElevatedButon(
          title: "Stop Class",
          buttonColor:
              startClass == true ? AppColors.colorPurple : AppColors.colorGrey,
          textColor: AppColors.colorWhite,
          onPressed: (context) {
            Navigator.of(context).push(AppRouter.mobileFeedbackData());
          },
          height: 35.h,
          width: 160.w,
        )
      ],
    );
  }
}
