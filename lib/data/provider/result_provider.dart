import 'dart:convert';
import 'dart:developer';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rugst_alliance_academia/custom_plugin/timeline/timeline_item.dart';
import 'package:rugst_alliance_academia/data/model/publish_result_model.dart';
import 'package:rugst_alliance_academia/data/model/result_approval_model.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class ResultProvider extends ChangeNotifier {
  // loading indicator
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  PublishResultModel resultPublishModel = PublishResultModel();
  ApprovalModel approvalModel = ApprovalModel();
  List<TimelineItem> timeline = [];
  updateExamresult(String token, int id, dynamic data) async {
    setLoading(true);
    try {
      Map<String, dynamic> body = {
        "Cw1": data["CW1"],
        "Cw2": data["CW2"],
        "CW3": data["CW3"],
        "CW4": data["CW4"],
        "FinalMark": data["FinalExam"],
        "Grade": data["Grade"]
      };
      print(body);
      var result = await ApiHelper.put("UpdateResult/id=$id", body, token);

      setLoading(false);
      if (result.statusCode == 200) {
        notifyListeners();
        ToastHelper().sucessToast("Result Updated Sucessfully");
        return 200;
      } else if (result.statusCode == 204) {
        notifyListeners();
        ToastHelper().errorToast("No Courses Registered Yet");

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
      return null;
    }
  }

  createResult(String token, int studentId) async {
    setLoading(true);
    try {
      var body = {"StudentId": studentId};
      var result = await ApiHelper.post("CreateResult", body, token);

      setLoading(false);
      if (result.statusCode == 200) {
        notifyListeners();
        ToastHelper().sucessToast("Result Courses Added Sucessfully");
        return 200;
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
      return null;
    }
  }

  getAllResult(String token,
      {String? programId, String? classId, String? batch}) async {
    setLoading(true);
    resultPublishModel.results?.clear();
    Map<String, dynamic> body = {
      "ProgramId": int.parse(programId!),
      "ClassId": int.parse(classId!),
      "Batch": batch
    };
    try {
      var result = await ApiHelper.post("GetOverAllResult", body, token);

      setLoading(false);
      var data = json.decode(result.body);
      
      if (result.statusCode == 200) {
        resultPublishModel = PublishResultModel.fromJson(data);

        notifyListeners();

        return 200;
      } else if (result.statusCode == 401) {
        resultPublishModel.results?.clear();
        notifyListeners();

        return "Invalid Token";
      } else if (result.statusCode == 204) {
        ToastHelper().errorToast("No Record Found");
        return null;
      } else {
        resultPublishModel.results?.clear();
        notifyListeners();
        ToastHelper().errorToast(data["Message"]);
        return null;
      }
    } catch (e) {
      resultPublishModel.results?.clear();
      setLoading(false);
      ToastHelper().errorToast(e.toString());
      return null;
    }
  }

  getApprovalData(String token,
      {String? programId, String? classId, String? batch}) async {
        approvalModel.approvalData?.clear();
    setLoading(true);
    resultPublishModel.results?.clear();
    Map<String, dynamic> body = {
      "ProgramId": int.parse(programId!),
      "ClassId": int.parse(classId!),
      "Batch": batch
    };
    try {
      var result = await ApiHelper.post("GetApprovals", body, token);

      setLoading(false);
      if(result.body.isNotEmpty){
     var data = json.decode(result.body);

      if (result.statusCode == 200) {
        approvalModel = ApprovalModel.fromJson(data);
        timeline = approvalModel.approvalData!.map((e) {
          return TimelineItem(
              title: e.status!,
              subtitle: e.userType!,
              description: e.status == "Uploaded" ?
                   DateFormat('E,d MMM yyyy HH:mm')
                      .format(DateTime.parse(e.createdAt!)):e.status =="Approved"? DateFormat('E,d MMM yyyy HH:mm')
                      .format(DateTime.parse(e.updatedAt!)):"",
              child: Icon(
                Icons.person,
                color: AppColors.colorWhite,
                size: 50.sp,
              ),
              bubbleColor: e.status == "Pending"
                  ? AppColors.colorGrey
                  : AppColors.colorc7e);
        }).toList();

        notifyListeners();

        return approvalModel;
      } else if (result.statusCode == 401) {
        approvalModel.approvalData?.clear();
        notifyListeners();

        return "Invalid Token";
      } else if (result.statusCode == 204) {
        approvalModel.approvalData?.clear();
        notifyListeners();
        ToastHelper().errorToast("No Records Found");
        return null;
      } else {
        approvalModel.approvalData?.clear();
        notifyListeners();
        ToastHelper().errorToast(data["Message"]);
        return null;
      }
      }
     
    } catch (e) {
      approvalModel.approvalData?.clear();
      setLoading(false);
      ToastHelper().errorToast("Internal Server Error");
      return null;
    }
  }

  createApproval(String token,
      {String? programId, String? classId, String? batch}) async {
    Map<String, dynamic> body = {
      "ProgramId": int.parse(programId!),
      "ClassId": int.parse(classId!),
      "Batch": batch
    };
    setLoading(true);
    try {
      var result = await ApiHelper.post("CreateApproval", body, token);

      setLoading(false);
      var data = json.decode(result.body);
      if (result.statusCode == 200) {
        await getApprovalData(token,
            programId: programId, classId: classId, batch: batch);
        notifyListeners();

        return 200;
      } else if (result.statusCode == 401) {
        notifyListeners();

        return "Invalid Token";
      } else {
        notifyListeners();
        ToastHelper().errorToast(data["Message"]);
        return null;
      }
    } catch (e) {
      setLoading(false);
      ToastHelper().errorToast(e.toString());
      return null;
    }
  }


approveResult(String token,{required String resultId, required int userLevel, required String batch, required String programId, required String classId}) async{
    Map<String, dynamic> body = {
   "ResultId":  resultId,
		"UserLevel": userLevel,
		"Status":    "Approved",
    };
    setLoading(true);
    try {
      var result = await ApiHelper.post("ApproveResult", body, token);

      setLoading(false);
      var data = json.decode(result.body);
      if (result.statusCode == 200) {
      await getApprovalData(token,batch:batch, classId: classId,programId: programId);
  ToastHelper().sucessToast("Approved");
        notifyListeners();

        return 200;
      } else if (result.statusCode == 401) {
        notifyListeners();

        return "Invalid Token";
      } else {
        notifyListeners();
        ToastHelper().errorToast(data["Message"]);
        return null;
      }
    } catch (e) {
      setLoading(false);
      ToastHelper().errorToast(e.toString());
      return null;
    }
}
  // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}
