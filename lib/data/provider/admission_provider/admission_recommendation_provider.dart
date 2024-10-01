import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/admission/admission_recommendation_model.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class AdmissionRecommendationProvider extends ChangeNotifier{
    // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isNewRec = false;
  bool get isNewRec => _isNewRec;
 List<RecommendationModel> recommendationList = [];


  // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

  //add new recommendation
  void setNewRec(bool value) async {
    _isNewRec = value;
    notifyListeners();
  }

  // store education details
  void storeEducationDetails(RecommendationModel value) {
    if (!recommendationList.contains(value)) {
      recommendationList.add(value);
      setNewRec(true);
      notifyListeners();
    } else {
      ToastHelper().errorToast("Already available");
    }
  }
}