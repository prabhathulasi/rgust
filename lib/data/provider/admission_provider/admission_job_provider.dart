import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/admission/admission_job_form_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:http/http.dart' as http;

class AdmissionJobProvider extends ChangeNotifier {
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isNewJob = false;
  bool get isNewJob => _isNewJob;

  String? selectedFileName;
  String? selectedFileBytes;
  //dropdown
  String? jobRadioValue;

//radio button
  String? jobTypeRadioValue;
  List<ExperienceModel> jobList = [];

  String? employerName;
  String? role;
  String? _startDate;
  String get startDate => _startDate!;
  String? _endDate;
  String get endDate => _endDate!;

  TextEditingController commencedInput = TextEditingController();
  TextEditingController completedInput = TextEditingController();

  Future<http.Response> postAdmissionJobDetails(int applicationId) async {
    setLoading(true);
    var bodywithoutData = {
      "WorkExp": jobRadioValue == "Yes" ? true : false,
      "admissionID": applicationId,
    };
    var bodywithData = {
      "WorkExp": jobRadioValue == "Yes" ? true : false,
      "admissionID": applicationId,
      "JobDetails": jobList.map((e) => e.toJson()).toList()
    };
    try {
      var result = await ApiHelper.post("admissionJobDetails",
          jobRadioValue == "Yes" ? bodywithData : bodywithoutData, "");

      return result;
      //api call
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      setLoading(false);
    }
  }

// store jobs details
  void storeJobDetails(ExperienceModel value) {
    if (!jobList.contains(value)) {
      jobList.add(value);
      setNewJob(true);
      notifyListeners();
    } else {
      ToastHelper().errorToast("Already available");
    }
  }

  void setJobRadioValue(String value) async {
    jobRadioValue = value;
    jobList.clear();
    notifyListeners();
  }

// add new job
  void setNewJob(bool value) async {
    _isNewJob = value;
    notifyListeners();
  }

// job type
  void setJobTypeRadioValue(String value) async {
    jobTypeRadioValue = value;

    notifyListeners();
  }

  // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

  void addFile(String name, String bytes) {
    selectedFileName = name;
    selectedFileBytes = bytes;
    notifyListeners();
  }

  void clearFile() {
    selectedFileName = null;
    selectedFileBytes = null;
    notifyListeners();
  }

  void setStartDate(String startDate) {
    _startDate = startDate;
    commencedInput.text = startDate;
    notifyListeners();
  }

  void setEndDate(String endDate) {
    _endDate = endDate;
    completedInput.text = endDate;
    notifyListeners();
  }

  void clearStartendDate() {
    _startDate = null;
    _endDate = null;
    commencedInput.clear();
    completedInput.clear();
    selectedFileName = null;
    selectedFileBytes = null;
    jobTypeRadioValue = null;
    notifyListeners();
  }
}
