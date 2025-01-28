import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/application_agent_details.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/application_background_check_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/application_contact_details.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/application_education_details.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/application_eng_prof_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/application_job_details.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/application_payment_details.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/application_personal_detail.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/application_program_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/application_recommenation_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/admission/application_stand_test.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class AdmissionDetailView extends StatefulWidget {
  final int applicantId;
  const AdmissionDetailView({super.key, required this.applicantId});

  @override
  State<AdmissionDetailView> createState() => _AdmissionDetailViewState();
}

class _AdmissionDetailViewState extends State<AdmissionDetailView> {
  @override
  Widget build(BuildContext context) {
    final admissionProvider =
        Provider.of<AdmissionProvider>(context, listen: false);

    Future getAdmissionDetail() async {
      var token = await getTokenAndUseIt();
      if (token == null) {
        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }
      } else if (token == "Token Expired") {
        ToastHelper().errorToast("Session Expired Please Login Again");

        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }
      } else {
        var result = await admissionProvider.getApplicantDetailById(
            widget.applicantId, token);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: FutureBuilder(
          future: getAdmissionDetail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: SpinKitSpinningLines(
                color: AppColors.colorc7e,
              ));
            } else {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Consumer<AdmissionProvider>(
                    builder: (context, admissionConsumer, child) {
                      log(  admissionConsumer.admissionDetailModel.data!
                                        .applicationStatus.toString());
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                        SizedBox(
                          height: 20.h,
                        ),
                        Center(
                          child: AppRichTextView(
                            fontStyle: FontStyle.italic,
                            title: "University Digital Admission Form",
                            fontSize: 23.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        admissionConsumer.admissionDetailModel.data!
                                        .applicationStatus ==
                                    0 ||
                                admissionConsumer.admissionDetailModel.data!
                                        .applicationStatus! >=
                                    0
                            ? const ApplicantPersonalDetail()
                            : Container(),
                        admissionConsumer.admissionDetailModel.data!
                                        .applicationStatus ==
                                    1 ||
                                admissionConsumer.admissionDetailModel.data!
                                        .applicationStatus! >=
                                    1?    const ApplicationProgramView():Container(),

                        admissionConsumer.admissionDetailModel.data!
                                        .applicationStatus ==
                                    2 ||
                                admissionConsumer.admissionDetailModel.data!
                                        .applicationStatus! >=
                                    2
                            ? const ApplicationContactDetails()
                            : Container(),

                        admissionConsumer.admissionDetailModel.data!
                                        .applicationStatus ==
                                    3 ||
                                admissionConsumer.admissionDetailModel.data!
                                        .applicationStatus! >=3
                            ? const ApplicationAgentDetails()
                            : Container(),


                        admissionConsumer.admissionDetailModel.data!
                                        .applicationStatus ==
                                    4 ||
                                admissionConsumer.admissionDetailModel.data!
                                        .applicationStatus! >=
                                    4
                            ? const ApplicationEducationDetails()
                            : Container(),


                        admissionConsumer.admissionDetailModel.data!
                                        .applicationStatus ==
                                    5 ||
                                admissionConsumer.admissionDetailModel.data!
                                        .applicationStatus! >=
                                    5
                            ? const ApplicationJobDetails()
                            : Container(),

                       admissionConsumer.admissionDetailModel.data!.applicationStatus == 6 ||admissionConsumer.admissionDetailModel.data!.applicationStatus! >=6 ?    const ApplicationEngProfView():Container(),
                        admissionConsumer.admissionDetailModel.data!.applicationStatus == 7 ||admissionConsumer.admissionDetailModel.data!.applicationStatus! >=7 ?   const ApplicationEngStandView():Container(),
                         admissionConsumer.admissionDetailModel.data!.applicationStatus == 8 ||admissionConsumer.admissionDetailModel.data!.applicationStatus! >=8 ?  const ApplicationRecommenationView():Container(),
                       admissionConsumer.admissionDetailModel.data!.applicationStatus == 9 ||admissionConsumer.admissionDetailModel.data!.applicationStatus! >=9 ?    const ApplicationBackgroundCheckView():Container(),
                         admissionConsumer.admissionDetailModel.data!.applicationStatus == 10 ?  const ApplicationPaymentDetails():Container()
                      ],
                    ),
                  );
                }),
              );
            }
          }),
    );
  }
}
