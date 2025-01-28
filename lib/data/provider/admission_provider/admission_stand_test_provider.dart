import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rugst_alliance_academia/util/api_service.dart';

class AdmissionStandTestProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

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

  String? location;
  String? totalAttempts;
  String? score;

  TextEditingController examDate = TextEditingController();

  Future<http.Response> postAdmissionStandTestDetails(int admissionId) async {
    setLoading(true);
    var bodywithoutData = {
      "TestTaken": standTestRadioValue == "Yes" ? true : false,
      "AdmissionID": admissionId,
    };
    var bodywithData = {
      "TestTaken": standTestRadioValue == "Yes" ? true : false,
      "AdmissionID": admissionId,
      "TestName": testDropdownvalue,
      "TestLocation": location,
      "TestDate": examDate.text,
      "TestAttempts": totalAttempts,
      "TestScore": score
    };
    try {
      var result = await ApiHelper.post("admissionStandTestDetails",
          standTestRadioValue == "Yes" ? bodywithData : bodywithoutData, "");

      return result;
      //api call
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  void setTestRadioValue(String value) async {
    standTestRadioValue = value;
    notifyListeners();
  }

  void setExamDate(String endDate) {
    examDate.text = endDate;
    notifyListeners();
  }

// title
  void setTestDropDownValue(String value) async {
    testDropdownvalue = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
