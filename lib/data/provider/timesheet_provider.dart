import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/time_sheet_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:rugst_alliance_academia/web_view/screens/faculty/faculty_attendance_view.dart';

class TimeSheetProvider extends ChangeNotifier{
    bool _isLoading = false;
  bool get isLoading => _isLoading;

FacultyTimeSheetModel facultyTimeSheetModel = FacultyTimeSheetModel();
final List<Meeting> meetings = <Meeting>[];


List<Attendance> events=[];
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

  getFacultyAttendance(int id,String token) async{
meetings.clear();
events.clear();
       setLoading(true);
    try {
      var result = await ApiHelper.get("Faculty/attendance/id=$id", token);
      setLoading(false);
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

     facultyTimeSheetModel = FacultyTimeSheetModel.fromJson(data);
     events =facultyTimeSheetModel.attendance!;

        notifyListeners();

       return events;
      } else if (result.statusCode == 204) {
        notifyListeners();
        ToastHelper().errorToast("No Faculty Added Yet");
        return null;
      } else if (result.statusCode == 401) {
        notifyListeners();

        return "Invalid Token";
      } else {
        notifyListeners();
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      setLoading(false);
      ToastHelper().errorToast(e.toString());
      return e.toString();
    }
  }


  getDataSource(){
    for (var e in events){
      meetings.add(Meeting(e.iD.toString(), e.courseId!, DateTime.parse(e.startTime!), DateTime.parse(e.endTime!), Colors.white, false));
      
    }
  
    return meetings;
  }
}