import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rugst_alliance_academia/data/model/faculty_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class FacultyProvider extends ChangeNotifier {
  FacultyModel facultyModel = FacultyModel();
  
  List<FacultyList> filteredList = [];
  bool filteredEnable = false;
  // to choose dp for new user or existing user
  int _selectedIndex = -1;
  int get selectedIndex => _selectedIndex;
  // updated course from the faculty
   int _selectedCourseIndex = -1;
   int get selectedCourseIndex => _selectedCourseIndex;
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
// gender edit in updatefaculty
  bool _isGenderEdited = false;
  bool get isGenderEdited => _isGenderEdited;
  // jobtype edit in updatefaculty
  bool _isJobTypeEdit = false;
  bool get isjobTypeEdit => _isJobTypeEdit;

// change the value of radio button in add faculty screen
  bool _isNewUser = false;
  bool get isNewUser => _isNewUser;

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

  void filterFaculty(String query) {
    filteredList = facultyModel.facultyList!
        .where((element) =>
            element.firstName!.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void selectTile(int index) {
    if (_selectedIndex == index) {
      // If the same tile is selected again, unselect it
      _selectedIndex = -1;
    } else {
      _selectedIndex = index;
      notifyListeners();
    }
  }
 void selectCourseIndex(int index) {
    if (_selectedCourseIndex == index) {
      // If the same tile is selected again, unselect it
      _selectedCourseIndex = -1;
    } else {
      _selectedCourseIndex = index;
      notifyListeners();
    }
  }
//  getFaculty list
  Future getFaculty(String token) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("GetFaculty", token);
      setLoading(false);
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        facultyModel = FacultyModel.fromJson(data);

        notifyListeners();

        return facultyModel;
      } else if (result.statusCode == 204) {
        notifyListeners();
        ToastHelper().errorToast("No Faculty Added Yet");
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

  Future createAccount(
      String token, String email, String password,String userName) async {
    setLoading(true);

    // Make your login API call here using the http package

    try {
      var result = await ApiHelper.post("CreateAccount",
          {"email": email, "password": password, "usertype": "Faculty","username":userName}, token);
      setLoading(false);
       var data = json.decode(result.body);
      if (result.statusCode == 200) {
     await  getFaculty(token);
        ToastHelper().sucessToast("Account Created Sucessfully");
        notifyListeners();
        return data;
      }else if(result.statusCode == 403){
        ToastHelper().errorToast(data["Message"]);
      } else {
        notifyListeners();
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      setLoading(false);
      Fluttertoast.showToast(msg: e.toString());
      return null;
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
      print(data);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);
        await getFaculty(token);
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
      return null;
    }
  }

  Future updateCourseInFaculty(
    String token, {
    required int programId,
    required int classId,
    required String courseCode,
    required String courseName,
    required String batch,
    required int facultyId,
  }) async {
    setLoading(true);

    try {
      var result = await ApiHelper.post(
          "AddCourseFaculty",
          {
            "programId": programId,
            "classId": classId,
            "courseCode": courseCode,
            "courseName": courseName,
            "batch": batch,
            "facultyId": facultyId,
          },
          token);
      var data = json.decode(result.body);
      print(data);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);
        await getFaculty(token);
        setLoading(false);

        notifyListeners();
        ToastHelper().sucessToast(data["result"]);

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

  updateFacultyDetails(String token,
      {required String updatedfirstName,
      required String updatedlastName,
      required String updatedemail,
      required String updatedmobile,
    required String updatedaddress,
    required String updatedQualifiation,
    required String updatedpassportNumber,
    required String updatedcitizenship,
        required String updatedfacultyId,
      required String updatedgender,
      required String updateddob,
      required String updatedjoiningDate,
      required String updateduserImage,
      required String updatedjobType,
      required int id
      })async{
        setLoading(true);
        try {
      var result = await ApiHelper.put(
          "UpdateFaculty/id=$id",
          {
            
            "facultyId": updatedfacultyId,
            "firstName": updatedfirstName,
            "lastName": updatedlastName,
            "email": updatedemail,
            "gender": updatedgender,
            "mobile": updatedmobile,
            "dob": updateddob,
            "address": updatedaddress,
            "Qualifiation": updatedQualifiation,
            "salary": 1,
            "joiningDate": updatedjoiningDate,
            "jobType": updatedjobType,
            "passportNumber": updatedpassportNumber,
            "citizenship": updatedcitizenship,
            "userImage": updateduserImage
          },
          token);
      var data = json.decode(result.body);
      

      if (result.statusCode == 200) {
        var data = json.decode(result.body);
        await getFaculty(token);
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

// set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

// select new user or existing user
  void selectUserType(bool isNew) {
    _isNewUser = isNew;
    notifyListeners();
  }

  // edit gender
  void updateGender(bool value) {
    _isGenderEdited = value;
    notifyListeners();
  }

  void updateJobType(bool value) {
    _isJobTypeEdit = value;
    notifyListeners();
  }

  void setEnableFilter(bool value) {
    filteredEnable = value;
    notifyListeners();
  }
}
