import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';

class PasswordResetProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _showPasswordField = false;
  bool get showPasswordField => _showPasswordField;

  Future getPassResetOtp(String email) async {
    setLoading(true);

    var bodyData = {
      "Email": email,
    };
    log(bodyData.toString());
    try {
      var result = await ApiHelper.post("mobile/ResetPasswordOtp", bodyData, "");
      setLoading(false);
      var data = json.decode(result.body);
      if (result.statusCode == 200) {
        setPassFieldVisibilty(true);
        return data;
      } else if (result.statusCode == 401) {
        return "Invalid Token";
      } else {
        // ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      return null;
    } finally {
      setLoading(false);
    }
  }

  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

  void setPassFieldVisibilty(bool value) async {
    _showPasswordField = value;
    notifyListeners();
  }
}
