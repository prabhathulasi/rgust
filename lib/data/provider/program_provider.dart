import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rugst_alliance_academia/data/model/course_model.dart';
import 'package:rugst_alliance_academia/data/model/program_class_model.dart';
import 'package:rugst_alliance_academia/data/model/program_model.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';

class ProgramProvider extends ChangeNotifier {
  int startYear = 2022; // Specify your start year
  int endYear = DateTime.now().year; // Specify your end year (current year)
  int selectedYear = DateTime.now().year;
  ProgramModel programModel = ProgramModel();
  ProgramClassModel programClassModel = ProgramClassModel();
  CoursesModel coursesModel = CoursesModel();
  bool showCreateButton = false;
  List<dynamic> newData = [];
  String? selectedDept;
  String? selectedClass;
  String? selectedBatch;
  String? selectedCourse;
  String? selectedCourseName;

  ProgramModel get getDepts => programModel;
  ProgramClassModel get getDeptsClass => programClassModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

// get program list
  Future<void> getProgram(BuildContext context) async {
    ApiHelper.get("getProgram", "").then((value) async {
      setLoading(false);
// if 200 return response
      if (value.statusCode == 200) {
        var data = json.decode(value.body);

        programModel = ProgramModel.fromJson(data);

        notifyListeners();

        return programModel;
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

// get classes list
  Future<void> getClasses(BuildContext context) async {
    ApiHelper.get("getProgramClass/$selectedDept", "").then((value) {
      setLoading(false);
// if 200 return response
      if (value.statusCode == 200) {
        var data = json.decode(value.body);

        programClassModel = ProgramClassModel.fromJson(data);

        notifyListeners();

        return programClassModel;
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

// get course List depend on the selected class and the batch
  Future<void> getCoursesList(BuildContext context) async {
    ApiHelper.get("GetCourse/id=$selectedClass/batch=$selectedBatch", "")
        .then((value) {
      setLoading(false);
// if 200 return response
      if (value.statusCode == 200) {
        var data = json.decode(value.body);

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

        notifyListeners();

        return newData;
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
      newData.clear();

      Fluttertoast.showToast(msg: onError.toString(), timeInSecForIosWeb: 10);
      return null;
    });
  }

// create course or add new course
  Future<void> postCoursesList(BuildContext context,
      {String? courseid, String? courseName, int? credits}) async {
    ApiHelper.post("PostCourse", {
      "ProgramId": int.parse(selectedDept!),
      "ClassId": int.parse(selectedClass!),
      "CourseId": courseid,
      "CourseName": courseName,
      "credits": credits,
      "batch": selectedBatch
    }).then((value) async {
      setLoading(false);
// if 200 return response
      if (value.statusCode == 200) {
        Fluttertoast.showToast(msg: "Course Added Successfully");
        await getCoursesList(context);
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

// create course or add new course
  Future<void> patchCoursesList(BuildContext context,
      {String? courseid, String? courseName, int? credits}) async {
    ApiHelper.post("UpdateCourse/id=$courseid", {
      "CourseId": courseid,
      "CourseName": courseName,
      "credits": credits,
    }).then((value) async {
      setLoading(false);
// if 200 return response
      if (value.statusCode == 200) {
        Fluttertoast.showToast(msg: "Course Added Successfully");
        await getCoursesList(context);
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

// set program or dept
  void setSelectedDept(String value, BuildContext context) async {
    selectedDept = value;
    selectedClass = null;
    selectedCourse = null;

    notifyListeners();
    await getClasses(context);
  }

//set class
  void setSelectedClass(String value, BuildContext context) {
    selectedClass = value;
    selectedBatch = null;
    selectedCourse = null;
    newData.clear();

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
    notifyListeners();
  }

// show create button
  void setCreateButton(bool value) {
    showCreateButton = value;
    notifyListeners();
  }

// set batch
  void setSelectedBatch(String value, BuildContext context) async {
    selectedBatch = value;
    getCoursesList(context);
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
}
