import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rugst_alliance_academia/data/model/faculty_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class FacultyProvider extends ChangeNotifier {
  FacultyModel facultyModel = FacultyModel();
  FacultyModel get getDepts => facultyModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? firstNamecontroller;
  String get firstname => firstNamecontroller!;
  String? lastNamecontroller;
  String get lastname => lastNamecontroller!;
  String? emailcontroller;
  String get email => emailcontroller!;
  String? mobileController;
  String get mobile => mobileController!;
  String? addresscontroller;
  String get address => addresscontroller!;
  String? qualificationcontroller;
  String get qualification => qualificationcontroller!;
// not using the salary as of now
  String? salarycontroller;
  String? passportcontroller;
  String get passport => passportcontroller!;
  String? citizenshipcontroller;
  String get cizizen => citizenshipcontroller!;

//  getFaculty list
  Future getFaculty(String token) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("GetFaculty", token);
      if (result.statusCode == 200) {
        setLoading(false);
        var data = json.decode(result.body);

        facultyModel = FacultyModel.fromJson(data);

        notifyListeners();

        return facultyModel;
      } else {
        setLoading(false);
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

  Future createAccount(
      String token, String email, String password, String userType) async {
    setLoading(true);

    // Make your login API call here using the http package

    try {
      var result = await ApiHelper.post("CreateAccount",
          {"email": email, "password": password, "usertype": "Faculty"}, token);
      setLoading(false);
      if (result.statusCode == 200) {
        var data = json.decode(result.body);
        ToastHelper().sucessToast("Account Created Sucessfully");
        return data;
      } else {
        notifyListeners();
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      setLoading(false);
      Fluttertoast.showToast(msg: e.toString());
      return e.toString();
    }
  }

  Future addFaculty(String token,
      {required int programId,
      required int classId,
      required String courseCode,
      required String courseName,
      required String batch,
      required String facultyId,
      required String gender,
      required String dob,
      required String joiningDate,
      required String userImage,
      required String jobType}) async {
    setLoading(true);

    try {
      var result = await ApiHelper.post(
          "CreateFaulty",
          {
            "programId": programId,
            "classId": classId,
            "courseCode": courseCode,
            "courseName": courseName,
            "batch": batch,
            "facultyId": facultyId,
            "firstName": firstname,
            "lastName": lastname,
            "email": email,
            "gender": gender,
            "mobile": mobile,
            "dob": dob,
            "address": address,
            "Qualifiation": qualification,
            "salary": 1,
            "joiningDate": joiningDate,
            "jobType": jobType,
            "passportNumber": passport,
            "citizenship": cizizen,
            "userImage": userImage
          },
          token);
      var data = json.decode(result.body);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);
        setLoading(false);
        notifyListeners();
        ToastHelper().sucessToast("Faculty Added Sucessfully");
        return data;
      } else {
        setLoading(false);
        notifyListeners();
        ToastHelper().errorToast(data["Message"]);
        return null;
      }
    } catch (e) {
      setLoading(false);
      ToastHelper().errorToast(e.toString());
      return e.toString();
    }
  }

// set FIRSTNAME value
  void setfirstName(String value) async {
    firstNamecontroller = value;
    notifyListeners();
  }

  // set LASTNAME value
  void setLastName(String value) async {
    lastNamecontroller = value;
    notifyListeners();
  }

  // set email value
  void setemail(String value) async {
    emailcontroller = value;
    notifyListeners();
  }

  // set mobile value
  void setMobile(String value) async {
    mobileController = value;
    notifyListeners();
  }

  // set address value
  void setaddrss(String value) async {
    addresscontroller = value;
    notifyListeners();
  }

  // set qualification value
  void setqualification(String value) async {
    qualificationcontroller = value;
    notifyListeners();
  }

  // set passport value
  void setpassport(String value) async {
    passportcontroller = value;
    notifyListeners();
  }

  // set passport value
  void setcitizen(String value) async {
    citizenshipcontroller = value;
    notifyListeners();
  }

// set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}
