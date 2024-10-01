import 'package:flutter/material.dart';

class AdmissionAgentProvider  extends ChangeNotifier{
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;

 bool _isAgentCompleted = true;
  bool get isAgentCompleted => _isAgentCompleted;
//dropdown
  String? agentRadioValue;

   void setAgentRadioValue(String value) async {
    agentRadioValue = value;
    notifyListeners();
  }



    // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }


//agent section isCompleted
  void setAgentSectionValue(bool value) async {
    _isAgentCompleted = value;

    notifyListeners();
  }
}