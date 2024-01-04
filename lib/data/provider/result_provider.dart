import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/publish_result_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class ResultProvider extends ChangeNotifier {
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  PublishResultModel resultPublishModel = PublishResultModel();
  updateExamresult(String token, int id, dynamic data) async {
    setLoading(true);
    try {
      Map<String, dynamic> body = {
        "Cw1": int.parse(data["CW1"]),
        "Cw2": int.parse(data["CW2"]),
        "CW3": int.parse(data["CW3"]),
        "CW4": int.parse(data["CW4"]),
        "FinalMark": int.parse(data["FinalExam"]),
        "Grade": data["Grade"]
      };
      print(body);
      var result = await ApiHelper.put("UpdateResult/id=$id", body, token);

      setLoading(false);
      if (result.statusCode == 200) {
        notifyListeners();
        ToastHelper().sucessToast("Result Updated Sucessfully");
        return 200;
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

  createResult(String token, int studentId) async {
    setLoading(true);
    try {
      var body = {"StudentId": studentId};
      var result = await ApiHelper.post("CreateResult", body, token);

      setLoading(false);
      if (result.statusCode == 200) {
        notifyListeners();
        ToastHelper().sucessToast("Result Courses Added Sucessfully");
        return 200;
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

  getAllResult(String token) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("GetAllResult", token);

      setLoading(false);
      var data = json.decode(result.body);
      if (result.statusCode == 200) {
        resultPublishModel = PublishResultModel.fromJson(data);

        notifyListeners();
        
        return 200;
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
