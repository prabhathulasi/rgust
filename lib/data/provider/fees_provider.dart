

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/fee_model.dart';

import 'package:rugst_alliance_academia/data/model/miscfee_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class FeesProvider extends ChangeNotifier{
    bool _isLoading = false;
  bool get isLoading => _isLoading;

FeesModel feesModel = FeesModel();
FeesModel singlefeesModel = FeesModel();

MiscFeeModel miscFeeModel = MiscFeeModel();

  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }



  //  getFees list
  Future getFeesList(String token) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("GetFeesDetails", token);
      setLoading(false);
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        feesModel = FeesModel.fromJson(data);

        notifyListeners();

        return feesModel;
      } else if (result.statusCode == 204) {
        notifyListeners();
        ToastHelper().errorToast("No Fees Details Found");
        return null;
      } else if (result.statusCode == 401) {
        notifyListeners();

        return "Invalid Token";
      } else {
        notifyListeners();
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      setLoading(false);
      ToastHelper().errorToast(e.toString());
      return e.toString();
    }
  }
  //  getFeesbyid 
  Future getFeesByid(String token, int programId) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("GetFeesById/id=$programId", token);
      setLoading(false);
      if (result.statusCode == 200) {
        singlefeesModel.feeslist?.clear();
        var data = json.decode(result.body);
        print(data);

        singlefeesModel = FeesModel.fromJson(data);


        notifyListeners();

        return singlefeesModel;
      } else if (result.statusCode == 204) {
        notifyListeners();
        ToastHelper().errorToast("No Fees Details Found");
        return null;
      } else if (result.statusCode == 401) {
        notifyListeners();

        return "Invalid Token";
      } else {
        notifyListeners();
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      setLoading(false);
      ToastHelper().errorToast(e.toString());
      return e.toString();
    }
  }
   //  getMiscFees list
  Future getMiscFeesDetails(String token, int programId, int feesId) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("GetMiscFees/fees_id=$feesId/program_id=$programId", token);
 
      if (result.statusCode == 200) {
        miscFeeModel.miscFee?.clear();
        var data = json.decode(result.body);
        print(data);

        miscFeeModel = MiscFeeModel.fromJson(data);
     setLoading(false);
        notifyListeners();

        return miscFeeModel;
      } else if (result.statusCode == 204) {
          setLoading(false);
        notifyListeners();
        ToastHelper().errorToast("No Fees Details Found");
        return null;
      } else if (result.statusCode == 401) {
          setLoading(false);
        notifyListeners();

        return "Invalid Token";
      } else {
          setLoading(false);
        notifyListeners();
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      setLoading(false);
      ToastHelper().errorToast(e.toString());
      return e.toString();
    }
  }
}