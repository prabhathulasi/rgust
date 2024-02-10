import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/publish_result_model.dart';
import 'package:rugst_alliance_academia/data/provider/common_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/result_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_elevatedbutton.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';

class PublishResultView extends StatefulWidget {
 final String? resultId;
   const PublishResultView({super.key, this.resultId});

  @override
  State<PublishResultView> createState() => _PublishResultViewState();
}

class _PublishResultViewState extends State<PublishResultView> {
  
  List<int> selectedIDs = [];
  @override
  Widget build(BuildContext context) {
    final programProvider = Provider.of<ProgramProvider>(context);

    return Consumer<CommonProvider>(builder: (context, commonConsumer, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    child: RadioListTile<String>(
                      activeColor: AppColors.colorc7e,
                      title: const Text('All'),
                      value: 'All',
                      groupValue: commonConsumer.selectedOption,
                      onChanged: (value) {
                        commonConsumer.updateSelectedOption(value!);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: RadioListTile<String>(
                      activeColor: AppColors.colorc7e,
                      title: const Text('Except'),
                      value: 'Not ALL',
                      groupValue: commonConsumer.selectedOption,
                      onChanged: (value) {
                        commonConsumer.updateSelectedOption(value!);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          commonConsumer.selectedOption == ""
              ? Padding(
                  padding: EdgeInsets.only(top: 260.0.h),
                  child: const Text("Please Select Any One Option"),
                )
              : commonConsumer.selectedOption == "All"
                  ? Expanded(child: Consumer<ResultProvider>(
                      builder: (context, resultProvider, child) {
                      var data = resultProvider.resultPublishModel.results;

                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppRichTextView(
                              title: "Students",
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.colorc7e,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: _getCategories(data).length,
                                itemBuilder: (context, index) {
                                  final category = _getCategories(data)[index];
                                  return Row(
                                    children: [
                                      AppRichTextView(
                                        title: "${index + 1}. ".toString(),
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      ),
                                      AppRichTextView(
                                        title: category,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                AppElevatedButon(
                                  loading: resultProvider.isLoading,
                                  title: "Publish",
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
        ToastHelper().errorToast("Session Expired Please Login Again");

        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }
      } else {
        var result = await resultProvider.releaseResult(token,
          resultId:  widget.resultId!,
           studentId:  selectedIDs,
          batch: programProvider.selectedBatch!,
          classId: programProvider.selectedClass!,
          programId: programProvider.selectedDept!

            );
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }else if(result == "200"){
       if (context.mounted) {
            Navigator.pop(context);
          }
        }
      }
                                  },
                                  textColor: AppColors.colorWhite,
                                ),
                                AppElevatedButon(
                                  title: "Cancel",
                                  borderColor: AppColors.colorWhite,
                                  buttonColor: AppColors.colorc7e,
                                  height: 50.h,
                                  width: 150.w,
                                  onPressed: (context) {},
                                  textColor: AppColors.colorWhite,
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }))
                  : Expanded(
                      child: Consumer<ResultProvider>(
                          builder: (context, resultProvider, child) {
                        var data = resultProvider.resultPublishModel.results;

                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppRichTextView(
                                title: "Students",
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.colorc7e,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _getCategories(data).length,
                                  itemBuilder: (context, index) {
                                    final category =
                                        _getCategories(data)[index];

                                    final studentIndex =
                                        _getStudentId(data)[index];
                                    return Card(
                                      color: AppColors.colorc7e,
                                      child: CheckboxListTile(
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                          (states) => const BorderSide(
                                              width: 2.0,
                                              color: AppColors.colorWhite),
                                        ),
                                        checkColor: AppColors.colorc7e,
                                        activeColor: AppColors.colorWhite,
                                        title: AppRichTextView(
                                          title: category,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorWhite,
                                        ),
                                        value:
                                            selectedIDs.contains(studentIndex),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value!) {
                                              // Add the selected ID to the list
                                              selectedIDs.add(studentIndex);
                                            } else {
                                              // Remove the ID if the checkbox is unchecked
                                              selectedIDs.remove(studentIndex);
                                            }
                                          });
                                          print(selectedIDs);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                children: [
                                  AppElevatedButon(
                                    title: "Publish",
                                    borderColor: AppColors.colorWhite,
                                    buttonColor: AppColors.colorc7e,
                                    height: 50.h,
                                    width: 150.w,
                                    onPressed: (context) async{
                                      _getStudentId(data);
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
        var result = await resultProvider.releaseResult(token,
          resultId:  widget.resultId!,
           studentId:  selectedIDs,
          batch: programProvider.selectedBatch!,
          classId: programProvider.selectedClass!,
          programId: programProvider.selectedDept!

            );
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }else if(result == "200"){
       if (context.mounted) {
            Navigator.pop(context);
          }
        }
      }
                                    },
                                    textColor: AppColors.colorWhite,
                                  ),
                                  AppElevatedButon(
                                    title: "Cancel",
                                    borderColor: AppColors.colorWhite,
                                    buttonColor: AppColors.colorc7e,
                                    height: 50.h,
                                    width: 150.w,
                                    onPressed: (context) {},
                                    textColor: AppColors.colorWhite,
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                    )
        ],
      );
    });
  }

  List<String> _getCategories(List<Results>? data) {
    return data!.map((item) => item.studentReg!).toSet().toList();
  }

  List<int> _getStudentId(List<Results>? data) {
    return data!.map((item) => item.studentId!).toSet().toList();
  }
}
