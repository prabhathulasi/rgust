import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';

import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/add_student_view.dart';
import 'package:rugst_alliance_academia/web_view/screens/student/student_detail_view.dart';
import 'package:rugst_alliance_academia/widgets/app_spining.dart';
import 'package:rugst_alliance_academia/widgets/dummy_data.dart';

import 'package:scalable_data_table/scalable_data_table.dart';

class StudentListView extends StatelessWidget {
  const StudentListView({Key? key}) : super(key: key);

  static final _dateFormat = DateFormat('HH:mm dd/MM');
  showDetailAlertDialog(BuildContext context) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Stack(
        children: [
          const StudentDetailView(),
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
                    backgroundColor: AppColors.color927,
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

  showAddAlertDialog(BuildContext context) {
    // set up the AlertDialog
    Dialog alert = Dialog(
      child: Stack(
        children: [
          const AddStudentView(),
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
                    backgroundColor: AppColors.color927,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: createUsers(),
        builder: (context, snapshot) => ScalableDataTable(
          loadingBuilder: (p0) {
            return SpinKitSpinningLines(
              color: AppColors.color927,
              size: 90.sp,
            );
          },
          header: DefaultTextStyle(
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
            child: ScalableTableHeader(
              columnWrapper: columnWrapper,
              children: const [
                Text("ID"),
                Text('Class'),
                Text('Student Name'),
                Text('Mobile Number'),
                Text('Email Address'),
                Text('Address'),
              ],
            ),
          ),
          rowBuilder: (context, index) {
            final user = snapshot.data![index];
            return InkWell(
              onTap: () {
                showDetailAlertDialog(context);
              },
              child: ScalableTableRow(
                columnWrapper: columnWrapper,
                color: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
                children: [
                  Text('${user.index}.'),
                  Text(_dateFormat.format(user.createdAt)),
                  Text(user.name),
                  Text(user.surname),
                  Text('${user.points} pts'),
                  Text(user.interests.join(', '), maxLines: 2),
                ],
              ),
            );
          },
          emptyBuilder: (context) => const Text('No users yet...'),
          itemCount: snapshot.data?.length ?? -1,
          minWidth: 1000, // max(MediaQuery.of(context).size.width, 1000),
          textStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.color927,
          onPressed: () {
            showAddAlertDialog(context);
          },
          child: const Icon(
            Icons.person_add_alt_1_outlined,
            color: AppColors.colorWhite,
          )),
    );
  }

  Widget columnWrapper(BuildContext context, int columnIndex, Widget child) {
    const padding = EdgeInsets.symmetric(horizontal: 10);
    switch (columnIndex) {
      case 0:
        return Container(
          width: 60,
          padding: padding,
          child: child,
        );
      case 1:
        return Container(
          width: 100,
          padding: padding,
          child: child,
        );
      case 5:
        return Expanded(
          flex: 3,
          child: Container(
            padding: padding,
            child: child,
          ),
        );
      default:
        return Expanded(
          child: Container(
            padding: padding,
            child: child,
          ),
        );
    }
  }
}
