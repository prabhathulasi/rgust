import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/enum/enum.dart';

import 'package:rugst_alliance_academia/util/toast_helper.dart';

class AdmissionPersonalProvider  extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;



    GenderEnum _selectedGender = GenderEnum.others;
  GenderEnum get selectedGender => _selectedGender;
  //dropdown 
  String? titleDropdownvalue;
  String? maritalDropdownvalue;
  String? selectedCountry;
  String? ethinicityDropdownvalue;
  String? selectCitizenCountry;

  //radio buttons
   String? radioValue;
  String? visaRadioValue;
  String? langRadioValue;
  String? disablityRadioValue;

  //textfieldValues
  String ?firstName;
  String? lastName;
  String? email;
  String? contactNumber;
  String? passportNum;
  String? homeAddress;
  String? mailingAddress;
  

var maritalItems = ['Married', 'Widow', 'Seperated', 'Divorced', 'Single'];
var titleItems = [
    'Mr.',
    'Mrs.',
    'Dr.',
  ];
var ethinicityItems = [
    'Hispanic or Latino or Spanish Origin of any race',
    'American Indian or Alaskan Native',
    'Asian or Pacific Islander',
    'Black or African American',
    'White',
    'Race and Ethnicity unknown'
  ];
    List<String> moreLang = [];


    
// title
void setTitleDropDownValue(String value) async {
    titleDropdownvalue = value;
  notifyListeners();
  }
//marital status
 void setMaritalDropDownValue(String value) async {
    maritalDropdownvalue = value;
    notifyListeners();
  }
  //gender
   void setGender(GenderEnum value) async {
    _selectedGender = value;
    notifyListeners();
  }
//home country
  void setCountryValue(String value) async {
    selectedCountry = value;
    notifyListeners();
  }
//citizenship coutnry
  void setCitizenCountryValue(String value) async {
    selectCitizenCountry = value;
    notifyListeners();
  }
  //ethinicity
  void setEthinicityDropDownValue(String value) async {
    ethinicityDropdownvalue = value;
    notifyListeners();
  }
  //reside country
   void setRadioValue(String value) async {
    radioValue = value;
    notifyListeners();
  }
//student visa
  void setVisaRadioValue(String value) async {
    visaRadioValue = value;
    notifyListeners();
  }
//other lang
  void setLangRadioValue(String value) async {
    langRadioValue = value;
    notifyListeners();
  }
//disability
  void setdisabilityRadioValue(String value) async {
    disablityRadioValue = value;
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

   // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

}