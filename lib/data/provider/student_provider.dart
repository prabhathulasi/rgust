import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/exam_result_model.dart'
    as prefix;
import 'package:rugst_alliance_academia/data/model/student/student_course_model.dart';
import 'package:rugst_alliance_academia/data/model/student/student_detail_model.dart';
import 'package:rugst_alliance_academia/data/model/student/student_model.dart';

import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class StudentProvider extends ChangeNotifier {
  StudentModel studentModel = StudentModel();
  StudentRegisterCourseModel studentRegisterCourseModel =
      StudentRegisterCourseModel();

  prefix.ExamResultModel examResultModel = prefix.ExamResultModel();
  StudentDetailModel studentDetailModel = StudentDetailModel();
  List<StudentList> filteredList = [];
  List<dynamic> editResult = [];

  bool filteredEnable = false;

  // updated course from the Student
  bool _selectedCourseIndex = false;
  bool get selectedCourseIndex => _selectedCourseIndex;
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isAlertLoading = false;
  bool get isAlertLoading => _isAlertLoading;
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
  String get lastname => lastNamecontroller!;
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

  void filterStudent(String query) {
    filteredList = studentModel.studentList!
        .where((element) =>
            element.firstName!.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

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

  //  getStudent result
  Future getStudentResult(String token, int studentId) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("GetResult/id=$studentId", token);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        examResultModel = prefix.ExamResultModel.fromJson(data);

        return examResultModel;
      } else if (result.statusCode == 204) {
        examResultModel.result?.clear();

        ToastHelper().errorToast("No Result Data Added Yet");

        return null;
      } else if (result.statusCode == 401) {
        return "Invalid Token";
      } else {
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      ToastHelper().errorToast(e.toString());
      return null;
    } finally {
      setLoading(false);
    }
  }

  Future addStudent(String token,
      {required String registerNo,
      required int programId,
      required int classId,
      required String batch,
      required String admissionDate,
      required String gender,
      required String dob,
      required String studentType,
      required String userImage,
      required List<int> selectedCourseList}) async {
    setLoading(true);

    try {
      var result = await ApiHelper.post(
          "CreateStudent",
          {
            "StudentRegiterNumber": registerNo,
            "ProgramId": programId,
            "CurrentClassId": classId,
            "Batch": batch,
            "AdmissionDate": admissionDate,
            "FirstName": firstname,
            "LastName": lastname,
            "Email": email,
            "Gender": gender,
            "Mobile": int.parse(mobile),
            "DOB": dob,
            "Address": address,
            "FeesId": 1, // have to change this dynamically later
            "StudentType": studentType,
            "MailingAddress": mailingaddress,
            "PassportNumber": passport,
            "citizenship": cizizen,
            "UserImage": userImage,
            "Qualification": qualification,
            "EmergencyContact": int.parse(emergencyContact),
            "SelectedCourse": selectedCourseList
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

  Future getStudentDetailById(int studentId, String token) async {
    try {
      var result = await ApiHelper.get("GetStudentById/id=$studentId", token);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        studentDetailModel = StudentDetailModel.fromJson(data);

        return studentDetailModel;
      } else if (result.statusCode == 204) {
        ToastHelper().errorToast("No Courses Registered Yet");

        return null;
      } else if (result.statusCode == 401) {
        return "Invalid Token";
      } else {
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } on Exception catch (e) {
      ToastHelper().errorToast(e.toString());
      return e.toString();
    }
  }

  Future updateStudentClass(String token,
      {int? programId,
      int? classId,
      int? studentId,
      bool? currentClass,
      required List<int> selectedCourseList}) async {
    setLoading(true);
    try {
      var data = {
        "ProgramId": programId,
        "ClassId": classId,
        "StudentId": studentId,
        "SelectedCourse": selectedCourseList,
        "CurrentClass": currentClass
      };
      var result = await ApiHelper.post("UpdateStudentCourses", data, token);

      setLoading(false);
      var decodedJson = json.decode(result.body);
      if (result.statusCode == 200) {
        notifyListeners();
        ToastHelper().sucessToast(decodedJson["Message"]);
        return decodedJson;
      } else if (result.statusCode == 409) {
        notifyListeners();
        ToastHelper().errorToast(decodedJson["Message"]);

        return null;
      } else {
        notifyListeners();
        ToastHelper().errorToast(decodedJson["Message"]);
        return null;
      }
    } catch (e) {
      setLoading(false);
      ToastHelper().errorToast(e.toString());
      return null;
    }
  }

  updateStudentResultTable(List<prefix.Result> result) {
    editResult.clear();
    for (var examData in result) {
      editResult.add({
        "id": examData.iD,
        "coursecode": examData.courseCode,
        "coursename": examData.courseName,
        "batch": examData.batch,
        "cw1": examData.cw1,
        "cw2": examData.cw2,
        "cw3": examData.cw3,
        "cw4": examData.cw4,
        "finalexam": examData.finalMark,
        "grade": examData.grade
      });
    }

    return editResult;
  }

  updateStudentDetails(
    String token,
    String id, {
    required String admissionDate,
    required String gender,
    required String dob,
    required String studentType,
    required String userImage,
  }) async {
    setLoading(true);

    try {
      var result = await ApiHelper.put(
          "UpdateStudentDetails/id=$id ",
          {
            "AdmissionDate": admissionDate,
            "FirstName": firstname,
            "LastName": lastname,
            "Email": email,
            "Gender": gender,
            "Mobile": int.parse(mobile),
            "DOB": dob,
            "Address": address,
            "StudentType": studentType,
            "MailingAddress": mailingaddress,
            "PassportNumber": passport,
            "citizenship": cizizen,
            "UserImage": userImage,
          },
          token);
      var data = json.decode(result.body);

      if (result.statusCode == 200) {
        setEditStudentType(false);
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

  Future createAccount(String token, String email, String password,
      String userName, int studentId) async {
    setLoading(true);

    // Make your login API call here using the http package

    try {
      var result = await ApiHelper.post(
          "CreateAccount",
          {
            "email": email,
            "password": password,
            "usertype": "Student",
            "username": userName
          },
          token);
      setLoading(false);
      var data = json.decode(result.body);
      if (result.statusCode == 200) {
        ToastHelper().sucessToast("Account Created Sucessfully");
        await getStudentDetailById(studentId, token);
        notifyListeners();
        return data;
      } else if (result.statusCode == 403) {
        ToastHelper().errorToast(data["Message"]);
      } else {
        notifyListeners();
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      setLoading(false);
      ToastHelper().errorToast(e.toString());
      return null;
    }
  }

  Future updateFessByStudentId(String amountInGyd, String amountInUsd,
      int studentId, int classId, String tutitonType, String token) async {
    setAlertLoading(true);

    // Make your login API call here using the http package

    try {
      var result = await ApiHelper.put(
          "UpdateStudentFeesDetails",
          {
            "AmountInGyd": double.parse(amountInGyd),
            "AmountInUsd": double.parse(amountInUsd),
            "StudentId": studentId,
            "ClassId": classId,
            "TutitonType": tutitonType,
          },
          token);

      if (result.statusCode == 200) {
        ToastHelper().sucessToast("Fees Details Updated Successfully");
        await getStudentDetailById(studentId, token);

        return "200";
      } else if (result.statusCode == 409){
        ToastHelper().errorToast("Tution Detail Already Exists");
        return null;
      }else {
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      ToastHelper().errorToast(e.toString());
      return null;
    } finally {
      notifyListeners();
      setAlertLoading(false);
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
  void setHomeaddrss(String value) async {
    addresscontroller = value;
    notifyListeners();
  }

  // set address value
  void setmailaddrss(String value) async {
    mailingaddresscontroller = value;
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

  void setAlertLoading(bool value) async {
    _isAlertLoading = value;
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

  void setEnableFilter(bool value) {
    filteredEnable = value;
    notifyListeners();
  }

  void selectCourseIndex(bool value) {
    _selectedCourseIndex = value;
    notifyListeners();
  }

  clearStudentTemp() {
    _selectedCourseIndex = false;
    notifyListeners();
  }
}
