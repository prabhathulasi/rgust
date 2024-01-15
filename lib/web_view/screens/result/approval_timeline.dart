
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/custom_plugin/timeline/bubble_timeline.dart';
import 'package:rugst_alliance_academia/custom_plugin/timeline/timeline_item.dart';
import 'package:rugst_alliance_academia/data/provider/result_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';


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

    return Scaffold(
      
      body: Consumer<ResultProvider>(
        builder: (context, resultConsumer, child) {
          if (resultConsumer.approvalModel.approvalData== null){
            return const Center(
              child: Text("No Record Found"),
            );
          }else{
return Center(
            child: BubbleTimeline(
              bubbleDiameter: 120,
              items: resultConsumer.timeline,
              stripColor: AppColors.color582,
              scaffoldColor: Colors.white,
            ),
          );
          }
          
        }
      ),
    );
  }
}