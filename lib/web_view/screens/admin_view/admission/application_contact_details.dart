import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationContactDetails extends StatefulWidget {
  const ApplicationContactDetails({super.key});

  @override
  State<ApplicationContactDetails> createState() =>
      _ApplicationContactDetailsState();
}

class _ApplicationContactDetailsState extends State<ApplicationContactDetails> {
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
                  title: "Contact Details",
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
          
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "Email",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title:
                            admissionConsumer.admissionDetailModel.data!.emailAddress!,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppRichTextView(
                        title: "Telephone",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppRichTextView(
                        title: admissionConsumer
                            .admissionDetailModel.data!.contactNumber!,
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
            AppRichTextView(
              title: "Permanent Address",
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 5.h,
            ),
            AppRichTextView(
              title: admissionConsumer.admissionDetailModel.data!.homeAddress!,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),


             SizedBox(
              height: 15.h,
            ),
            AppRichTextView(
              title: "Mailing Address",
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 5.h,
            ),
            AppRichTextView(
              title: admissionConsumer.admissionDetailModel.data!.mailingAddress!,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
              SizedBox(
              height: 15.h,
            ),
            ],
          ),
        );
      }
    );
  }
}
