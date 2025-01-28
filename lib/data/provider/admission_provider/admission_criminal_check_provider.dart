import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rugst_alliance_academia/util/api_service.dart';

class AdmissionCriminalCheckProvider extends ChangeNotifier {
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> dataList = [
    {
      "title":
          "Any criminal background information including copies of my past and present law enforcement records. This criminal background investigation is being conducted for the purpose of assistance to the Rajiv Gandhi University of Science and Technology and/or the clinical affiliate/agency and/or for student visa purposes if required in evaluating my suitability for the program I am applying for. The release of the information pertaining to this criminal background investigation is expressly authorized.",
      "isChecked": false
    },
    {
      "title":
          "I also understand that information obtained via criminal background checks and relevant reports may result in being denied, full admission to the program, Clinical assignment student visa, and, consequently, dismissal from the program and the university.",
      "isChecked": false
    },
    {
      "title":
          "I will be afforded the opportunity to be heard before any such withdrawal from the Rajiv Gandhi University of Science and Technology Georgetown, Guyana.",
      "isChecked": false
    },
    {
      "title":
          "I understand that I have a right to review the information that the program receives in this criminal background investigation by putting a request in writing to “The Office of the Registrar” and that I may respond to the information.",
      "isChecked": false
    },
    {
      "title":
          "I understand that reasonable efforts will be made by the university to protect the confidentiality of this information. I further understand the results of the criminal’s background check may be reviewed by the Dean, Program Director, Department, Clinical Affiliates, Public Safety, and General Counsel if adverse information is contained in my reports.",
      "isChecked": false
    },
    {
      "title":
          "I understand that I will be notified by the University and will be asked to provide information and clarification in writing and any decisions made after would be final and not subject to appeal.",
      "isChecked": false
    },
    {
      "title":
          "I hereby give permission to the University to release the criminal background report to the agency and affiliates for the program to which I am assigned for educational or clinical experience prior to the beginning of the assignment and regardless of whether such campus/affiliate/agency has required the background check.",
      "isChecked": false
    },
    {
      "title":
          "I understand the affiliates may refuse me access to clients/patients based on information contained in the criminal background check and that the criteria may differ from that of the Program.",
      "isChecked": false
    },
    {
      "title":
          "I hereby release those individuals or affiliates/agencies from any liabilities or damage in providing such information. I agree that a photocopy of this authorization may be accepted with the authority as the original.",
      "isChecked": false
    },
  ];

  //add new recommendation
  void setCheckboxValue(bool value, int index) async {
    dataList[index]["isChecked"] = value;
    notifyListeners();
  }

  bool areAllCheckboxesSelected() {
    return dataList.every((item) => item["isChecked"] == true);
  }

  Future<http.Response> postAdmissionCriminalCheckDetails(int admissionId) async {
    setLoading(true);

    try {
      var result = await ApiHelper.post(
          "admissionCriminalCheck/id=$admissionId", {}, "");

      return result;
      //api call
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}
