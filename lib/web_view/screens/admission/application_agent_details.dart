import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationAgentDetails extends StatefulWidget {
  const ApplicationAgentDetails({super.key});

  @override
  State<ApplicationAgentDetails> createState() =>
      _ApplicationAgentDetailsState();
}

class _ApplicationAgentDetailsState extends State<ApplicationAgentDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdmissionProvider>(
        builder: (context, admissionConsumer, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 150.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AppRichTextView(
                title: "Agent Details",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              color: AppColors.colorBlack,
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 15.h,
            ),
            AppRichTextView(
              title: "Are you applying through an RGUST authorized agent?",
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 5.h,
            ),
            AppRichTextView(
              title:
                  admissionConsumer.admissionDetailModel.data!.agentName!.isEmpty
                      ? "No"
                      : "Yes",
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: 15.h,
            ),
          admissionConsumer.admissionDetailModel.data!.agentName!.isEmpty
                      ? Container():  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "Agent Name",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title: admissionConsumer
                            .admissionDetailModel.data!.agentName!,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "Agent Email",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title: admissionConsumer
                            .admissionDetailModel.data!.agentEmail!,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "Counselor Name",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title: admissionConsumer
                            .admissionDetailModel.data!.counselorName!,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
           admissionConsumer.admissionDetailModel.data!.agentName!.isEmpty
                      ? Container(): Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "Agent Address",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title: admissionConsumer
                            .admissionDetailModel.data!.agentAddress!,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(
              height: 15.h,
            ),
          ],
        ),
      );
    });
  }
}
