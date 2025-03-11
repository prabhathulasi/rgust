import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/admission_provider/admission_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/admin_view/admission/admission_detail_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdmissionListView extends StatefulWidget {
  const AdmissionListView({super.key});

  @override
  State<AdmissionListView> createState() => _AdmissionListViewState();
}

class _AdmissionListViewState extends State<AdmissionListView> {
  @override
  Widget build(BuildContext context) {
    final admissionProvider =
        Provider.of<AdmissionProvider>(context, listen: false);

    Future getAdmissionList() async {
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
        var result = await admissionProvider.getAdmissionList(token);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    showDetailAlertDialog(BuildContext context, int applicantId) {
      // set up the AlertDialog
      Dialog alert = Dialog(
        child: StatefulBuilder(builder: (context, setState) {
          return Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            color: AppColors.colorWhite,
            child: Stack(
              children: [
                AdmissionDetailView(
                  applicantId: applicantId,
                ),
                Transform.translate(
                  offset: Offset(10.w, -13.h),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 14.0.sp,
                          backgroundColor: AppColors.colorc7e,
                          child: CircleAvatar(
                              radius: 12.sp,
                              backgroundColor: AppColors.colorWhite,
                              child: const Icon(Icons.close,
                                  color: AppColors.colorRed)),
                        ),
                      )),
                )
              ],
            ),
          );
        }),
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
        body: FutureBuilder(
            future: getAdmissionList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: SpinKitSpinningLines(color: AppColors.colorc7e));
              } else {
                return Consumer<AdmissionProvider>(
                    builder: (context, admissionConsumer, child) {
                  if (admissionConsumer.admissionListModel.data == null) {
                    return const Center(
                      child: Text('No Admission List'),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: admissionConsumer
                                .admissionListModel.data!.length,
                            itemBuilder: (context, index) {
                              var applicationImage = admissionConsumer
                                  .admissionListModel.data![index];
                              var memoryImagedata =
                                  base64Decode(applicationImage.photo!);

                              if (admissionConsumer.admissionListModel
                                      .data![index].applicationStatus ==
                                  0) {
                                return Card(
                                  child: ListTile(
                                  
                                    leading: CircleAvatar(),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        AppRichTextView(
                                          maxLines: 2,
                                          title: "Email:",
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          textColor: AppColors.colorBlack,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            admissionProvider.mailto(
                                                applicationImage.emailAddress!);
                                          },
                                          child: AppRichTextView(
                                            maxLines: 2,
                                            title:applicationImage.emailAddress!,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            textColor: AppColors.colorBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: AppRichTextView(
                                      maxLines: 2,
                                      title: "Started Filling Application",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      textColor: AppColors.colorRed,
                                    ),
                                  ),
                                );
                              } else {
                                return InkWell(
                                  onTap: () async {
                                    showDetailAlertDialog(
                                        context, applicationImage.iD!);
                                  },
                                  child: Card(
                                    child: ListTile(
                                      isThreeLine: true,
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            MemoryImage(memoryImagedata),
                                      ),
                                      title: AppRichTextView(
                                        maxLines: 2,
                                        title:
                                            "${applicationImage.firstName!} ${applicationImage.lastName!}",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorc7e,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppRichTextView(
                                            maxLines: 2,
                                            title:
                                                "Location ${applicationImage.birthCountry!}",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            textColor: AppColors.colorBlack,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              AppRichTextView(
                                                maxLines: 2,
                                                title: "Email: ",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                textColor: AppColors.colorBlack,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  admissionProvider.mailto(
                                                      applicationImage
                                                          .emailAddress!);
                                                },
                                                child: AppRichTextView(
                                                  maxLines: 2,
                                                  title: applicationImage
                                                      .emailAddress!,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  textColor:
                                                      AppColors.colorBlack,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing:
                                          const Icon(Icons.arrow_forward_ios),
                                    ),
                                  ),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  );
                });
              }
            }));
  }
}
