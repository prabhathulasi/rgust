import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/admission/admission_education_history_model.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class AdmissionEducationProvider extends ChangeNotifier {
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isNewEdu = false;
  bool get isNewEdu => _isNewEdu;
  bool _isEduCompleted = true;
  bool get isEduCompleted => _isEduCompleted;
  List<EducationModel> educationList = [];

// set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

  //add new education
  void setNewEdu(bool value) async {
    _isNewEdu = value;
    notifyListeners();
  }

// store education details
  void storeEducationDetails(EducationModel value) {
    if (!educationList.contains(value)) {
      educationList.add(value);
      setNewEdu(true);
      notifyListeners();
    } else {
      ToastHelper().errorToast("Already available");
    }
  }

//education section isComplete
  void setEduSectionValue(bool value) async {
    _isEduCompleted = value;

    notifyListeners();
  }
}
