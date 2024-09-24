import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/admission/admission_education_history_model.dart';
import 'package:rugst_alliance_academia/data/model/admission/admission_job_form.dart';

import 'package:rugst_alliance_academia/util/toast_helper.dart';

class AdmissionProvider extends ChangeNotifier {
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isPersonalCompleted = true;
  bool get isPersonalCompleted => _isPersonalCompleted;
  bool _isAgentCompleted = true;
  bool get isAgentCompleted => _isAgentCompleted;
  bool _isEduCompleted = true;
  bool get isEduCompleted => _isEduCompleted;
  bool _isjobCompleted = true;
  bool get isjobCompleted => _isjobCompleted;
  bool _isEngProfiencyCompleted = false;
  bool get isEngProfiencyCompleted => _isEngProfiencyCompleted;


    bool _isNewEdu = false;
  bool get isNewEdu => _isNewEdu;

    bool _isNewJob = false;
  bool get isNewJob => _isNewJob;
   List<EducationModel> educationList = [];
   List<ExperienceModel> jobList = [];
  var titleItems = [
    'Mr.',
    'Mrs.',
    'Dr.',
  ];
  var maritalItems = ['Married', 'Widow', 'Seperated', 'Divorced', 'Single'];
   var engYearsItems = ['Elementary', 'Intermediate', 'Advanced'];
    var engLevelItems = ['Less than 1 year', '1–3 years', '3–6 years', '6+ years'];
  var ethinicityItems = [
    'Hispanic or Latino or Spanish Origin of any race',
    'American Indian or Alaskan Native',
    'Asian or Pacific Islander',
    'Black or African American',
    'White',
    'Race and Ethnicity unknown'
  ];
  List<String> moreLang = [];
  String? titleDropdownvalue;
  String? maritalDropdownvalue;
  String? ethinicityDropdownvalue;
  String? engYearDropdownValue;
  String? engLevelDropdownValue;

  String? selectedCountry;
  String? selectCitizenCountry;
  String? radioValue;
  String? visaRadioValue;
  String? langRadioValue;
  String? disablityRadioValue;

  String? agentRadioValue;
  String? jobTypeRadioValue;
    String? engProficiencyRadioValue;




    void storeEducationDetails(EducationModel value) {
    if (!educationList.contains(value)) {
      educationList.add(value);
       setNewEdu(true);
      notifyListeners();
    } else {
      ToastHelper().errorToast("Already available");
    }
  }

    void storeJobDetails(ExperienceModel value) {
    if (!jobList.contains(value)) {
      jobList.add(value);
      setNewJob(true);
      notifyListeners();
    } else {
      ToastHelper().errorToast("Already available");
    }
  }
void setNewEdu(bool value) async {
    _isNewEdu = value;
    notifyListeners();
  }
    void setNewJob(bool value) async {
    _isNewJob = value;
    notifyListeners();
  }
  // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

  void setPersonalSectionValue(bool value) async {
    _isPersonalCompleted = value;
    notifyListeners();
  }

  void setAgentSectionValue(bool value) async {
    _isAgentCompleted = value;

    notifyListeners();
  }

  void setEduSectionValue(bool value) async {
    _isEduCompleted = value;

    notifyListeners();
  }
    void setjobSectionValue(bool value) async {
    _isjobCompleted = value;

    notifyListeners();
  }
  void setEngProficiencySectionValue(bool value) async {
    _isEngProfiencyCompleted  = value;

    notifyListeners();
  }
  void setTitleDropDownValue(String value) async {
    titleDropdownvalue = value;

    notifyListeners();
  }

  void setMaritalDropDownValue(String value) async {
    maritalDropdownvalue = value;
    notifyListeners();
  }
 void setEngYearDropDownValue(String value) async {
    engYearDropdownValue = value;
    notifyListeners();
  }


   void setEngLevalDropDownValue(String value) async {
    engLevelDropdownValue = value;
    notifyListeners();
  }
  void setEthinicityDropDownValue(String value) async {
    ethinicityDropdownvalue = value;
    notifyListeners();
  }

  void setCountryValue(String value) async {
    selectedCountry = value;
    notifyListeners();
  }

  void setCitizenCountryValue(String value) async {
    selectCitizenCountry = value;
    notifyListeners();
  }

  void setRadioValue(String value) async {
    radioValue = value;
    notifyListeners();
  }


  void setEngProficiencyValue(String value) async {
    engProficiencyRadioValue = value;
    
    notifyListeners();
  }



  void setVisaRadioValue(String value) async {
    visaRadioValue = value;
    notifyListeners();
  }

  void setLangRadioValue(String value) async {
    langRadioValue = value;
    notifyListeners();
  }

  void setdisabilityRadioValue(String value) async {
    disablityRadioValue = value;
    notifyListeners();
  }

  void setAgentRadioValue(String value) async {
    agentRadioValue = value;
    notifyListeners();
  }
 void setJobTypeRadioValue(String value) async {
    jobTypeRadioValue = value;
    notifyListeners();
  }

  void setMoreLangValue(String value) async {
    if (!moreLang.contains(value)) {
      moreLang.add(value);
    } else {
      ToastHelper().errorToast("Item already Exists");
    }
    notifyListeners();
  }

  void removeMoreLangValue(String value) async {
    if (moreLang.contains(value)) {
      moreLang.remove(value);
    } else {
      ToastHelper().errorToast("Item Not Exists");
    }
    notifyListeners();
  }

  void clearMoreLangValue(String value) async {
    moreLang.clear();
    notifyListeners();
  }
}
