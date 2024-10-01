import 'package:flutter/material.dart';

class AdmissionStandTestProvider  extends ChangeNotifier{



var testItems = [
    'SAT',
    'MCAT',
    'TOEFL',
    'IELTS',
    'GRE',
    'USMLE1/2CS/2CK',
    "Other Admission/Entrance Test"
  ];
  //radio button
  String? standTestRadioValue;
 //dropdown 
  String? testDropdownvalue;

  void setTestRadioValue(String value) async {
    standTestRadioValue = value;
    notifyListeners();
  }



    
// title
void setTestDropDownValue(String value) async {
    testDropdownvalue = value;
  notifyListeners();
  }
}