import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/clockinout_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class DashboardProvider extends ChangeNotifier {
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  ClockInandOutModel clockInandOutModel = ClockInandOutModel();
  Future clockInOutList(String token) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("GetClockInTime", token);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        clockInandOutModel = ClockInandOutModel.fromJson(data);

        return clockInandOutModel;
      } else if (result.statusCode == 204) {
        // ToastHelper().errorToast("No ClockIn Records Added Yet");
        return null;
      } else if (result.statusCode == 401) {
        return "Invalid Token";
      } else {
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      ToastHelper().errorToast(e.toString());
      return e.toString();
    } finally {
      notifyListeners();
      setLoading(false);
    }
  }

  // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}
