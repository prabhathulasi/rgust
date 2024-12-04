import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rugst_alliance_academia/data/model/clinical/clinical_course_model.dart';
import 'package:rugst_alliance_academia/data/model/clinical/clinical_registration_model.dart';
import 'package:rugst_alliance_academia/data/model/course_model.dart';
import 'package:rugst_alliance_academia/data/model/program_class_model.dart';
import 'package:rugst_alliance_academia/data/model/program_model.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class ProgramProvider extends ChangeNotifier {
  int startYear = 2010; // Specify your start year
  int endYear = DateTime.now().year; // Specify your end year (current year)
  int selectedYear = DateTime.now().year;
  ProgramModel programModel = ProgramModel();
  ProgramClassModel programClassModel = ProgramClassModel();
  CoursesModel coursesModel = CoursesModel();
  ClinicalCoursesModel clinicalCoursesModel = ClinicalCoursesModel();
  ClinicalRegistrationModel clinicalRegistrationModel =
      ClinicalRegistrationModel();
  bool showCreateButton = false;
  List<dynamic> newData = [];
  String? selectedDept;
  String? selectedClass;
  String? selectedBatch;
  String? selectedCourse;
  String? selectedCourseName;

  int _isNewStudent = 1;
  int get isNewStudent => _isNewStudent;
// change the value of radio button in add faculty screen
  bool _isCore = false;
  bool get isCore => _isCore;

  ProgramModel get getDepts => programModel;
  ProgramClassModel get getDeptsClass => programClassModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
 bool filteredEnable = false;
