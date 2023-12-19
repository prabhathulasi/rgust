import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/fees_provider.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class StudentFeesDetails extends StatefulWidget {
  const StudentFeesDetails({super.key});

  @override
  State<StudentFeesDetails> createState() => _StudentFeesDetailsState();
}

class _StudentFeesDetailsState extends State<StudentFeesDetails> {
  @override
  Widget build(BuildContext context) {
final feesProvider = Provider.of<FeesProvider>(context,listen: false);
  final programProvider = Provider.of<ProgramProvider>(context);
    Future getMiscFees(int programId) async {
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
        var result = await feesProvider.getFeesByid(token,programId);
         if(result =="Invalid Token"){
           ToastHelper().errorToast("Session Expired Please Login Again");
           if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }}
      }
    }
    return FutureBuilder(
                              future: getMiscFees(int.parse(programProvider.selectedDept!)),
                              builder: (context,snapshot) {
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return  Center(
                                    child: SpinKitSpinningLines(color: AppColors.colorcfe,size: 30.sp,),
                                  );
                                }else{
 return Column(
   children: [
     AppRichTextView(
       title: "Fees Structure",
       fontSize: 25.sp,
       fontWeight: FontWeight.w500),
       SizedBox(
         height: 10.h,
       ),
     
Expanded(
  child:   ListView.builder(
    shrinkWrap: true,
    itemCount: feesProvider.singlefeesModel.feeslist!.length,
    itemBuilder: (context, index) {
      var data = feesProvider.singlefeesModel.feeslist![index];
      return Column(
        children: [
          Row(
            children: [
              const Icon(Icons.radio_button_checked_outlined),
              SizedBox(width: 10.w,),

              Text(feesProvider.singlefeesModel.feeslist![index].feesType!),
              

            ],
          ),
          Row(
            children: [
 Padding(
   padding: const EdgeInsets.all(18.0),
   child: AppRichTextView(
     title:
         "Semester Tution Fee:",
     fontSize: 18.sp,
     fontWeight: FontWeight.bold,
     textColor: AppColors.colorc7e,
   ),
 ),
  AppRichTextView(
    title:
        data.tutionFee.toString(),
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    textColor: AppColors.colorBlack,
  ),
      Padding(
   padding: const EdgeInsets.all(18.0),
   child: AppRichTextView(
     title:
         "No of Semester:",
     fontSize: 18.sp,
     fontWeight: FontWeight.bold,
     textColor: AppColors.colorc7e,
   ),
 ),
  AppRichTextView(
    title:
        data.semCount.toString(),
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    textColor: AppColors.colorBlack,
  ),       ],
          ),
           Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: AppRichTextView(
                                      title:
                                          "National Students: Miscellaneous Fees (Per Semester US\$)",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.colorc7e,
                                    ),
                                  ),
                                ),
          DataTable(
            border: TableBorder.all(width: 2,color: AppColors.colorBlack),
                          columnSpacing: 80.sp,
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
                          rows: data.miscellaneousFees!.where((element) => element.isNational == true)
                              .map((e) => DataRow(cells: [
                                    DataCell(AppRichTextView(
                                      title: e.detail!,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.colorBlack,
                                    )),
                                    DataCell(AppRichTextView(
                                      title: e.miscFee.toString(),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.colorBlack,
                                    )),
                                     DataCell(AppRichTextView(
                                      title: (e.miscFee! * data.semCount!).toString(),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.colorBlack,
                                    )),
                                    
                                   
                                  ]))
                              .toList()),

                                Center(
                           child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: AppRichTextView(
                                      title:
                                          "National Students: Miscellaneous Fees (Per Semester US\$)",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.colorc7e,
                                    ),
                                  ),
                         ),
                          DataTable(
                            border: TableBorder.all(width: 2, color: AppColors.colorBlack),
                            columnSpacing: 80.sp,
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
                            rows: data.miscellaneousFees!.where((element) => element.isNational == false)
                                .map((e) => DataRow(cells: [
                                      DataCell(AppRichTextView(
                                        title: e.detail!,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                      DataCell(AppRichTextView(
                                        title: e.miscFee.toString(),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                       DataCell(AppRichTextView(
                                        title: (e.miscFee! * data.semCount!).toString(),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.colorBlack,
                                      )),
                                     
                                    ]))
                                .toList()),
        ],
      );
    },
  ),
)
       
       
   ],
 );
                                }
                               
                              }
                            );
  }
}