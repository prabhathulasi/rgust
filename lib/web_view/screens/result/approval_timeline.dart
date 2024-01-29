import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/custom_plugin/timeline/bubble_timeline.dart';
import 'package:rugst_alliance_academia/custom_plugin/timeline/timeline_item.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/provider/program_provider.dart';
import 'package:rugst_alliance_academia/data/provider/result_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class BubbleTimlineView extends StatelessWidget {
  final List<TimelineItem> _items = [
    const TimelineItem(
      description: "",
      title: 'Boat',
      subtitle: 'Travel through Oceans',
      child: Icon(
        Icons.directions_boat,
        color: Colors.white,
      ),
      bubbleColor: Colors.grey,
    ),
    const TimelineItem(
      description: "",
      title: 'Bike',
      subtitle: 'Road Trips are best',
      child: Icon(
        Icons.directions_bike,
        color: Colors.white,
      ),
      bubbleColor: Colors.grey,
    ),
    const TimelineItem(
      description: "",
      title: 'Bus',
      subtitle: 'I like to go with friends',
      child: Icon(
        Icons.directions_bus,
        color: Colors.white,
      ),
      bubbleColor: Colors.grey,
    ),
    const TimelineItem(
      description: "",
      title: 'Bus',
      subtitle: 'I like to go with friends',
      child: Icon(
        Icons.directions_bus,
        color: Colors.white,
      ),
      bubbleColor: Colors.grey,
    ),
  ];

  BubbleTimlineView({super.key});

  @override
  Widget build(BuildContext context) {
    final resultProvider = Provider.of<ResultProvider>(context, listen: false);
    final programProvider = Provider.of<ProgramProvider>(context);
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

    return Scaffold(
      body: FutureBuilder(
        future: getApproval(),
        builder: (context, approvalSnapshot) {
          if (approvalSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitSpinningLines(color: AppColors.colorc7e),
            );
          } else {
            return resultProvider.approvalModel.approvalData == null ||
                    resultProvider.approvalModel.approvalData!.isEmpty
                ? Column(
                    children: [
                      Expanded(child: Lottie.asset(LottiePath.noDataLottie)),
                      AppRichTextView(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        title: "Result Not Uploaded Yet",
                        textColor: AppColors.colorRed,
                      ),
                    ],
                  )
                : Consumer<ResultProvider>(
                    builder: (context, resultConsumer, child) {
                  if (resultConsumer.approvalModel.approvalData == null) {
                    return const Center(
                      child: Text("No Record Found"),
                    );
                  } else {
                    return Center(
                      child: BubbleTimeline(
                        bubbleDiameter: 120,
                        items: resultConsumer.timeline,
                        stripColor: AppColors.color582,
                        scaffoldColor: Colors.white,
                      ),
                    );
                  }
                });
          }
        },
      ),
    );
  }
}
