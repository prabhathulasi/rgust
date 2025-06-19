import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rugst_alliance_academia/data/model/ciricullam/ciricullam_model.dart';
import 'package:rugst_alliance_academia/data/provider/faculty_provider/faculty_provider.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/widgets/app_richtext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';

class FacultyCiriculamList extends StatefulWidget {
  final int? facultyId;
  const FacultyCiriculamList({super.key, this.facultyId});

  @override
  State<FacultyCiriculamList> createState() => _FacultyCiriculamListState();
}

class _FacultyCiriculamListState extends State<FacultyCiriculamList> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5.0,
        child: Consumer<FacultyProvider>(
          builder: (context, facultyProvider, child) {
            if (facultyProvider.isLoading == true) {
              return const Center(
                child: SpinKitSpinningLines(
                  color: AppColors.color446,
                  size: 50.0,
                ),
              );
            } else {
              if (facultyProvider.ciricullamListModel.ciriculum == null) {
                return Container(
                  color: AppColors.colorWhite,
                  child: const Center(
                    child: AppRichTextView(
                      title: "No Ciriculam Record Stored Yet",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.color446,
                    ),
                  ),
                );
              } else {
                return Container(
                  color: AppColors.colorWhite,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AppRichTextView(
                          title: "Ciriculam List",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          textColor: AppColors.color446,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: AppRichTextView(
                            title: facultyProvider.ciricullamListModel
                                .ciriculum!.first.courseName!,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.color446,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        GroupedListView<Ciriculum, String>(
                          shrinkWrap: true,
                          elements:
                              facultyProvider.ciricullamListModel.ciriculum ??
                                  [],
                          groupBy: (element) =>
                              "${DateFormat.yMMMMd().format(DateTime.parse(element.startDate!))} to ${DateFormat.yMMMMd().format(DateTime.parse(element.endDate!))}", // group key
                          groupSeparatorBuilder: (String groupValue) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              groupValue,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.color446,
                              ),
                            ),
                          ),
                          itemBuilder: (context, element) {
                            return Card(
                              child: ListTile(
                                title: AppRichTextView(
                                  title: "${element.ciriculum}"
                                      .replaceAll("{", "")
                                      .replaceAll("}", ""),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  textColor: AppColors.color446,
                                ),
                              ),
                            );
                          },
                          itemComparator: (item1, item2) => 0, // optional
                          useStickyGroupSeparators: true,
                          order: GroupedListOrder.ASC,
                        )
                      ],
                    ),
                  ),
                );
              }
            }
          },
        ));
  }
}
