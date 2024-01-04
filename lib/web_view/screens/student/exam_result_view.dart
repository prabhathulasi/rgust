import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/exam_result_model.dart' as prefix;
import 'package:rugst_alliance_academia/data/model/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/pdf_generate/student_result_summary.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/update_result_view.dart';


class ExamResult extends StatefulWidget {
  final StudentDetail? studentData;
  const ExamResult({super.key, this.studentData});

  @override
  State<ExamResult> createState() => _ExamResultState();
}

class _ExamResultState extends State<ExamResult> {


  updateResultAlert(BuildContext context) {
    // set up the AlertDialog
    Dialog alert = Dialog(
                                                  child: Card(
                                                    elevation: 5.0,
                                                    child: SizedBox(
                                                      height: 700.h,
                                                      width: 1200.w,
                                                      child: UpdateResultView(
                                                          studenId: widget
                                                              .studentData!.iD),
                                                    ),
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
  @override
  Widget build(BuildContext context) {
    
  var examData = widget.studentData!.result;

   

  
    return Scaffold(
      body: 
             Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: SizedBox(
                                    height: MediaQuery.sizeOf(context).height,
                                    width: 1200.w,
                                    child: Stack(
                                      children: [
                                        StudentResultSummary(
                                          result: widget.studentData!.result,
                                          studentData: widget.studentData,
                                        ),
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
                                                  backgroundColor:
                                                      AppColors.colorc7e,
                                                  child: Icon(Icons.close,
                                                      color:
                                                          AppColors.color0ec),
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.summarize_outlined,
                            color: AppColors.colorc7e,
                          ))),
                ),
           
                     
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _getCategories(examData).length,
                        itemBuilder: (context, index) {
                          final category = _getCategories(examData)[index];
                          final categoryItems =
                              _getItemsForCategory(category, examData);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      category,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Consumer<StudentProvider>(
                                      builder: (context, studentConsumer, child) {
                                        return InkWell(
                                            onTap: () async {
                                              await studentConsumer
                                                  .updateStudentResult(categoryItems);
                                                  if(context.mounted){

                                            updateResultAlert(context);
                                                  }
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: AppColors.colorc7e,
                                              size: 25.sp,
                                            ));
                                      }
                                    )
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: FractionallySizedBox(
                                  widthFactor: 0.99,
                                  child: DataTable(
                                    border: TableBorder.all(),
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        'Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Code',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Batch',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'CW-1',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'CW-2',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'CW-3',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'CW-4',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Final',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Grade',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      )),
                                    ],
                                    rows: categoryItems
                                        .map(
                                          (item) => DataRow(
                                            cells: [
                                              DataCell(Text(
                                                item.courseName!.trim(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.colorBlack,
                                                    fontSize: 12.sp),
                                              )),
                                              DataCell(Text(
                                                item.courseCode!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.colorBlack,
                                                    fontSize: 12.sp),
                                              )),
                                              DataCell(Text(
                                                item.batch!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.colorBlack,
                                                    fontSize: 12.sp),
                                              )),
                                              DataCell(Text(
                                                item.cw1.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.colorBlack,
                                                    fontSize: 12.sp),
                                              )),
                                              DataCell(Text(
                                                item.cw2.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.colorBlack,
                                                    fontSize: 12.sp),
                                              )),
                                              DataCell(Text(
                                                item.cw3.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.colorBlack,
                                                    fontSize: 12.sp),
                                              )),
                                              DataCell(Text(
                                                item.cw4.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.colorBlack,
                                                    fontSize: 12.sp),
                                              )),
                                              DataCell(Text(
                                                item.finalMark.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.colorBlack,
                                                    fontSize: 12.sp),
                                              )),
                                              DataCell(Text(
                                                item.grade!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.colorBlack,
                                                    fontSize: 12.sp),
                                              )),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        },
                      ),
                    )
               
              ],
            )
    
    );
  }

  List<String> _getCategories(List<prefix.Result>? data) {
    return data!.map((item) => item.className!).toSet().toList();
  }

  List<prefix.Result> _getItemsForCategory(String category, List<prefix.Result>? data) {
    return data!.where((item) => item.className! == category).toList();
  }
}
