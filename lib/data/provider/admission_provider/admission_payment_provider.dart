import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rugst_alliance_academia/util/api_service.dart';

class AdmissionPaymentProvider extends ChangeNotifier {
  //dropdown
  String? paymentMethodRadioValue;

  String? date;
  String? name;

  String? selectedFileName;
  String? selectedFileBytes;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<http.Response> postAdmissionPaymentDetails(
      int applicationId, String sign) async {
    setLoading(true);

    var bodywithData = {
      "admissionID": applicationId,
      "Name": name,
      "Date": date,
      "Document": selectedFileBytes,
      "PaymentType": paymentMethodRadioValue,
      "Sign": sign
    };
    try {
      var result =
          await ApiHelper.post("admissionPaymentDetails", bodywithData, "");

      return result;
      //api call
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setPaymentRadioValue(String value) async {
    paymentMethodRadioValue = value;
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
