import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class ClincialProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int? selectedClinicalRadio;
  String? clincalStartDate;
  String? clincalEndDate;
  int? clincalFees;
//dropdown
  String? clinicalFeeRadioValue;

  Future postClinicalCourse(String? token, String? studentId) async {
    try {
      var result = await ApiHelper.post(
          "PostClinical",
          {
            "ClinicalId": selectedClinicalRadio,
            "StudentId": studentId,
            "StartDate": clincalStartDate,
            "EndDate": clincalEndDate,
            "Status": "",
            "TotalClinicalFee": clincalFees,
            "ClinicalFeeStatus": clinicalFeeRadioValue
          },
          token!);

      var data = json.decode(result.body);
      if (result.statusCode == 201) {
        ToastHelper().sucessToast("Clinical Rotation Registered Successfully");
        return result.statusCode;
  
      } else if (result.statusCode == 400) {
        ToastHelper().errorToast(data["Message"]);
        return result.statusCode;
      } else {
        ToastHelper().errorToast("Internal Server Error");
        return result.statusCode;
      }
    } catch (e) {
      return e.toString();
    } finally {
      notifyListeners();
      setLoading(false);
    }
  }

  void setFeesRadioValue(String value) async {
    clinicalFeeRadioValue = value;
    notifyListeners();
  }

//set clinial radio button value
  void setClinicalRadioButtonValue(int index) {
    selectedClinicalRadio = index;
    notifyListeners();
  }

  void setClinicalStartDate(String startDate) {
    clincalStartDate = startDate;
    notifyListeners();
  }

  void setClinicalendDate(String endDate) {
    clincalEndDate = endDate;
    notifyListeners();
  }

  // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}
