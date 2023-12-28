import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/custom_plugin/editable.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/result_provider.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class UpdateResultView extends StatefulWidget {
  final int? studenId;
  const UpdateResultView({super.key, this.studenId});

  @override
  State<UpdateResultView> createState() => _UpdateResultViewState();
}

class _UpdateResultViewState extends State<UpdateResultView> {
  final _editableKey = GlobalKey<EditableState>();
  List rows = [];
  List cols = [
    {
      "title": 'Course Name',
      'widthFactor': 0.2,
      'key': 'coursename',
      'editable': false
    },
    {
      "title": 'Course Code',
      'widthFactor': 0.2,
      'key': 'coursecode',
      'editable': false
    },
    {"title": 'Batch', 'widthFactor': 0.2, 'key': 'batch', 'editable': false},
    {"title": 'CW1', 'widthFactor': 0.1, 'key': 'cw1'},
    {"title": 'CW2', 'widthFactor': 0.1, 'key': 'cw2'},
    {"title": 'CW3', 'widthFactor': 0.1, 'key': 'cw3'},
    {"title": 'CW4', 'widthFactor': 0.1, 'key': 'cw4'},
    {"title": 'Final Exam', 'widthFactor': 0.2, 'key': 'finalexam'},
    {"title": 'Grade', 'widthFactor': 0.1, 'key': 'grade'},
  ];

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(
      context,
    );
    final resultProvider = Provider.of<ResultProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.colorc7e,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Editable(
              key: _editableKey,
              showRemoveIcon: false,
              columns: cols,
              rows: studentProvider.editResult,
              zebraStripe: true,
              stripeColor1: Colors.blue[50]!,
              stripeColor2: Colors.grey[200]!,
              onRowSaved: (value) async {
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
                  var index = value["row"];

                  print(value);
                  var result = await resultProvider.updateExamresult(
                      token, studentProvider.editResult[index]["id"], {
                    "CW1": value["cw1"] ??
                        studentProvider.editResult[index]["cw1"].toString(),
                    "CW2": value["cw2"] ??
                        studentProvider.editResult[index]["cw2"].toString(),
                    "CW3": value["cw3"] ??
                        studentProvider.editResult[index]["cw3"].toString(),
                    "CW4": value["cw4"] ??
                        studentProvider.editResult[index]["cw4"].toString(),
                    "FinalExam": value["finalexam"] ??
                        studentProvider.editResult[index]["finalexam"]
                            .toString(),
                    "Grade": value["grade"] ??
                        studentProvider.editResult[index]["grade"],
                  });
                  if (result == 200) {
                    await studentProvider.getStudentResult(
                        token, widget.studenId!);
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  }
                }
              },
              onSubmitted: (value) {
                print(value);
              },
              borderColor: Colors.blueGrey,
              tdStyle: const TextStyle(fontWeight: FontWeight.bold),
              trHeight: 40.h,
              removeIconColor: AppColors.colorRed,
              thStyle: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorWhite),
              thAlignment: TextAlign.center,
              thVertAlignment: CrossAxisAlignment.end,
              thPaddingBottom: 3,
              showSaveIcon: true,
              saveIconColor: AppColors.colorWhite,
              showCreateButton: false,
              tdAlignment: TextAlign.left,
              tdEditableMaxLines: 100, // don't limit and allow data to wrap
              tdPaddingTop: 0,
              tdPaddingBottom: 14,
              tdPaddingLeft: 10,
              tdPaddingRight: 8,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(0))),
            ),
          ),
          Expanded(
            flex: 1,
            child: Consumer<ResultProvider>(
              builder: (context, resultConsumer, child) {
                return resultConsumer.isLoading == true
                    ? Lottie.asset(LottiePath.uploadingLottie)
                    : Container();
              },
            ),
          )
        ],
      ),
    );
  }
}
