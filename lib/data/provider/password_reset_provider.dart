import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var result =
          await ApiHelper.post("mobile/ResetPasswordOtp", bodyData, "");
      setLoading(false);
      var data = json.decode(result.body);
      if (result.statusCode == 200) {
        setPassFieldVisibilty(true);
        prefs.setString("resetId", data["userId"].toString());
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

  Future resetPassword(
      String email, String password, int otp, String userId) async {
    setLoading(true);

    var bodyData = {
      "UserId": int.parse(userId),
      "Email": email,
      "Otp": otp,
      "NewPassword": password,
    };

    try {
      var result = await ApiHelper.post("mobile/ResetPassword", bodyData, "");
      setLoading(false);
      var data = json.decode(result.body);
      if (result.statusCode == 200) {
        ToastHelper().sucessToast(data["Message"]);

        return "200";
      } else if (result.statusCode == 401) {
        ToastHelper().errorToast(data["Message"]);

        return "Invalid Token";
      } else {
        ToastHelper().errorToast(data["Message"]);
        // ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      setLoading(false);
      ToastHelper().errorToast(e.toString());

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
