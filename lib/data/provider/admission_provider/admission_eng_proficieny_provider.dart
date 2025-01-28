import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rugst_alliance_academia/util/api_service.dart';

class AdmissionEngProficienyProvider extends ChangeNotifier {
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isEngProfiencyCompleted = false;
  bool get isEngProfiencyCompleted => _isEngProfiencyCompleted;
  //radio button
  String? engProficiencyRadioValue;
  String? engYearDropdownValue;
  String? engLevelDropdownValue;
  String? engExamRadioValue;

  String? selectedFileName;
  String? selectedFileBytes;

  var engYearsItems = ['Elementary', 'Intermediate', 'Advanced'];
  var engLevelItems = [
    'Less than 1 year',
    '1–3 years',
    '3–6 years',
    '6+ years'
  ];

  Future<http.Response> postAdmissionEngProfDetails(int applicationId) async {
    setLoading(true);
    var bodywithoutData = {
      "InternationalStudent": engProficiencyRadioValue == "Yes" ? true : false,
      "AdmissionID": applicationId,
    };
    var bodywithData = {
      "InternationalStudent": engProficiencyRadioValue == "Yes" ? true : false,
      "AdmissionID": applicationId,
      "EngExp": engYearDropdownValue,
      "EngLevel": engLevelDropdownValue,
      "ExamTaken": engExamRadioValue == "Yes" ? true : false,
      "Document": selectedFileBytes,
    };
    try {
      var result = await ApiHelper.post(
          "admissionEngProfDetails",
          engProficiencyRadioValue == "Yes" ? bodywithData : bodywithoutData,
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

  void setEngProficiencyValue(String value) async {
    engProficiencyRadioValue = value;
    notifyListeners();
  }

// eng studying years
  void setEngYearDropDownValue(String value) async {
    engYearDropdownValue = value;
    notifyListeners();
  }

//eng level
  void setEngLevalDropDownValue(String value) async {
    engLevelDropdownValue = value;
    notifyListeners();
  }

//eng exam
  void setEngExamValue(String value) async {
    engExamRadioValue = value;
    notifyListeners();
  }

  // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

// eng proficiency section isCompleted
  void setEngProficiencySectionValue(bool value) async {
    _isEngProfiencyCompleted = value;
    notifyListeners();
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
}
