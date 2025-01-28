import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/admission/admission_education_history_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:http/http.dart' as http;

class AdmissionEducationProvider extends ChangeNotifier {
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isNewEdu = false;
  bool get isNewEdu => _isNewEdu;

  List<EducationModel> educationList = [];
String? selectedFileName;
String? selectedFileBytes;
String? courseName;
String? institutionName;
String? _startDate ;
String get startDate => _startDate!;   
String? _endDate;
String get endDate => _endDate!;

    TextEditingController commencedInput = TextEditingController();
    TextEditingController completedInput = TextEditingController();




  Future<http.Response> postAdmissionEducationDetails(int admissionId) async {
    setLoading(true);
    
    var bodywithData = {
  "admissionID": admissionId,
  "EducationDetail":educationList.map((e) => e.toJson()).toList()
    };
    try {
      var result = await ApiHelper.post("admissionEducationDetails",
        bodywithData , "");

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

void removeEducationDetails(int index){
  educationList.removeAt(index);
  notifyListeners();
}

void setStartDate(String startDate){
  _startDate = startDate;
  commencedInput.text = startDate;
  notifyListeners();
}

void setEndDate(String endDate){
  _endDate = endDate;
  completedInput.text = endDate;
  notifyListeners();

}

void clearStartendDate(){
  _startDate = null;
  _endDate = null;
  commencedInput.clear();
  completedInput.clear();
    selectedFileName = null;
    selectedFileBytes = null;
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

}