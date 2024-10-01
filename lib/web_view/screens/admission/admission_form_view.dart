import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_agent_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_education_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_eng_proficieny_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_job_provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_personal_provider.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_pages/agent_details_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_pages/criminal_check_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_pages/education_details_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_pages/eng_proficiency_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_pages/job_details_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_pages/personal_detail_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_pages/program_details_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_pages/recommendation_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/admission_pages/standardized_test_form.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class AdmissionFormView extends StatefulWidget {
  const AdmissionFormView({super.key});

  @override
  State<AdmissionFormView> createState() => _AdmissionFormViewState();
}

final _pageController = PageController(
  initialPage: 0,
  viewportFraction: 1.0,
);

class _AdmissionFormViewState extends State<AdmissionFormView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 28.w, vertical: 18.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(ImagePath.webrgustLogo,
                    width: size.width * 0.08),
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
            Center(
              child: AppRichTextView(
                  title: "application form".toUpperCase(),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width * 0.07,
                ),
                AppRichTextView(
                  textColor: AppColors.colorRed,
                  title:
                      "We encourage you to use our secure electronic application form and submit it through our website ",
                  fontSize: size.width * 0.013,
                  fontWeight: FontWeight.w500,
                ),
                AppRichTextView(
                  textDecoration: TextDecoration.underline,
                  textColor: AppColors.color4ff,
                  title: "www.rgust.edu.gy",
                  fontSize: size.width * 0.013,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            AppRichTextView(
              maxLines: 4,
              title:
                  "By using the electronic application form you will be able to save and change your application easily and as often as you like before submitting it.\nYou will also be able to save and print your application and be sure we have received it. You will be able to track the status of your application and\nsave generic information about yourself and your qualifications, which will save you time if you want to apply for more than one program. To submit\nyour online application, you will need to provide scanned copies of your qualifications.",
              fontSize: size.width * 0.012,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 10.h,),
      
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                allowImplicitScrolling: true,
                scrollDirection: Axis.vertical,
                controller: _pageController,
                children:  [
                  PersonalDetailForm(pageController: _pageController,),
                  ProgramDetailsForm(pageController: _pageController,),
                  AgentDetailsForm(pageController: _pageController,),
                  EducationDetailsForm(pageController: _pageController,),
                  JobDetailsForm(pageController: _pageController,),
                  EngProficiencyForm(pageController: _pageController,),
                  StandardizedTestForm(pageController: _pageController,),
                  RecommendationForm(pageController: _pageController,),
                  CriminalCheckForm(pageController: _pageController,)
                
               
                ],
              ),
            ),
      
        
          
          
          ],
        ),
      ),
   
    );
  }
}
