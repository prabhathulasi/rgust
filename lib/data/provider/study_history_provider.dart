import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/reg_course_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class StudyHistoryProvider extends ChangeNotifier{
     bool _isLoading = false;
  bool get isLoading => _isLoading;


RegistedCourseModel registedCourseModel = RegistedCourseModel();






  Future getRegCoursebyId(int studentId, String token) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("GetRegCourse/id=$studentId", token);

      setLoading(false);
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        registedCourseModel = RegistedCourseModel.fromJson(data);


        notifyListeners();

        return registedCourseModel;
      } else if (result.statusCode == 204) {
        notifyListeners();
        ToastHelper().errorToast("No Courses Registered Yet");

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




  // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}