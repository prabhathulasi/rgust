import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:http/http.dart' as http;

class AdmissionAgentProvider extends ChangeNotifier {
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;

//dropdown
  String? agentRadioValue;

  String? agentName;
  String? agentEmail;
  String? agentContact;
  String? agentAddress;
  String? counselorName;

  Future<http.Response> postAdmissionAgentDetails(int admissionId) async {
    setLoading(true);
    var bodywithoutdata = {
      "AdmissionID": admissionId,
    };
    var bodywithData = {
      "AgentName": agentName,
      "AgentEmail": agentEmail,
      "AgentContact": agentContact,
      "AgentAddress": agentAddress,
      "CounselorName": counselorName,
      "AdmissionID": admissionId,
    };
    try {
      var result = await ApiHelper.post("admissionAgentDetails",
          agentRadioValue == "Yes" ? bodywithData : bodywithoutdata, "");

      return result;
      //api call
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  void setAgentRadioValue(String value) async {
    agentRadioValue = value;
    notifyListeners();
  }

  // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}
