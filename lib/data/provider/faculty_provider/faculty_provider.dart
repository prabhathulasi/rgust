import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rugst_alliance_academia/data/middleware/check_auth_middleware.dart';
import 'package:rugst_alliance_academia/data/model/ciricullam/attendance_model.dart';
import 'package:rugst_alliance_academia/data/model/ciricullam/ciricullam_model.dart';
import 'package:rugst_alliance_academia/data/model/ciricullam/class_session_model.dart';
import 'package:rugst_alliance_academia/data/model/faculty_model.dart';
import 'package:rugst_alliance_academia/data/model/faculty_registered_course_model.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class FacultyProvider extends ChangeNotifier {
  FacultyModel facultyModel = FacultyModel();

  final ciriculamKey = GlobalKey<FormState>();
  String? ciriculam;
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


   // loading indicator
  bool _isExpansionTileLoading = false;
  bool get isExpansionTileLoading => _isExpansionTileLoading;
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

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    // Don't call notifyListeners here as it will trigger rebuild
  }

  int? selectedCuriculumCourse;
  CiricullamListModel ciricullamListModel = CiricullamListModel();
  FacultyRegisteredCourseModel facultyRegisteredCourseModel =
      FacultyRegisteredCourseModel();
  AttendanceModel attendanceModel = AttendanceModel();

  ClassSessionModel classSessionModel = ClassSessionModel();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  void setStartDate(String value) {
    startDate.text = value;
    // notifyListeners();
  }

  void setEndDate(String value) {
    endDate.text = value;
  }

  List<String> ciriculamList = [];

  void addCiriculam(String ciriculam) {
    if (!ciriculamList.contains(ciriculam)) {
      ciriculamList.add(ciriculam);
      notifyListeners();
    } else {
      ToastHelper().errorToast("Ciriculam Already Added");
    }
  }

  // set ciriculam
  void setCiriculam(String value) {
    ciriculam = value;
  }

  Future<void> handleCiriculam(BuildContext context) async {
    if (ciriculamKey.currentState!.validate()) {
      ciriculamKey.currentState!.save();
      addCiriculam(ciriculam!);
      ciriculamKey.currentState!.reset();
      ToastHelper().sucessToast("Ciriculam Added Sucessfully");
    }
  }

  Future<void> deleteCiriculam(int index) async {
    ciriculamList.removeAt(index);
    ToastHelper().sucessToast("Ciriculam Deleted Sucessfully");

    notifyListeners();
  }

  Future postCiricullam(BuildContext context, String token,
      {int? courseId, int? facultyId}) async {
    setLoading(true);
    var body = {
      "course_id": courseId,
      "ciriculum_list": ciriculamList,
      "start_date": startDate.text,
      "end_date": endDate.text,
      "faculty_id": facultyId,
    };
    try {
      var result = await ApiHelper.post("post-course-ciricullam", body, token);

      if (result.statusCode == 200) {
        ToastHelper().sucessToast("Ciriculam Uploaded Sucessfully");
        getCiriculamList(token);
      } else if (result.statusCode == 409) {
        ToastHelper().errorToast("Ciriculam Already Added");
      } else {
        ToastHelper().errorToast("Internal Server Error");
      }
    } catch (e) {
      ToastHelper().errorToast(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future getCiriculamList(String token) async {
    setLoading(true);
    ciricullamListModel.ciriculum?.clear();

    try {
      var result = await ApiHelper.get(
          "get-course-ciricullam/id=$selectedCuriculumCourse", token);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        ciricullamListModel = CiricullamListModel.fromJson(data);

        return ciricullamListModel;
      } else if (result.statusCode == 400) {
        ToastHelper().errorToast("No Ciriculam Added Yet");
        return null;
      } else {
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      ToastHelper().errorToast(e.toString());
      return e.toString();
    } finally {
      setLoading(false);
    }
  }


  Future getAttendanceList(String token, int id) async {
    
    attendanceModel.sessions?.clear();

    try {
      var result = await ApiHelper.get(
          "get-class-session-list/id=$id", token);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        attendanceModel = AttendanceModel.fromJson(data);
        

        return attendanceModel;
      } else if (result.statusCode == 400) {
        ToastHelper().errorToast("No Attendance Added Yet");
        return null;
      } else {
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      ToastHelper().errorToast(e.toString());
      return e.toString();
    } 
  }


  Future getClassSessions(
      BuildContext context, int facultyId, String date) async {
        setExpansionTileLoading(true);
    classSessionModel.curriculums?.clear();
    classSessionModel.session = null;
    classSessionModel.students?.clear();
    var token = await getTokenAndUseIt();
    if (token == null) {
      if (context.mounted) {
        Navigator.pushNamed(context, RouteNames.login);
      }
    } else if (token == "Token Expired") {
      ToastHelper().errorToast("Session Expired Please Login Again");

      if (context.mounted) {
        Navigator.pushNamed(context, RouteNames.login);
      }
    } else {
      try {
        var result = await ApiHelper.get("get-class-session/$facultyId", token,
            queryParams: {"date": date});

        if (result.statusCode == 200) {
          var data = json.decode(result.body);

          classSessionModel = ClassSessionModel.fromJson(data);

          return classSessionModel;
        } else if (result.statusCode == 400) {
          classSessionModel.curriculums?.clear();
          classSessionModel.session = null;
          classSessionModel.students?.clear();
          ToastHelper()
              .errorToast("No Class Session Founded on the Selected Date");
          return null;
        } else {
          classSessionModel.curriculums?.clear();
          classSessionModel.session = null;
          classSessionModel.students?.clear();
          ToastHelper().errorToast("Internal Server Error");
          return null;
        }
      } catch (e) {
        ToastHelper().errorToast(e.toString());
        return e.toString();
      } finally {
        setExpansionTileLoading(false);
      }
    }
  }

  Future getRegisteredCourse(String token, int facultyId) async {
    setLoading(true);
    ciricullamListModel.ciriculum?.clear();
    facultyRegisteredCourseModel.data?.clear();

    try {
      var result = await ApiHelper.get("get-course-list/id=$facultyId", token);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        facultyRegisteredCourseModel =
            FacultyRegisteredCourseModel.fromJson(data);

        return facultyRegisteredCourseModel;
      } else if (result.statusCode == 400) {
        ToastHelper().errorToast("No Ciriculam Added Yet");
        return null;
      } else {
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      ToastHelper().errorToast(e.toString());
      return e.toString();
    } finally {
      setLoading(false);
    }
  }

//  getFaculty list
  Future getFacultyList(String token) async {
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
      String token, String email, String password, String userName) async {
    setLoading(true);

    // Make your login API call here using the http package

    try {
      var result = await ApiHelper.post(
          "CreateAccount",
          {
            "email": email,
            "password": password,
            "usertype": "Faculty",
            "username": userName
          },
          token);
      setLoading(false);
      var data = json.decode(result.body);
      if (result.statusCode == 200) {
        await getFacultyList(token);
        ToastHelper().sucessToast("Account Created Sucessfully");
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
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future addFaculty(String token,
      {required int programId,
      required int classId,
      required int courseId,
      required int year,
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
            "courseId": courseId,
            "year": year,
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

      if (result.statusCode == 201) {
        var data = json.decode(result.body);
        await getFacultyList(token);

        ToastHelper().sucessToast("Faculty Added Sucessfully");

        return data;
      } else {
        ToastHelper().errorToast(data["message"]);
        return null;
      }
    } catch (e) {
      ToastHelper().errorToast(e.toString());
      return null;
    } finally {
      setLoading(false);
    }
  }

  Future updateCourseInFaculty(
    String token, {
    required int programId,
    required int classId,
    required String courseId,
    required int facultyId,
  }) async {
    setLoading(true);

    try {
      var result = await ApiHelper.post(
          "AddCourseFaculty",
          {
            "programId": programId,
            "classId": classId,
            "courseId": courseId,
            "facultyId": facultyId,
          },
          token);
      var data = json.decode(result.body);
      print(data);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);
        await getFacultyList(token);
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
      required int id}) async {
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
        await getFacultyList(token);
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

  void setSelectedCiriculumCourse(int? value, BuildContext context) async {
    var token = await getTokenAndUseIt();
    if (token == null) {
      if (context.mounted) {
        Navigator.pushNamed(context, RouteNames.login);
      }
    } else if (token == "Token Expired") {
      ToastHelper().errorToast("Session Expired Please Login Again");

      if (context.mounted) {
        Navigator.pushNamed(context, RouteNames.login);
      }
    } else {
      selectedCuriculumCourse = value;

      getCiriculamList(token);
    }
  }

  void clearCiriculumCourse() {
    selectedCuriculumCourse = null;
    notifyListeners();
  }

  void setEnableFilter(bool value) {
    filteredEnable = value;
    notifyListeners();
  }
  void setExpansionTileLoading(bool value) {
    _isExpansionTileLoading = value;
    notifyListeners();
  }
}
