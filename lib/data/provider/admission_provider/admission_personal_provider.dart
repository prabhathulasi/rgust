import 'package:http/http.dart' as http;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/enum/enum.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';

import 'package:rugst_alliance_academia/util/toast_helper.dart';

class AdmissionPersonalProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  GenderEnum _selectedGender = GenderEnum.others;
  GenderEnum get selectedGender => _selectedGender;
  TextEditingController? dobinput = TextEditingController();

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

  String? firstName;
  String? lastName;
  String? email;
  String? contactNumber;
  String? passportNum;
  String? homeAddress;
  String? mailingAddress;

  String? selectedFileName;
  String? selectedMediaFile;

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

  Future<http.Response> postAdmissionPersonalDetails(
       applicationId) async {
    setLoading(true);
    try {
      var result = await ApiHelper.put(
          "admissionPersonalDetails",
          {
          
            'ApplicationID': applicationId,
            'Title': titleDropdownvalue,
            'FirstName': firstName,
            'LastName': lastName,
            'MartialStatus': maritalDropdownvalue,
            'EmailAddress': email,
            'ContactNumber': contactNumber,
            'Dob': dobinput!.text,
            'Gender': selectedGender.toString(),
            'BirthCountry': selectedCountry,
            'Ethinicity': ethinicityDropdownvalue,
            'Citizenship': selectCitizenCountry,
            'PassportNumber': passportNum,
            'HomeAddress': homeAddress,
            'MailingAddress': mailingAddress,
            'ResidingCountry': homeAddress,
            'StudentVisa': visaRadioValue == "Yes" ? true : false,
            'Disabilty': disablityRadioValue,
            'Photo': selectedMediaFile,
            'OtherLanguages': moreLang
          },
          "");

      return result;
      //api call
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  void setFirstName(String value) {
    firstName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    lastName = value;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setContactNumber(String value) {
    contactNumber = value;
    notifyListeners();
  }

  void setPassportNum(String value) {
    passportNum = value;
    notifyListeners();
  }

  void setHomeAddress(String value) {
    homeAddress = value;
    notifyListeners();
  }

  void setMailingAddress(String value) {
    mailingAddress = value;
    notifyListeners();
  }

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

//selectedFIle
  void setMediaFileValue(String value) async {
    selectedMediaFile = value;
    notifyListeners();
  }

  // clearFIle
  void setClearFileValue() async {
    selectedMediaFile = null;
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

  void clearMoreLangValue() async {
    moreLang.clear();
    notifyListeners();
  }

  // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}
