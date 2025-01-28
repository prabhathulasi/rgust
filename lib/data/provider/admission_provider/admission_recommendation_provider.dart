import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/admission/admission_recommendation_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class AdmissionRecommendationProvider extends ChangeNotifier {
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isNewRec = false;
  bool get isNewRec => _isNewRec;
  List<RecommendationModel> recommendationList = [];

  String? recommendationName;
  String? recommendationEmail;
  String? recommendationPhone;
  String? recommendationDesignation;
  String? recommendationAddress;

  Future<http.Response> postAdmissionReferenceDetails(int applicationId) async {
    setLoading(true);

    var bodywithData = {
      "AdmissionID": applicationId,
      "ReferenceName": recommendationName,
      "ReferenceEmail": recommendationEmail,
      "ReferencePhone": recommendationPhone,
      "ReferenceProfession": recommendationDesignation,
      "ReferenceAddress": recommendationAddress
    };
    try {
      var result =
          await ApiHelper.post("admissionReferenceDetails", bodywithData, "");

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
