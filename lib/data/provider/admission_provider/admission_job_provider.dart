import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/admission/admission_job_form.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class AdmissionJobProvider extends ChangeNotifier {
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isNewJob = false;
  bool get isNewJob => _isNewJob;
  bool _isjobCompleted = true;
  bool get isjobCompleted => _isjobCompleted;
//radio button
  String? jobTypeRadioValue;
  List<ExperienceModel> jobList = [];
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

  // job section isCompleted
  void setjobSectionValue(bool value) async {
    _isjobCompleted = value;

    notifyListeners();
  }

  // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}
