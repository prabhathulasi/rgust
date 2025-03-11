import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_login_provider.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/application_form/application_pages/mobile_application_agent_detail.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/application_form/application_pages/mobile_application_criminal_check.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/application_form/application_pages/mobile_application_edu_detail.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/application_form/application_pages/mobile_application_eng_prof_detail.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/application_form/application_pages/mobile_application_job_detail.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/application_form/application_pages/mobile_application_payment_detail.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/application_form/application_pages/mobile_application_personal_detail.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/application_form/application_pages/mobile_application_recom_detail.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/application_form/application_pages/mobile_application_stand_test_detail.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/application_form/mobile_application_program_detail.dart';



class MobileApplicationFormPages extends StatefulWidget {
  const MobileApplicationFormPages({super.key});

  @override
  State<MobileApplicationFormPages> createState() =>
      _MobileApplicationFormPagesState();
}

class _MobileApplicationFormPagesState
    extends State<MobileApplicationFormPages> {
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
            MobileApplicationPersonalDetail(
                pageController: admissionLoginConsumer.pageController),
            MobileApplicationProgramDetail(
                pageController: admissionLoginConsumer.pageController),
            MobileApplicationAgentDetail(
                pageController: admissionLoginConsumer.pageController),
            MobileApplicationEduDetail(
                pageController: admissionLoginConsumer.pageController),
            MobileApplicationJobDetail(
                pageController: admissionLoginConsumer.pageController),
            MobileApplicationEngProfDetail(
                pageController: admissionLoginConsumer.pageController),
            MobileApplicationStandTestDetail(
                pageController: admissionLoginConsumer.pageController),
            MobileApplicationRecomDetail(
                pageController: admissionLoginConsumer.pageController),
            MobileApplicationCriminalCheckDetail(
                pageController: admissionLoginConsumer.pageController),
            MobileApplicationPaymentDetail(
              pageController: admissionLoginConsumer.pageController,
            )
          ],
        );
      }),
    );
  }
}
