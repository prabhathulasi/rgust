import 'dart:convert';
import 'dart:typed_data';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/clockinout_model.dart';
import 'package:rugst_alliance_academia/data/provider/dashboard_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/dashboard/pie_chart.dart';
import 'package:rugst_alliance_academia/widgets/app_linechart.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class OverviewView extends StatefulWidget {
  const OverviewView({super.key});

  @override
  State<OverviewView> createState() => _OverviewViewState();
}


class _OverviewViewState extends State<OverviewView> {
  String classValue = "All Classes";
  Uint8List? decodedImage;
  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context,listen: false);
       Future getClockInDeatils() async {
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
        var result = await dashboardProvider.clockInOutList(token);
         if(result =="Invalid Token"){
           ToastHelper().errorToast("Session Expired Please Login Again");
           if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.login);
        }}
      }
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.sp)),
                  elevation: 5.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          AppColors.color6d5,
                          AppColors.color4ff
                        ]
                      ),
                      borderRadius: BorderRadius.circular(25.sp)
                    ),
                    height: 200.h,
                    width: 350.w,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              AppRichTextView(title: "37", fontSize: 50.sp, fontWeight: FontWeight.bold, textColor: AppColors.colorWhite,),
                              AppRichTextView(title: "Total Students", fontSize: 30.sp, fontWeight: FontWeight.bold, textColor: AppColors.colorWhite,)
                            ],
                          ),
                          Lottie.asset(LottiePath.studentLottie,width: 100.w)
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.sp)),
                  elevation: 5.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          AppColors.color3ee,
                          AppColors.colorcfe
                        ]
                      ),
                      borderRadius: BorderRadius.circular(25.sp)
                    ),
                    height: 200.h,
                    width: 350.w,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              AppRichTextView(title: "25", fontSize: 50.sp, fontWeight: FontWeight.bold, textColor: AppColors.colorWhite,),
                              AppRichTextView(title: "Total Faculties", fontSize: 30.sp, fontWeight: FontWeight.bold, textColor: AppColors.colorWhite,)
                            ],
                          ),
                          Lottie.asset(LottiePath.facultyLottie,width: 100.w)
                        ],
                      ),
                    ),
                  ),
                ),
                  Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.sp)),
                  elevation: 5.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          AppColors.coloreac,
                          AppColors.color0e7
                        ]
                      ),
                      borderRadius: BorderRadius.circular(25.sp)
                    ),
                    height: 200.h,
                    width: 350.w,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              AppRichTextView(title: "25", fontSize: 50.sp, fontWeight: FontWeight.bold, textColor: AppColors.colorWhite,),
                              AppRichTextView(title: "Total Staffs", fontSize: 30.sp, fontWeight: FontWeight.bold, textColor: AppColors.colorWhite,)
                            ],
                          ),
                           Lottie.asset(LottiePath.staffLottie,width: 100.w)
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.sp)),
                  elevation: 5.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          AppColors.color78a,
                          AppColors.colordb8
                        ]
                      ),
                      borderRadius: BorderRadius.circular(25.sp)
                    ),
                    height: 200.h,
                    width: 350.w,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              AppRichTextView(title: "15", fontSize: 50.sp, fontWeight: FontWeight.bold, textColor: AppColors.colorWhite,),
                              AppRichTextView(title: "Others", fontSize: 30.sp, fontWeight: FontWeight.bold, textColor: AppColors.colorWhite,)
                            ],
                          ),
                          Lottie.asset(LottiePath.otherLottie,width: 100.w)
                        ],
                      ),
                    ),
                  ),
                ),
                 
              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: AppColors.colorc7e
                      ),
                      borderRadius: BorderRadius.circular(22.sp)
                    ),
                    height: 300.h,
                   
                    child: const PieChartScreen(
                      donutColor1:           AppColors.color6d5,
                         donutColor2: AppColors.color4ff,
                    )),
                ),
                SizedBox(width: 10.w,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: AppColors.colorc7e
                        ),
                        borderRadius: BorderRadius.circular(22.sp)
                      ),
                      height: 300.h,
                    
                      child: const PieChartScreen(
                        donutColor1:     AppColors.color3ee,
                       donutColor2:   AppColors.colorcfe,
                      )),
                  ),
                   SizedBox(width: 10.w,),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: AppColors.colorc7e
                          ),
                          borderRadius: BorderRadius.circular(22.sp)
                        ),
                        height: 300.h,
                        
                        child: const PieChartScreen(
                          donutColor1:        AppColors.coloreac,
                          donutColor2:AppColors.color0e7,
                        )),
                    ),
                     SizedBox(width: 10.w,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: AppColors.colorc7e
                    ),
                    borderRadius: BorderRadius.circular(22.sp)
                  ),
                  height: 300.h,
                 
                  child: const PieChartScreen(
                    donutColor1:     AppColors.color78a,
                      donutColor2:    AppColors.colordb8,
                  )),
              )
              ],
            ),
            SizedBox(height: 20.h,),
            Container(
              height: 600.h,
              width: 500.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.sp),
                border: Border.all(color: AppColors.colorc7e,width: 2)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
          
                      children: [
                        AppRichTextView(title: "ClockIn and ClockOut", fontSize: 20.sp, fontWeight:FontWeight.bold,textColor: AppColors.colorBlack,),
                        InkWell(
                          onTap: () {
                            getClockInDeatils();
                          },
                          child: const Icon(Icons.refresh)),
                        const Spacer(),
                        const Icon(Icons.summarize_outlined,color: AppColors.colorc7e,)
                      ],
                    ),
                      
                    Expanded(child: FutureBuilder(
                      future: getClockInDeatils(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(
                            child: SpinKitSpinningLines(color: AppColors.colorc7e,size: 20.sp,),
                          );
                        }else{
                          var data = dashboardProvider.clockInandOutModel.data;
                          if(data == null){
                            return const Center(
                              child: Text("No Records Found"),
                            );
                          }else{

                          
                          
 return GroupedListView<Data, String>(
          elements: data,
          groupBy: (element) => element.createdAt!,
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) =>
              item1.checkInTime!.compareTo(item2.checkInTime!),
          order: GroupedListOrder.ASC,
          useStickyGroupSeparators: true,
          groupSeparatorBuilder: (String value) {
DateTime date = DateTime.parse(value);
var formatedDate= DateFormat('yMMMMd').format(date);


          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              formatedDate,
              textAlign: TextAlign.left,
              style:  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          );},
          itemBuilder: (c, element) {
            var checkinTime = DateFormat.jm().format(DateTime.parse(element.checkInTime!));
            String ?checkoutTime;

            if(element.checkOutTime !=""){
              checkoutTime = DateFormat.jm().format(DateTime.parse(element.checkOutTime!));
            }
            if(element.userImage!=""){
   decodedImage = base64Decode(element.userImage!);
            }
          
            return Card(
              elevation: 8.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: SizedBox(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                  leading:element.userImage== ""? const Icon(Icons.account_circle):  CircleAvatar(
                    backgroundImage: MemoryImage(decodedImage!),
                  ),
                  title: Text(element.username!,style: const TextStyle(color: AppColors.colorc7e,fontWeight: FontWeight.bold),),
                  subtitle: Text(element.usertype!,style: const TextStyle(color: AppColors.colorBlack),),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(text:TextSpan(
                        text: "Clock In : ",
                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(text:checkinTime,style: TextStyle(color: AppColors.colorc7e,fontWeight: FontWeight.bold,fontSize: 18.sp) )

                        ]
                      )),
                         RichText(text:TextSpan(
                        text: "Clock Out : ",
                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(text:checkoutTime,style: TextStyle(color: AppColors.colorc7e,fontWeight: FontWeight.bold,fontSize: 18.sp) )

                        ]
                      ))
                    ],
                  ),
                ),
              ),
            );
          },
        );}
                        }
                       
                      }
                    ),
      )
                  ],
                ),
              ),
            )
            
            
            ],
          ),
        ),
      ),
    );
  }
}
