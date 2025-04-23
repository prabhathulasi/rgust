import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/payment/payment_receipt_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class PaymentProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  var dropDownItems = ["Bank Payment", "Wire Transfer"];

  String? paymentTypeValue;
  int? amountInUsd;
  int? amountInGyd;
  PaymentReceiptModel paymentReceiptModel = PaymentReceiptModel();

  Future postPaymenData(int studentId, String token, int invoiceId, bool isMisc) async {
    setLoading(true);
    var body = {
      "studentId": studentId,
      "receiptNumber": "123456",
      "amountInGyd": amountInGyd,
      "amountInUsd": amountInUsd,
      "paymentType": paymentTypeValue,
      "invoiceId": invoiceId,
      "ismisc":isMisc
    };

    print(body.toString());
    try {
      var result =
          await ApiHelper.post("post-payment-receipt-data", body, token);

      if (result.statusCode == 201) {
        var data = json.decode(result.body);
getPaymentReceipts(token, invoiceId, isMisc);
        ToastHelper().sucessToast("Invoice Added Successfully");
        // getFeeInvoice(token, studentId);
        return data;
      } else if (result.statusCode == 400) {
        var data = json.decode(result.body);
        ToastHelper().errorToast(data.toString());
        return null;
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

  Future getPaymentReceipts(String token, int invoiceId, bool isMisc) async {
    setLoading(true);
    paymentReceiptModel.paymentdata?.clear();
    try {
      var result =
          await ApiHelper.get("get-payment-receipts/id=$invoiceId?isMisc=$isMisc", token);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        paymentReceiptModel = PaymentReceiptModel.fromJson(data);

        return paymentReceiptModel;
      } else if (result.statusCode == 400) {
        ToastHelper().errorToast("No Invoice Details Found");
        return null;
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

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setDropDownValue(String value) async {
    paymentTypeValue = value;
    notifyListeners();
  }

  void setAmountInUsd(int value) {
    amountInUsd = value;
  }

  void setAmountInGyd(int value) {
    amountInGyd = value;
  }
}
