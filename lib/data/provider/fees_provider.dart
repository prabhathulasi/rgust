import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/fees/fee_model.dart';
import 'package:rugst_alliance_academia/data/model/fees/fees_detail_model.dart';

import 'package:rugst_alliance_academia/data/model/fees/miscfee_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class FeesProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  FeesModel feesModel = FeesModel();
  FeesDetailModel feesDetailModel = FeesDetailModel();

  MiscFeeModel miscFeeModel = MiscFeeModel();

  String? feesTypeRadioValue;

  void setfeesTypeRadioValue(String value, int programId, String token) async {
    feesTypeRadioValue = value;
    if (value == "Standard Fees") {
      await getFeesByid(token, programId);
    }
    notifyListeners();
  }

  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

  double _gydConversion = 0;
  double get gydConversion => _gydConversion;

void setGydConversionValue(int value) async {
    _gydConversion = value * 218;
    notifyListeners();
  }
  //  getFees list
  Future getFeesList(String token) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("GetFeesDetails", token);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        feesModel = FeesModel.fromJson(data);

        return feesModel;
      } else if (result.statusCode == 204) {
        ToastHelper().errorToast("No Fees Details Found");
        return null;
      } else if (result.statusCode == 401) {
        return "Invalid Token";
      } else {
        ToastHelper().errorToast("Internal Server Error");
        return null;
      }
    } catch (e) {
      ToastHelper().errorToast(e.toString());
      return e.toString();
    } finally {
      setLoading(false);
    }
  }

  //  getFeesbyid
  Future getFeesByid(String token, int programId) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("GetFeesById/id=$programId", token);
      setLoading(false);
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        feesDetailModel = FeesDetailModel.fromJson(data);

        notifyListeners();

        return feesDetailModel;
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
      var result = await ApiHelper.get(
          "GetMiscFees/fees_id=$feesId/program_id=$programId", token);

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
