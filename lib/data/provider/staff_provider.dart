import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/staff_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';


class StaffProvider extends ChangeNotifier{
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
  String? desiginationController;
  String get designation => desiginationController!;
StaffModel staffModel = StaffModel();

  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

  //  getStaff list
  Future getStaffList(String token) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("GetStaff", token);
      setLoading(false);
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        staffModel = StaffModel.fromJson(data);

        notifyListeners();

        return staffModel;
      } else if (result.statusCode == 204) {
        notifyListeners();
        ToastHelper().errorToast("No Staff Added Yet");
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


  createStaff(String token, {required String staffId,
  required String gender,
  required String dob,
  required String joiningDate,
  required String jobType,
  required String userImage
  
  })async{
    setLoading(true);

    try {
      var result = await ApiHelper.post(
          "CreateStaff",
          {
          
            "staffId": staffId,
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
            "userImage": userImage,
            "designation":designation
          },
          token);
      var data = json.decode(result.body);
      print(data);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);
        await getStaffList(token);
        setLoading(false);

        notifyListeners();
        ToastHelper().sucessToast("Staff Added Sucessfully");

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
      return null;
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

 // set designation value
  void setDesignation(String value) async {
    desiginationController = value;
    notifyListeners();
  }
}



