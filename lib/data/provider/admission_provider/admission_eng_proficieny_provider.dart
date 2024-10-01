import 'package:flutter/material.dart';

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

  var engYearsItems = ['Elementary', 'Intermediate', 'Advanced'];
  var engLevelItems = [
    'Less than 1 year',
    '1–3 years',
    '3–6 years',
    '6+ years'
  ];

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
}
