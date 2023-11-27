import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/fees_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/fees/add_new_fees.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class FeesView extends StatefulWidget {
  const FeesView({super.key});

  @override
  State<FeesView> createState() => _FeesViewState();
}



class _FeesViewState extends State<FeesView> {
  @override
  Widget build(BuildContext context) {
    final feesProvider = Provider.of<FeesProvider>(context, listen: false);

    Future getFeesList() async {
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
        var result = await feesProvider.getFeesList(token);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    Future getMiscFees(int programId , int feesId) async {
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
        var result = await feesProvider.getMiscFeesDetails(token,programId,feesId);
        if (result == "Invalid Token") {
          ToastHelper().errorToast("Session Expired Please Login Again");
          if (context.mounted) {
            Navigator.pushNamed(context, RouteNames.login);
          }
        }
      }
    }

    return Scaffold(
      body: FutureBuilder(
          future: getFeesList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitSpinningLines(
                  color: AppColors.colorc7e,
                  size: 35.sp,
                ),
              );
            } else {
              var data = feesProvider.feesModel;
           
            
              return SizedBox(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: AppRichTextView(
                              title:
                                  "Doctor of Medicine Degree Program (5½ Years)",
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.colorc7e,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(18.sp),
                          child: DataTable(
                              columnSpacing: 100.sp,
                              columns: [
                                DataColumn(
                                  label: AppRichTextView(
                                    title: "Program",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    textColor: AppColors.colorc7e,
                                  ),
                                ),
                                DataColumn(
                                  label: AppRichTextView(
                                    title: "Semester",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    textColor: AppColors.colorc7e,
                                  ),
                                ),
                                DataColumn(
                                  label: AppRichTextView(
                                    title: "Tuition cost per Semester",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    textColor: AppColors.colorc7e,
                                  ),
                                ),
                                DataColumn(
                                  label: AppRichTextView(
                                    title: "Total Tuition Fees",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    textColor: AppColors.colorc7e,
                                  ),
                                )
                              ],
                              rows: data.feeslist!
                                  .map((e) => DataRow(cells: [
                                        DataCell(AppRichTextView(
                                          title: e.programName!,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorBlack,
                                        )),
                                        DataCell(AppRichTextView(
                                          title: e.semCount.toString(),
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorBlack,
                                        )),
                                        DataCell(AppRichTextView(
                                          title: e.tutionFee.toString(),
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: AppColors.colorBlack,
                                        )),
                                        DataCell(Row(
                                          children: [
                                            AppRichTextView(
                                              title: (e.tutionFee! * e.semCount!)
                                                  .toString(),
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              textColor: AppColors.colorBlack,
                                            ),
                                            SizedBox(width: 10.w,),
                                            InkWell(
                                              onTap: () async{
                                                print("button pressed0");
                                            await getMiscFees(e.programId!, e.feesId!);
                                              },
                                              child: const Icon(Icons.visibility_outlined,color: AppColors.colorc7e,))
                                          ],
                                        ))
                                      ]))
                                  .toList()),
                        ),
                        
                       
                        Consumer<FeesProvider>(
                          builder: (context, miscProvider, child) {
                               var miscData= miscProvider.miscFeeModel;
                            return miscProvider.miscFeeModel.miscFee == null? Container(): Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: AppRichTextView(
                                      title:
                                          "National Students: Miscellaneous Fees (Per Semester US\$)",
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.colorc7e,
                                    ),
                                  ),
                                ),
                                 Padding(
                          padding: EdgeInsets.all(18.sp),
                          child: DataTable(
                            columnSpacing: 100.sp,
                            columns: [
                              DataColumn(
                                label: AppRichTextView(
                                  title: "Details",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  textColor: AppColors.colorc7e,
                                ),
                              ),
                              DataColumn(
                                label: AppRichTextView(
                                  title: "Semester Fee",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  textColor: AppColors.colorc7e,
                                ),
                              ),
                                DataColumn(
                                label: AppRichTextView(
                                  title: "Total Amount",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  textColor: AppColors.colorc7e,
                                ),
                              ),
                              
                            ],
                            rows: miscData.miscFee!.where((element) => element.isNational == true)
                                .map((e) => DataRow(cells: [
                                      DataCell(AppRichTextView(
                                        title: e.detail!,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                      DataCell(AppRichTextView(
                                        title: e.miscFee.toString(),
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                       DataCell(AppRichTextView(
                                        title: (e.miscFee! * miscData.semCount!).toString(),
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                     
                                    ]))
                                .toList()),
                        ),
                         Center(
                           child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: AppRichTextView(
                                      title:
                                          "National Students: Miscellaneous Fees (Per Semester US\$)",
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.colorc7e,
                                    ),
                                  ),
                         ),
                                 Padding(
                          padding: EdgeInsets.all(18.sp),
                          child: DataTable(
                            columnSpacing: 100.sp,
                            columns: [
                              DataColumn(
                                label: AppRichTextView(
                                  title: "Details",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  textColor: AppColors.colorc7e,
                                ),
                              ),
                              DataColumn(
                                label: AppRichTextView(
                                  title: "Semester Fee",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  textColor: AppColors.colorc7e,
                                ),
                              ),
                                DataColumn(
                                label: AppRichTextView(
                                  title: "Total Amount",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  textColor: AppColors.colorc7e,
                                ),
                              ),
                              
                            ],
                            rows: miscData.miscFee!.where((element) => element.isNational == false)
                                .map((e) => DataRow(cells: [
                                      DataCell(AppRichTextView(
                                        title: e.detail!,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                      DataCell(AppRichTextView(
                                        title: e.miscFee.toString(),
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                       DataCell(AppRichTextView(
                                        title: (e.miscFee! * miscData.semCount!).toString(),
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                     
                                    ]))
                                .toList()),
                        ),
                              ],
                            );
                          }
                        ),
                     
                      
                      ]),
                ),
              );
            }
          }),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.colorc7e,
            child: const Icon(Icons.edit,color: AppColors.colorWhite,),
            onPressed: () {
           
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Stack(
        children: [
          const AddNewFees(),
          Transform.translate(
            offset: Offset(10.w, -13.h),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: AppColors.colorc7e,
                    child: Icon(Icons.close, color: AppColors.color582),
                  ),
                )),
          )
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }  
            
          ),
    );
  }
}
