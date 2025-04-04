import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_criminal_check_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_login_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CriminalCheckForm extends StatelessWidget {
  final PageController pageController;
  const CriminalCheckForm({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Consumer<AdmissionCriminalCheckProvider>(
        builder: (context, admissionCriminalCheckConsumer, child) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImagePath.webrgustLogo, width: size.width * 0.08),
                  SizedBox(
                    width: 15.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                          title:
                              "Rajiv Gandhi University of Science and Technology"
                                  .toUpperCase(),
                          fontSize: size.width * 0.02,
                          fontWeight: FontWeight.bold),
                      AppRichTextView(
                        fontStyle: FontStyle.italic,
                        title: "A Brand for Quality Eduation",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppRichTextView(
                      title: "Criminal Background Check Authorization",
                      textColor: AppColors.colorc7e,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    width: size.width * 0.2,
                    child: LinearProgressIndicator(
                      backgroundColor: AppColors.colorGrey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.sp),
                      color: AppColors.colorc7e,
                      minHeight: 15.sp,
                      value: 0.9,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              AppRichTextView(
                  maxLines: 3,
                  title:
                      "I hereby authorize the Rajiv Gandhi University of Science and Technology to receive the following in connection with the program checked\nabove: -",
                  textColor: AppColors.colorBlack,
                  fontSize: size.width * 0.012,
                  fontWeight: FontWeight.w400),
              SizedBox(
                height: 15.h,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: admissionCriminalCheckConsumer.dataList.length,
                itemBuilder: (context, index) => CheckboxListTile(
                  activeColor: AppColors.colorc7e,
                  value: admissionCriminalCheckConsumer.dataList[index]
                      ["isChecked"],
                  onChanged: (value) {
                    admissionCriminalCheckConsumer.setCheckboxValue(
                        value!, index);
                  },
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
              AppRichTextView(
                  maxLines: 3,
                  title:
                      "I hereby further release to Rajiv Gandhi University of Science and Technology at Guyana, its agents, officers, board, and employees from all\nclaims, including but not limited to, claims of demotion, invasion of privacy, wrongful dismissal, negligence, or any other damage of or\nresulting from or pertaining to the collection of this information checked above.",
                  textColor: AppColors.colorBlack,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400),
              SizedBox(
                height: 15.h,
              ),
              admissionCriminalCheckConsumer.areAllCheckboxesSelected()
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // AppElevatedButon(
                        //   borderColor: AppColors.colorc7e,
                        //   title: "Back",
                        //   buttonColor: AppColors.colorWhite,
                        //   onPressed: (context) {
                        //     pageController.previousPage(
                        //         duration: const Duration(milliseconds: 1000),
                        //         curve: Curves.easeOut);
                        //   },
                        //   textColor: AppColors.colorc7e,
                        //   height: 50.h,
                        //   width: 120.w,
                        // ),
                        Consumer<AdmissionLoginProvider>(
                            builder: (context, admissionLoginConsumer, child) {
                          return AppElevatedButon(
                            title: "Save & Continue",
                            buttonColor: AppColors.colorc7e,
                            onPressed: (context) async {
                              var applicationId =
                                  admissionLoginConsumer.applicationId;
                              var response =
                                  await admissionCriminalCheckConsumer
                                      .postAdmissionCriminalCheckDetails(
                                          int.parse(applicationId!));
                              if (response.statusCode == 201) {
                                pageController.nextPage(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.easeIn);
                              } else {
                                ToastHelper()
                                    .errorToast(response.body.toString());
                              }
                            },
                            textColor: AppColors.colorWhite,
                            height: 50.h,
                            width: 200.w,
                          );
                        }),
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      );
    });
  }
}
