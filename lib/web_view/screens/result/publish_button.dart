import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/result_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/result/publish_result.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class PublishButton extends StatefulWidget {
  const PublishButton({super.key});

  @override
  State<PublishButton> createState() => _PublishButtonState();
}

class _PublishButtonState extends State<PublishButton> {
  @override
  Widget build(BuildContext context) {

     showPublishDialgue(BuildContext context) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: SizedBox(
          width: MediaQuery.sizeOf(context).width / 2,
          height: MediaQuery.sizeOf(context).height / 1.5,
          child: const PublishResultView()),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
    final programProvider = Provider.of<ProgramProvider>(context);
    final resultProvider = Provider.of<ResultProvider>(context, listen: false);
    Future getApproval() async {
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
        var result = await resultProvider.getApprovalData(token,
            batch: programProvider.selectedBatch,
            classId: programProvider.selectedClass,
            programId: programProvider.selectedDept);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    return FutureBuilder(
      future: getApproval(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SpinKitSpinningLines(color: AppColors.colorc7e),
          );
        } else {
          return Consumer<ResultProvider>(
              builder: (context, resultConsumer, child) {
            if (resultConsumer.approvalModel.userType == "COE") {
              if (resultConsumer.approvalModel.approvalData!.isEmpty) {
                return AppElevatedButon(
                  title: "Upload",
                  borderColor: AppColors.colorWhite,
                  buttonColor: AppColors.colorc7e,
                  height: 50.h,
                  width: 150.w,
                  loading: resultConsumer.isLoading,
                  onPressed: (context) async {
                    var token = await getTokenAndUseIt();
                    if (token == null) {
                      if (context.mounted) {
                        Navigator.pushNamed(context, RouteNames.login);
                      }
                    } else if (token == "Token Expired") {
                      ToastHelper()
                          .errorToast("Session Expired Please Login Again");

                      if (context.mounted) {
                        Navigator.pushNamed(context, RouteNames.login);
                      }
                    } else {
                      var result = await resultProvider.createApproval(token,
                          batch: programProvider.selectedBatch,
                          classId: programProvider.selectedClass,
                          programId: programProvider.selectedDept);

                      if (result == "Invalid Token") {
                        ToastHelper()
                            .errorToast("Session Expired Please Login Again");
                        if (context.mounted) {
                          Navigator.pushNamed(context, RouteNames.login);
                        }
                      }
                    }
                  },
                  textColor: AppColors.colorWhite,
                );
              } else if (resultConsumer.approvalModel.approvalData![3].status ==
                  "Published") {
                return AppRichTextView(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  title: "Result Already Published",
                  textColor: AppColors.colorRed,
                );
              } else if (resultConsumer.approvalModel.approvalData![1].status ==
                      "Approved" &&
                  resultConsumer.approvalModel.approvalData![2].status ==
                      "Approved") {
                return AppElevatedButon(
                  title: "Publish",
                  borderColor: AppColors.colorWhite,
                  buttonColor: AppColors.colorc7e,
                  height: 50.h,
                  width: 150.w,
                  onPressed: (context) {
                  showPublishDialgue(context);
                  },
                  textColor: AppColors.colorWhite,
                );
              } else {
                return AppRichTextView(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  title: "Waiting for the Approval",
                  textColor: AppColors.colorRed,
                );
              }
            } else if (resultConsumer.approvalModel.userType ==
                "Assistant Dean") {
              if (resultConsumer.approvalModel.approvalData!.isEmpty) {
                return AppRichTextView(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  title: "Result Not Uploaded Yet",
                  textColor: AppColors.colorRed,
                );
              } else if (resultConsumer
                      .approvalModel.approvalData!.isNotEmpty &&
                  resultConsumer.approvalModel.approvalData![1].status !=
                      "Approved") {
                return AppElevatedButon(
                  title: "Approve",
                  borderColor: AppColors.colorWhite,
                  buttonColor: AppColors.colorc7e,
                  height: 50.h,
                  width: 150.w,
                  onPressed: (context) async {
                    var token = await getTokenAndUseIt();
                    if (token == null) {
                      if (context.mounted) {
                        Navigator.pushNamed(context, RouteNames.login);
                      }
                    } else if (token == "Token Expired") {
                      ToastHelper()
                          .errorToast("Session Expired Please Login Again");

                      if (context.mounted) {
                        Navigator.pushNamed(context, RouteNames.login);
                      }
                    } else {
                     
                      var result = await resultProvider.approveResult(token,
                      resultId: resultConsumer.approvalModel.approvalData![1].resultId!,
                      userLevel: 2,
                      batch: programProvider.selectedBatch!,
                      classId: programProvider.selectedClass!,
                      programId: programProvider.selectedDept!
                       );

                      if (result == "Invalid Token") {
                        ToastHelper()
                            .errorToast("Session Expired Please Login Again");
                        if (context.mounted) {
                          Navigator.pushNamed(context, RouteNames.login);
                        }
                      }
                    }
                  },
                  textColor: AppColors.colorWhite,
                );
              } else if (resultConsumer
                      .approvalModel.approvalData!.isNotEmpty &&
                  resultConsumer.approvalModel.approvalData![1].status ==
                      "Approved") {
                return AppRichTextView(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  title: "Already Approved",
                  textColor: AppColors.colorRed,
                );
              } else {
                return Container();
              }
            } else if (resultConsumer.approvalModel.userType == "Dean") {
              if (resultConsumer.approvalModel.approvalData!.isEmpty) {
                return AppRichTextView(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  title: "Result Not Uploaded Yet",
                  textColor: AppColors.colorRed,
                );
              } else if (resultConsumer
                      .approvalModel.approvalData!.isNotEmpty &&
                  resultConsumer.approvalModel.approvalData![1].status !=
                      "Approved") {
                return AppRichTextView(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  title: "Waiting for the Approval",
                  textColor: AppColors.colorRed,
                );
              } else if (resultConsumer
                      .approvalModel.approvalData!.isNotEmpty &&
                  resultConsumer.approvalModel.approvalData![2].status ==
                      "Approved") {
                return AppRichTextView(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  title: "Already Approved",
                  textColor: AppColors.colorRed,
                );
              }else {
                return AppElevatedButon(
                  title: "Approve",
                  borderColor: AppColors.colorWhite,
                  buttonColor: AppColors.colorc7e,
                  height: 50.h,
                  width: 150.w,
                  onPressed: (context) async{
                      var token = await getTokenAndUseIt();
                    if (token == null) {
                      if (context.mounted) {
                        Navigator.pushNamed(context, RouteNames.login);
                      }
                    } else if (token == "Token Expired") {
                      ToastHelper()
                          .errorToast("Session Expired Please Login Again");

                      if (context.mounted) {
                        Navigator.pushNamed(context, RouteNames.login);
                      }
                    } else {
                     
                      var result = await resultProvider.approveResult(token,
                      resultId: resultConsumer.approvalModel.approvalData![2].resultId!,
                      userLevel: 3,
                      batch: programProvider.selectedBatch!,
                      classId: programProvider.selectedClass!,
                      programId: programProvider.selectedDept!
                       );

                      if (result == "Invalid Token") {
                        ToastHelper()
                            .errorToast("Session Expired Please Login Again");
                        if (context.mounted) {
                          Navigator.pushNamed(context, RouteNames.login);
                        }
                      }
                    }
                    // showPublishDialgue(context);
                  },
                  textColor: AppColors.colorWhite,
                );
              }
            }  else {
              return Container();
            }
          });
        }
      },
    );
  }
}
