import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/clockinout_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class DashboardProvider extends ChangeNotifier{
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
 ClockInandOutModel clockInandOutModel = ClockInandOutModel();
 Future clockInOutList(String token) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("GetClockInTime", token);
      setLoading(false);
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        clockInandOutModel = ClockInandOutModel.fromJson(data);

        notifyListeners();

        return clockInandOutModel;
      } else if (result.statusCode == 204) {
        notifyListeners();
        ToastHelper().errorToast("No ClockIn Records Added Yet");
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