// get program list
  Future getProgram(String token) async {
    var result = await ApiHelper.get("getProgram", token);
    try {
      if (result.statusCode == 200) {
        setLoading(false);
        var data = json.decode(result.body);

        programModel = ProgramModel.fromJson(data);

        notifyListeners();

        return programModel;
      } else if (result.statusCode == 401) {
        setLoading(false);
        notifyListeners();

        return "Invalid token";
      } else {
        setLoading(false);
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

// get classes list
  Future getClasses(String token) async {
    var result = await ApiHelper.get("getProgramClass/$selectedDept", token);
    try {
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        programClassModel = ProgramClassModel.fromJson(data);

        return programClassModel;
      } else {
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return e.toString();
    } finally {
      notifyListeners();
      setLoading(false);
    }
  }

// get course List depend on the selected class and the batch
  Future getCoursesList(String token) async {
    setLoading(true);
    var result = await ApiHelper.get("GetCourse/id=$selectedClass", token);
    try {
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        coursesModel = CoursesModel.fromJson(data);

        newData.clear();
        for (var result in data["Courses"]) {
          newData.add({
            "coursecode": result["CourseId"],
            "coursename": result["CourseName"],
            "credits": result["Credits"],
            "lectures": result["AssignedLec"] == ""
                ? "Not Assigned"
                : result["AssignedLec"]
          });
        }

        return newData;
      } else if (result.statusCode == 204) {
        ToastHelper().errorToast("No Courses Added Yet");
        return null;
      } else {
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return e.toString();
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

// get course List depend on the selected class and the batch
  Future getAllCoursesList(String token) async {
    setLoading(true);
    var result = await ApiHelper.get("GetAllCourse", token);
    try {
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        coursesModel = CoursesModel.fromJson(data);

        return coursesModel;
      } else if (result.statusCode == 204) {
        ToastHelper().errorToast("No Courses Added Yet");
        return null;
      } else {
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return e.toString();
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

// create course or add new course
  Future postCoursesList(String? token,
      {String? courseid, String? courseName, int? credits}) async {
    try {
      var result = await ApiHelper.post(
          "PostCourse",
          {
            "ProgramId": int.parse(selectedDept!),
            "ClassId": int.parse(selectedClass!),
            "CourseId": courseid,
            "CourseName": courseName,
            "credits": credits,
            // "batch": selectedBatch
          },
          token!);

      var data = json.decode(result.body);
      if (result.statusCode == 200) {
        setLoading(false);
        ToastHelper().sucessToast("Course Added Successfully");
        await getCoursesList(token);
        notifyListeners();
      } else if (result.statusCode == 409) {
        setLoading(false);
        notifyListeners();
        ToastHelper().errorToast(data["Message"]);
        return null;
      } else {
        setLoading(false);
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

  // get course List depend on the selected class and the batch
  Future getClinicalCourses(String token) async {
    setLoading(true);
    var result = await ApiHelper.get("GetClinical", token);
    try {
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        clinicalCoursesModel = ClinicalCoursesModel.fromJson(data);

        return clinicalCoursesModel;
      } else if (result.statusCode == 204) {
        ToastHelper().errorToast("No Clinical Courses Added Yet");
        return null;
      } else {
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future getClinicalRegistrations(String token, int studentId) async {
    setLoading(true);
    var result =
        await ApiHelper.get("GetClinicalStudentRegistration/$studentId", token);
    try {
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        clinicalRegistrationModel = ClinicalRegistrationModel.fromJson(data);

        return clinicalRegistrationModel;
      } else if (result.statusCode == 204) {
        ToastHelper().errorToast("No Record Found");
        return null;
      } else {
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return e.toString();
    } finally {
      setLoading(false);
    }
  }

// create course or add new course
  Future postClinicalCourse(String? token,
      {String? rotationName, int? duration, int? credits}) async {
    try {
      var result = await ApiHelper.post(
          "PostClinical",
          {
            "ProgramId": int.parse(selectedDept!),
            "RotationName": rotationName,
            "RotationCredits": credits,
            "RotationDuration": duration,
            "RotationType": _isCore == false ? "Core" : "Elective"
          },
          token!);

      var data = json.decode(result.body);
      if (result.statusCode == 200) {
        ToastHelper().sucessToast("Course Added Successfully");
        await getClinicalCourses(token);
      } else if (result.statusCode == 409) {
        ToastHelper().errorToast(data["Message"]);
        return null;
      } else {
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return e.toString();
    } finally {
      notifyListeners();
      setLoading(false);
    }
  }

//TODO have to parse the token and complete the patch work in front end
// create course or add new course
  Future<void> patchCoursesList(BuildContext context,
      {String? courseid, String? courseName, int? credits}) async {
    ApiHelper.post(
            "UpdateCourse/id=$courseid",
            {
              "CourseId": courseid,
              "CourseName": courseName,
              "credits": credits,
            },
            "")
        .then((value) async {
      setLoading(false);
// if 200 return response
      if (value.statusCode == 200) {
        Fluttertoast.showToast(msg: "Course Added Successfully");
        // await getCoursesList(context);
        notifyListeners();
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
List<Courses> filteredCourse = [];

 void filterCourses(String query) {
    filteredCourse = coursesModel.courses!
        .where((element) =>
            element.courseName!.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
  void setEnableFilter(bool value) {
    filteredEnable = value;
    notifyListeners();
  }

// set program or dept
  void setSelectedDept(String value, String token) async {
    selectedDept = value;
    selectedClass = null;
    selectedCourse = null;
    newData.clear();
    notifyListeners();
    if (value != "300") {
      await getClasses(token);
    } else {
      getClinicalCourses(token);
    }
  }

//set class
  void setSelectedClass(String value, String token, bool isUpdatingStudent) {
    selectedClass = value;
    // is updating student is falsue show only filtered course list depend on selected class else show full course list from the db
    if (isUpdatingStudent == false) {
      getCoursesList(token);
    }

   
    

    selectedBatch = null;
    selectedCourse = null;

    notifyListeners();
  }

// set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

// set  new year
  void setSelectedYear(int value) {
    selectedYear = value;
    selectedCourse = null;
    selectedBatch = null;
    newData.clear();
    notifyListeners();
  }

// show create button
  void setCreateButton(bool value) {
    showCreateButton = value;
    notifyListeners();
  }

// set batch
  void setSelectedBatch(
      String value, String token, bool isUpdatingStudent) async {
    // is updating student is falsue show only filtered course list depend on selected class else show full course list from the db
    if (isUpdatingStudent == true) {
      getAllCoursesList(token);
    }
    selectedBatch = value;

    notifyListeners();
  }

// set course
  void setSelectedCourse(String value) {
    selectedCourse = value;
    notifyListeners();
  }

  // set course
  void setSelectedCourseName(String value) {
    selectedCourseName = value;
    notifyListeners();
  }

  void selectStudentType(int isNew) {
    _isNewStudent = isNew;
    notifyListeners();
  }

  clearAllTemp() {
    selectedDept = null;
    selectedClass = null;
    selectedBatch = null;
    newData.clear();
    notifyListeners();
  }

  // select core or elective rotation
  void selectRotationType(bool isNew) {
    _isCore = isNew;
    notifyListeners();
  }
}
