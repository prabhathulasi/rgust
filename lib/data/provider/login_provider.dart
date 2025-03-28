import 'dart:convert';
import 'dart:developer';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';

import 'package:rugst_alliance_academia/util/api_service.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
 bool _isStudent = false;
  bool get isStudent => _isStudent;

  bool _passwordVisibility = true;
  bool get passwordVisibility => _passwordVisibility;

  String flavorUrl = FlavorConfig.instance.variables["baseUrl"];
  String flavorName = FlavorConfig.instance.variables["flavorName"];
  Future<http.Response> login(String email, String password) async {
    var bodyData = {"email": email, "password": password};
    setLoading(true);

    // Make your login API call here using the http package

    var result = await http.post(
      flavorName == "dev"
          ? Uri.parse("$flavorUrl/login")
          : Uri.https(flavorUrl, '/login'),
      body: jsonEncode(bodyData),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    setLoading(false);
    notifyListeners();
    return result;
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



// student apis

  Future<http.Response> studentLogin(String email, String password) async {
    var bodyData = {"email": email, "password": password};
    setLoading(true);

    // Make your login API call here using the http package

    var result = await http.post(
      flavorName == "dev"
          ? Uri.parse("$flavorUrl/mobile/studentlogin")
          : Uri.https(flavorUrl, '/mobile/studentlogin'),
      body: jsonEncode(bodyData),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    setLoading(false);
    notifyListeners();
    return result;
  }
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
    void setIsStudent(bool value) async {
    _isStudent = value;
    notifyListeners();
  }
   void setPasswordVisibility() async {
     _passwordVisibility = !_passwordVisibility;
    notifyListeners();
  }
}
