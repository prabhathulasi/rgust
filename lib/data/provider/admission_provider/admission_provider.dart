import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/admission/admission_detail_model.dart';
import 'package:rugst_alliance_academia/data/model/admission/admission_list_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class AdmissionProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  AdmissionDetailModel admissionDetailModel = AdmissionDetailModel();
  AdmissionListModel admissionListModel = AdmissionListModel();

  Future getAdmissionList(String token) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("admissionList", token);
      setLoading(false);
      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        admissionListModel = AdmissionListModel.fromJson(data);

        return admissionListModel;
      } else if (result.statusCode == 401) {
        return "Invalid Token";
      } else {
        ToastHelper().errorToast("Something went wrong please try again later");
        return null;
      }
    } catch (e) {
      ToastHelper().errorToast(e.toString());
      return e.toString();
    } finally {
      notifyListeners();
      setLoading(false);
    }
  }

  Future getApplicantDetailById(int applicationId, String token) async {
    try {
      var result =
          await ApiHelper.get("admissionDetails/id=$applicationId", token);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        admissionDetailModel = AdmissionDetailModel.fromJson(data);

        return admissionDetailModel;
      } else if (result.statusCode == 204) {
        ToastHelper().errorToast("No Courses Registered Yet");

        return null;
      } else if (result.statusCode == 401) {
        return "Invalid Token";
      } else {
        ToastHelper().errorToast("Unable to fetch admission details");
        return null;
      }
    } on Exception catch (e) {
      ToastHelper().errorToast(e.toString());
      return e.toString();
    }
  }

  Future updateApplicationApprovalStatus(
      int applicationId, String token, String status) async {
    setLoading(true);
    try {
      var body = {
        "AdmissionID": applicationId,
        "Status": status,
      };
      var result = await ApiHelper.put("updateAdmissionStatus", body, token);

      if (result.statusCode == 200) {
        ToastHelper().sucessToast("Application Status Updated Successfully");
      } else if (result.statusCode == 401) {
        return "Invalid Token";
      } else {
        ToastHelper().errorToast("Unable to update Application Status details");
        return null;
      }
    } on Exception catch (e) {
      ToastHelper().errorToast(e.toString());
      return e.toString();
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  void mailto(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject="Admission Followup"&body=Hello',
    );

    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      throw 'Could not launch $params';
    }
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
