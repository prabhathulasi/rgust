import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_provider.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
class ApplicationRecommenationView extends StatefulWidget {
  const ApplicationRecommenationView({super.key});

  @override
  State<ApplicationRecommenationView> createState() => _ApplicationRecommenationViewState();
}

class _ApplicationRecommenationViewState extends State<ApplicationRecommenationView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdmissionProvider>(
      builder: (context, admissionConsumer, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 150.w),
          child: Column(
            children: [
               Center(
                    child: AppRichTextView(
                      title: "Letter of Recommendation",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(
                    color: AppColors.colorBlack,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
        
                  Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AppRichTextView(
                        title: "#",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppRichTextView(
                        title: "Profession/Faculty",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppRichTextView(
                        title: "Member Position",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                 
                    Expanded(
                      flex: 1,
                      child: AppRichTextView(
                        title: "Work Phone",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppRichTextView(
                        title: "Email",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
        
        SizedBox(height: 15.h,),
                Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: "1",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: admissionConsumer
                                  .admissionDetailModel.data!.referenceName!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: admissionConsumer
                                  .admissionDetailModel.data!.referenceProfession!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: admissionConsumer
                                  .admissionDetailModel.data!.referencePhone!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: AppRichTextView(
                              title: admissionConsumer
                                  .admissionDetailModel.data!.referenceEmail!,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        
                        ],
                      ),
                      SizedBox(height: 15.h,)
            ],
          ),
        );
      }
    );
  }
}