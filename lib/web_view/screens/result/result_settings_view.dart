import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/result_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/data/model/publish_result_model.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/batch_dropdown.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/class_dropdown.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/program_dropdown_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/department/year_dropdown_view.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class ResultSettingsView extends StatefulWidget {
  const ResultSettingsView({super.key});

  @override
  State<ResultSettingsView> createState() => _ResultSettingsViewState();
}

class _ResultSettingsViewState extends State<ResultSettingsView> {


 
  @override
  Widget build(BuildContext context) {
 final programProvider = Provider.of<ProgramProvider>(context);
        final resultProvider =
        Provider.of<ResultProvider>(context, listen: false);

    //       Future getResultData() async {
    //   var token = await getTokenAndUseIt();
    //   if (token == null) {
    //     if (context.mounted) {
    //       Navigator.pushNamed(context, RouteNames.login);
    //     }
    //   } else if (token == "Token Expired") {
    //     ToastHelper().errorToast("Session Expired Please Login Again");

    //     if (context.mounted) {
    //       Navigator.pushNamed(context, RouteNames.login);
    //     }
    //   } else {
    //     var result = await resultProvider.getAllResult(token);
    //      if(result =="Invalid Token"){
    //        ToastHelper().errorToast("Session Expired Please Login Again");
    //        if (context.mounted) {
    //       Navigator.pushNamed(context, RouteNames.login);
    //     }}
    //   }
    // }
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child:     AppRichTextView(
                          title: "Publish Results",
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold),
          ),
       AppRichTextView(
                          title: "Program",
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500),
                      SizedBox(
                        height: 10.h,
                      ),
                      const ProgramDropdown(),
                      SizedBox(
                        height: 10.h,
                      ),
                      programProvider.selectedDept == null
                          ? Container()
                          : AppRichTextView(
                              title: "Class",
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w500),
                      const ClassDropdown(),
                      SizedBox(
                        height: 10.h,
                      ),
                      programProvider.selectedClass == null
                          ? Container()
                          : AppRichTextView(
                              title: "Year",
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w500),
                      const DynamicYearsDropdown(),
                      SizedBox(
                        height: 10.h,
                      ),
                      programProvider.selectedClass == null
                          ? Container()
                          : AppRichTextView(
                              title: "Batch",
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w500),
                      SizedBox(
                        height: 10.h,
                      ),
    
                      const BatchDropdown(),
                      SizedBox(
                        height: 10.h,
                      ),
        ],
      ),
    );
  }

  
}

