import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/clincial_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/update_student_details/alerts/clinical_fee_alert.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class ClinicalList extends StatefulWidget {
  const ClinicalList({super.key});

  @override
  State<ClinicalList> createState() => _ClinicalListState();
}

class _ClinicalListState extends State<ClinicalList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProgramProvider>(
        builder: (context, programConsumer, child) {
      return Consumer<ClincialProvider>(
          builder: (context, clinicalConsumer, child) {
            if(programConsumer.isLoading == true){
              return const Center(
                child: SpinKitSpinningLines(color: AppColors.colorc7e
                ,
              ));
            }else{
 return Column(
          children: [
            AppRichTextView(
              title: "Clinical Courses",
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              textColor: AppColors.colorc7e,
            ),
            SizedBox(
              height: 15.h,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: programConsumer.clinicalCoursesModel.clinicals!.length,
              itemBuilder: (context, index) {
                var currentItem =
                    programConsumer.clinicalCoursesModel.clinicals![index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.colorc7e, width: 3.w),
                        borderRadius: BorderRadius.circular(8.sp)),
                    child: ListTile(
                      dense: true,
                      trailing: clinicalConsumer.clincalFees != null &&
                              clinicalConsumer.selectedClinicalRadio ==
                                  currentItem.iD
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        builder: (context, child) {
                                          return Theme(
                                              data: ThemeData.dark().copyWith(
                                                colorScheme:
                                                    const ColorScheme.dark(
                                                  primary: AppColors.colorc7e,
                                                  onPrimary: Colors.white,
                                                  surface: AppColors.colorWhite,
                                                  onSurface: AppColors.colorc7e,
                                                ),
                                                dialogBackgroundColor:
                                                    AppColors.colorc7e,
                                              ),
                                              child: child!);
                                        },
                                        barrierDismissible: false,
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(
                                            1900), //- not to allow to choose before today.
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 91)));

                                    if (pickedDate != null) {
                                      //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      clinicalConsumer
                                          .setClinicalStartDate(formattedDate);
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      const Icon(Icons.calendar_month),
                                      Expanded(
                                        child: AppRichTextView(
                                          title: clinicalConsumer
                                                      .clincalStartDate ==
                                                  null
                                              ? "Start Date"
                                              : clinicalConsumer
                                                  .clincalStartDate!,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                clinicalConsumer.clincalStartDate == null
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  builder: (context, child) {
                                                    return Theme(
                                                        data: ThemeData.dark()
                                                            .copyWith(
                                                          colorScheme:
                                                              const ColorScheme
                                                                  .dark(
                                                            primary: AppColors
                                                                .colorc7e,
                                                            onPrimary:
                                                                Colors.white,
                                                            surface: AppColors
                                                                .colorWhite,
                                                            onSurface: AppColors
                                                                .colorc7e,
                                                          ),
                                                          dialogBackgroundColor:
                                                              AppColors
                                                                  .colorc7e,
                                                        ),
                                                        child: child!);
                                                  },
                                                  barrierDismissible: false,
                                                  context: context,
                                                  initialDate: DateTime.parse(
                                                      clinicalConsumer
                                                          .clincalStartDate!),
                                                  firstDate: DateTime.parse(
                                                      clinicalConsumer
                                                          .clincalStartDate!), //- not to allow to choose before today.
                                                  lastDate: DateTime.now().add(
                                                      const Duration(
                                                          days: 91)));

                                          if (pickedDate != null) {
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                            clinicalConsumer.setClinicalendDate(
                                                formattedDate);

                                            //pickedDate output format => 2021-03-10 00:00:00.000
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            const Icon(Icons.calendar_month),
                                            Expanded(
                                              child: AppRichTextView(
                                                title: clinicalConsumer
                                                            .clincalEndDate ==
                                                        null
                                                    ? "End Date"
                                                    : clinicalConsumer
                                                        .clincalEndDate!,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                textColor: AppColors.colorRed,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                              ],
                            )
                          : const SizedBox(),
                      isThreeLine: true,
                      title: Row(
                        children: [
                          AppRichTextView(
                            title: currentItem.rotationName!.trim(),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.colorc7e,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          clinicalConsumer.clincalFees != null &&
                                  clinicalConsumer.selectedClinicalRadio ==
                                      currentItem.iD
                              ? AppRichTextView(
                                  title:
                                      "(${clinicalConsumer.clincalFees} USD)",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  textColor: AppColors.colorc7e,
                                )
                              : const SizedBox(),
                          SizedBox(
                            width: 3.w,
                          ),
                          clinicalConsumer.clincalFees != null &&
                                  clinicalConsumer.selectedClinicalRadio ==
                                      currentItem.iD
                              ? InkWell(
                                  onTap: () async {
                                    await showClinicalFeeAlert(
                                        context,
                                        clinicalConsumer
                                            .selectedClinicalRadio!);
                                  },
                                  child: AppRichTextView(
                                    title:
                                        clinicalConsumer.clinicalFeeRadioValue!,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    textColor: clinicalConsumer
                                                .clinicalFeeRadioValue ==
                                            "Paid"
                                        ? AppColors.color582
                                        : Colors.red,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppRichTextView(
                              title:
                                  "Duration: ${currentItem.rotationDuration!} Weeks",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              textColor: AppColors.colorc7e,
                            ),
                            AppRichTextView(
                              title: "Credits: ${currentItem.rotationCredits!}",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              textColor: AppColors.colorc7e,
                            ),
                          ]),
                      leading: Radio<int>(
                          activeColor: AppColors.colorc7e,
                          value: currentItem.iD!,
                          groupValue: clinicalConsumer.selectedClinicalRadio,
                          onChanged: (value) async {
                            await showClinicalFeeAlert(context, value!);
                          }),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        );
            }
       
      });
    });
  }
}
