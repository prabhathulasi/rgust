import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdmissionLoginProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _changePage = false;
  bool get changePage => _changePage;

  bool _passwordVisibility = true;
  bool get passwordVisibility => _passwordVisibility;

  String? email;

  String? applicationId;
  String? status;
  PageController pageController = PageController();

  Future<http.Response> postAdmissionLogin() async {
    setLoading(true);
    var bodydata = {
      "Email": email,
    };

    try {
      var result = await ApiHelper.post("admissionLogin", bodydata, "");

      return result;
      //api call
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setPage(bool value) {
    _changePage = value;
    notifyListeners();
  }

  void setPasswordVisibility() async {
    _passwordVisibility = !_passwordVisibility;
    notifyListeners();
  }

  void setApplicationStatus(String status, String applicationId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Status', status);
    await prefs.setString("ApplicationId", applicationId);
    getApplicationStatus();
  }

  Future getApplicationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    status = prefs.getString('Status') ;
    applicationId = prefs.getString("ApplicationId");
    setPageController(int.parse(status!));


    // notifyListeners();
  }

  setPageController(int value) async {
    pageController = PageController(
      initialPage: value,
      viewportFraction: 1.0,
    );
    notifyListeners();
  }
}
