import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_login_provider.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission_form/admission_pages/agent_details_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission_form/admission_pages/criminal_check_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission_form/admission_pages/education_details_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission_form/admission_pages/eng_proficiency_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission_form/admission_pages/job_details_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission_form/admission_pages/payment_details_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission_form/admission_pages/personal_detail_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission_form/admission_pages/program_details_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission_form/admission_pages/recommendation_form.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission_form/admission_pages/standardized_test_form.dart';


class AdmissionFormPages extends StatefulWidget {
  const AdmissionFormPages({super.key, });

  @override
  State<AdmissionFormPages> createState() => _AdmissionFormPagesState();
}

class _AdmissionFormPagesState extends State<AdmissionFormPages> {


  

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height,
      child: Consumer<AdmissionLoginProvider>(
        builder: (context, admissionLoginConsumer, child) {
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            allowImplicitScrolling: true,
            scrollDirection: Axis.vertical,
            controller: admissionLoginConsumer.pageController,
            children: [
              PersonalDetailForm(
                pageController: admissionLoginConsumer.pageController
              ),
              ProgramDetailsForm(
                pageController: admissionLoginConsumer.pageController
              ),
              AgentDetailsForm(
                pageController: admissionLoginConsumer.pageController
              ),
              EducationDetailsForm(
                pageController: admissionLoginConsumer.pageController
              ),
              JobDetailsForm(
                pageController: admissionLoginConsumer.pageController
              ),
              EngProficiencyForm(
                pageController: admissionLoginConsumer.pageController
              ),
              StandardizedTestForm(
                pageController: admissionLoginConsumer.pageController
              ),
              RecommendationForm(
                pageController: admissionLoginConsumer.pageController
              ),
              CriminalCheckForm(
                pageController: admissionLoginConsumer.pageController
              ),
              PaymentDetailsForm(pageController: admissionLoginConsumer.pageController,)
            ],
          );
        }
      ),
    );
  }
}
