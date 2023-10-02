import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';

import 'package:rugst_alliance_academia/util/api_service.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future login(String email, String password) async {
    var bodyData = {"email": email, "password": password};
    setLoading(true);
    print(Uri.https("172.16.20.121:443", "/login").toString());
    // Make your login API call here using the http package
    try {
      var result = await http.post(
        Uri.https("172.16.20.121:443", "/login"),
        body: jsonEncode(bodyData),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (result.statusCode == 200) {
        Fluttertoast.showToast(msg: "Login Sucess");
      } else {
        Fluttertoast.showToast(
            msg: "error",
            webBgColor: "linear-gradient(to right, #ff0000, #ff0000)");
      }

      setLoading(false);
      notifyListeners();
      return result;
    } catch (e) {
      setLoading(false);
      print(e.toString());
    }
  }

  Future<void> validate(BuildContext context) async {
    setLoading(true);
    // Make your login API call here using the http package

    ApiHelper.get("validate", "").then((value) {
      setLoading(false);
      if (value.statusCode == 200) {
        Fluttertoast.showToast(msg: "Token valid");
      } else {
        Navigator.pushNamed(context, RouteNames.login);
      }
    }).catchError((onError) {
      setLoading(false);
      log(onError.toString());
      // Fluttertoast.showToast(msg: onError.toString());
    });
  }

  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}
