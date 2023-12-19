import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class ResultProvider extends ChangeNotifier{
    // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;


updateExamresult(String token, int id, dynamic data) async{
     setLoading(true);
    try {
      Map<String, dynamic> body ={
 "Cw1":10,
 "Cw2":11,
 "CW3":12,
 "CW4":15,
 "FinalMark":50,
 "Grade":"A"
      };
      var result = await ApiHelper.put("UpdateResult/id=$id", body,token);

      setLoading(false);
      if (result.statusCode == 200) {
      

        
        notifyListeners();

        // return studentDetailModel;
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
      return null;
    }

}







  // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}