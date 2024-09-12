import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:intl/intl.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';


class StudyHistoryView extends StatefulWidget {
  final StudentDetail studentData;
  const StudyHistoryView({super.key, required this.studentData});

  @override
  State<StudyHistoryView> createState() => _StudyHistoryViewState();
}

class _StudyHistoryViewState extends State<StudyHistoryView> {

  @override
  Widget build(BuildContext context) {



       var data = widget.studentData.registeredCourse;
   
    return  Container(
      color: AppColors.colorWhite,
      child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.summarize_outlined,color: AppColors.colorc7e,)),
                ),
                Expanded(

                  child: ListView.builder(
                    shrinkWrap: true,
                          itemCount:  _getCategories(data!).length,
                          itemBuilder: (context, index) {
                  final category = _getCategories(data)[index];
                  final categoryItems = _getItemsForCategory(category,data);
                
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:widget.studentData.currentClassName == category?  GlowText(
                    category,
                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.colorGreen),
                  ):  Text(
                           category,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                           columnSpacing: 40, // Adjust column spacing as needed
                            // Adjust row height as needed
                          border: TableBorder.all(),
                          columns:  const [
                            DataColumn(label: Text('Course Name',style: TextStyle(fontWeight: FontWeight.bold),softWrap: true,)),
                            DataColumn(label: Text('Course Code',style: TextStyle(fontWeight: FontWeight.bold),)),
                             DataColumn(label: Text('Batch',style: TextStyle(fontWeight: FontWeight.bold),)),
                             DataColumn(label: Text('Status',style: TextStyle(fontWeight: FontWeight.bold),)),
                              DataColumn(label: Text('Approved Date',style: TextStyle(fontWeight: FontWeight.bold),)),
                               DataColumn(label: Text('Approved By',style: TextStyle(fontWeight: FontWeight.bold),)),
                          ],
                          rows: categoryItems
                              .map(
                                (item) => DataRow(
                                  cells: [
                                    DataCell(Text(item.courseName!.trim(),style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.colorBlack),)),
                                    DataCell(Text(item.courseCode!,style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.colorBlack),)),
                                    DataCell(Text(item.batch!,style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.colorBlack),)),
                                            DataCell(Text(item.status!,style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.colorBlack),)),
                                    DataCell(Text(DateFormat.yMMMEd().format(DateTime.parse(item.createdAt!)),style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.colorBlack),)),
                                    DataCell(Text(item.approvedBy!,style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.colorBlack),)),
                            
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                          },
                        ),
                ),
              ],
            )


            
           
         
    );
  }

  List<String> _getCategories(List<RegisteredCourse>? data) {
    return data!.map((item) => item.className!).toSet().toList();
  }

 List<RegisteredCourse> _getItemsForCategory(String category,List<RegisteredCourse>? data) {
    return data!.where((item) => item.className! == category).toList();
  }
}