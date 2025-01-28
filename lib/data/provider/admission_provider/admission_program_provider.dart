import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';

class AdmissionProgramProvider extends ChangeNotifier {
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int startYear = DateTime.now().year - 1; // Specify your start year
  int endYear = DateTime.now().year; // Specify your end year (current year)
  var studentType = [
    'New Student',
    'Transfer Student',
    'Re-Admission',
  ];
  var programNames = [
    'Pre-Medicine',
    'Doctor of Medicine(MD/MBBS)',
  ];
  var semMonth = ['January', "May", "September"];
  var finInfo = [
    'Personal Savings',
    "Private Loans",
    "Partial- Scholarship",
    "Family Sponsor",
    "Federal Loans",
    "Full Scholarship"
  ];

  //radio buttons
  String? preEnrollRadio;

  //dropdown
  String? studentTypeDropdownvalue;
  String? programNamesDropdownvalue;
  String? semMonthDropDownValue;
  String? finInfoDropDownValue;
  int? semYearDropDownValue;

  String? selectedFileName;
  String? selectedFileBytes;
  String ?enrolledUniversityName;
  String ?enrolledProgramName;

  Future<http.Response> postAdmissionProgramDetails(
      int applicationStatus, int applicationId) async {
    setLoading(true);
    var bodywithoutFile ={
   "StudentType": studentTypeDropdownvalue,
            "ProgramName": programNamesDropdownvalue,
            "YearOfAdmission": semYearDropDownValue.toString(),
            "Semester": semMonthDropDownValue,
            "FinancialType": finInfoDropDownValue,
            "AlreadyEnrolled": preEnrollRadio == "Yes" ? true : false,
            "AdmissionID": applicationId,
            "ApplicationStatus": 2,
    };
    var bodywithFile = {
            "StudentType": studentTypeDropdownvalue,
            "ProgramName": programNamesDropdownvalue,
            "YearOfAdmission": semYearDropDownValue.toString(),
            "Semester": semMonthDropDownValue,
            "FinancialType": finInfoDropDownValue,
            "AlreadyEnrolled": preEnrollRadio == "Yes" ? true : false,
            "AdmissionID": applicationId,
            "ApplicationStatus": 2,
            "UniversityName":enrolledUniversityName ,
            "EnrolledProgramName":enrolledProgramName,
            "TransferDocument":selectedFileBytes,
    };
    try {
      var result = await ApiHelper.post(
          "admissionProgramDetails",
          preEnrollRadio == "Yes" ? bodywithFile : bodywithoutFile,
          "");

      return result;
      //api call
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  void addFile(String name, String bytes) {
    selectedFileName = name;
    selectedFileBytes = bytes;
    notifyListeners();
  }

  void clearFile() {
    selectedFileName = null;
    selectedFileBytes = null;
    notifyListeners();
  }

// studentType
  void setStudentTypeDropDownValue(String value) async {
    studentTypeDropdownvalue = value;
    notifyListeners();
  }

  // program applying for
  void setprogramNamesDropDownValue(String value) async {
    programNamesDropdownvalue = value;
    notifyListeners();
  }

  //sem year
  void setSemYearDropDownValue(int value) async {
    semYearDropDownValue = value;
    notifyListeners();
  }

  //sem month
  void setSemMonthDropDownValue(String value) async {
    semMonthDropDownValue = value;
    notifyListeners();
  }

  //sem month
  void setFinInfoDropDownValue(String value) async {
    finInfoDropDownValue = value;
    notifyListeners();
  }

// preenrollment
  void setPreEnrollRadioValue(String value) async {
    preEnrollRadio = value;
    notifyListeners();
  }

  // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}
