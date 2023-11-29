import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/student_course_model.dart';

import 'package:rugst_alliance_academia/data/model/student_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class StudentProvider extends ChangeNotifier {
  StudentModel studentModel = StudentModel();
  StudentRegisterCourseModel studentRegisterCourseModel = StudentRegisterCourseModel();
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
bool _isstudentTypeEdit = false;
  bool get isstudentTypeEdit => _isstudentTypeEdit;
  // Initial Selected Value
  String studetnTypeValue = 'Regular';
 var studentType = [
    'Regular',
    'Widthdraw',
    'Dropout',
    'Transfer',
    'Clinical',
    "Leaf of Absent"
  ];
  String? firstNamecontroller;
  String get firstname => firstNamecontroller!;
   String? studentRegisterNumberController;
  String get suddentregisterNumber => studentRegisterNumberController!;
  String? lastNamecontroller;
  String get lastname => firstNamecontroller!;
    String? emailcontroller;
  String get email => emailcontroller!;
  String? mobileController;
  String get mobile => mobileController!;
  String? addresscontroller;
  String get address => addresscontroller!;
    String? mailingaddresscontroller;
  String get mailingaddress => mailingaddresscontroller!;

   String? emergencyContactcontroller;
  String get emergencyContact => emergencyContactcontroller!;
    String? passportcontroller;
  String get passport => passportcontroller!;
  String? citizenshipcontroller;
  String get cizizen => citizenshipcontroller!;
 String? qualificationcontroller;
  String get qualification => qualificationcontroller!;


  int _isStandardFee = 1;
  int get isStandardFee => _isStandardFee;

  //  getStudent list
  Future getStudent(String token) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("GetStudent", token);
      setLoading(false);
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        studentModel = StudentModel.fromJson(data);

        notifyListeners();
     

        return studentModel;
      } else if (result.statusCode == 204) {
        studentModel.studentList?.clear();
        notifyListeners();
        ToastHelper().errorToast("No Student Added Yet");
  
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

  Future addStudent(
    String token, {
    required String registerNo,
    required int programId,
    required int classId,
    required String batch,
    required String admissionDate,
    required String gender,
    required String dob,
    required String studentType,
    required String userImage,
  }) async {
    setLoading(true);

    try {
      var result = await ApiHelper.post(
          "CreateStudent",
          {
            "StudentRegiterNumber": registerNo,
            "ProgramId": programId,
            "CurrentClassId": classId,
            "Batch": batch,
            "AdmissionDate":admissionDate,
            "FirstName": firstname,
            "LastName": lastname,
            "Email": email,
            "Gender": gender,
            "Mobile":int.parse(mobile),
            "DOB": dob,
            "Address": address,
            "FeesId": 1,// have to change this dynamically later
            "StudentType": studentType,
            "MailingAddress": mailingaddress,
            "PassportNumber":passport,
            "citizenship": cizizen,
            "UserImage": userImage,
            "Qualification":qualification,
            "EmergencyContact":int.parse(emergencyContact),
          },
          token);
      var data = json.decode(result.body);
    

      if (result.statusCode == 200) {
             setLoading(false);
        var data = json.decode(result.body);
        await getStudent(token);
   

        notifyListeners();
        ToastHelper().sucessToast("Student Added Sucessfully");

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

getStudentCourses(int studentId, String token)async{
   setLoading(true);
    try {
      var result = await ApiHelper.get("GetStudentCourses/id=$studentId", token);
      setLoading(false);
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        studentRegisterCourseModel = StudentRegisterCourseModel.fromJson(data);

        notifyListeners();
     

        return studentRegisterCourseModel;
      } else if (result.statusCode == 204) {
        studentRegisterCourseModel.studentCourses?.clear();
        notifyListeners();
        ToastHelper().errorToast("No Courses Registered Yet");
  
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

   void selectFeesType(int feeType) {
    _isStandardFee = feeType;
    notifyListeners();
  }

   void setStudentType(String studentType) {
    studetnTypeValue = studentType;
    notifyListeners();
  }
   void setEditStudentType(bool value) {
    _isstudentTypeEdit = value;
    notifyListeners();
  }
    // set qualification value
  void setqualification(String value) async {
    qualificationcontroller = value;
    notifyListeners();
  }
     // set qualification value
  void setStudentId(String value) async {
    studentRegisterNumberController = value;
    notifyListeners();
  }
}
