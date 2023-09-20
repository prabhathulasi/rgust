import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rugst_alliance_academia/data/model/faculty_model.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';

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
  Future<void> getFaculty(BuildContext context) async {
    await ApiHelper.get("GetFaculty").then((value) {
      setLoading(false);
// if 200 return response
      if (value.statusCode == 200) {
        var data = json.decode(value.body);

        facultyModel = FacultyModel.fromJson(data);

        notifyListeners();

        return facultyModel;
      }
      // if 401 or 402 return token expired
      else {
        Fluttertoast.showToast(msg: "Token Expired Please Login Again");
        Navigator.pushNamed(context, RouteNames.login);
        return null;
      }
      // catch error
    }).catchError((onError) {
      setLoading(false);
      Fluttertoast.showToast(msg: "Internal Server Error");
      return null;
    });
  }

  Future<void> addFaculty(BuildContext context,
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
    await ApiHelper.post("CreateFaulty", {
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
    }).then((value) {
      setLoading(false);
// if 200 return response
      if (value.statusCode == 200) {
        setLoading(false);
        notifyListeners();
        Fluttertoast.showToast(msg: "Faculty Added Sucessfully");
        Navigator.pop(context);
      }
      // if 401 or 402 return token expired
      else {
         setLoading(false);
        Fluttertoast.showToast(msg: "Token Expired Please Login Again");
        Navigator.pushNamed(context, RouteNames.login);
        return null;
      }
      // catch error
    }).catchError((onError) {
      setLoading(false);
      Fluttertoast.showToast(msg: onError.toString());
      return null;
    });
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
