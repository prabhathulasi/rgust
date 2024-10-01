import 'package:flutter/material.dart';

class AdmissionProgramProvider extends ChangeNotifier {
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int startYear =DateTime.now().year -1 ; // Specify your start year
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
    var finInfo = ['Personal Savings', "Private Loans", "Partial- Scholarship","Family Sponsor","Federal Loans","Full Scholarship"];


   //radio buttons
   String? preEnrollRadio;

  //dropdown
  String? studentTypeDropdownvalue;
  String? programNamesDropdownvalue;
  String? semMonthDropDownValue;
  String? finInfoDropDownValue;
    int? semYearDropDownValue;


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
