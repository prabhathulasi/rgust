import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:http/http.dart' as http;
import 'package:rugst_alliance_academia/data/model/student/student_invoice_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoiceProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? dropdownvalue;
  String? selectedFileName;
  FilePickerResult? finalResult;
  StudentInvoiceListModel studentInvoiceListModel = StudentInvoiceListModel();

  var dropDownItems = ["Bank Payment", "Wire Transfer"];
  List<String> pdfRules = [
    "1. File size should not be more than 50KB.",
    "2. File type should be PDF only.",
    "3. The filename should not contain special characters, spaces, or symbols",
    "4. Ensure the document is legible and not corrupted",
    "5. Do not upload copyrighted or confidential materials",
    "6. File names should be unique and descriptive",
    "7. Do not upload offensive or inappropriate content.",
    "8. Files should not contain viruses or malware.",
    "9. File Name Must be in the Following Format(Receipt_your receipt last 4 numbers)"
  ];

  void uploadStudentInvoice(
    BuildContext context, {
    String? token,
    int? studentId,
    String? fromAccountNumber,
    String? bankName,
    int? amountInGyd,
    int? amountInUsd,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userName = sharedPreferences.getString("username");
    String flavorUrl = FlavorConfig.instance.variables["baseUrl"];
    String flavorName = FlavorConfig.instance.variables["flavorName"];
    setLoading(true);
    try {
      // Define headers (if needed)
      final headers = <String, String>{
        'Authorization': 'Bearer $token', // Add any headers you need
      };

      final request = http.MultipartRequest(
          'POST',
          flavorName == "dev"
              ? Uri.parse("$flavorUrl/uploadInvoice")
              : Uri.https(flavorUrl, '/uploadInvoice'))
        ..fields["StudentId"] = studentId!.toString()
        ..fields["FormType"] = "F"
        ..fields["FeesId"] = '1'
        ..fields["PaymentType"] = dropdownvalue!
        ..fields["FromAccountNumber"] = fromAccountNumber!
        ..fields["BankName"] = bankName!
        ..fields["AmountInGyd"] = amountInGyd!.toString()
        ..fields["AmountInUsd"] = amountInUsd.toString()
        ..fields["Status"] = "Approved"
        ..fields["UpdatedBy"] = userName!
        ..headers.addAll(headers)
        ..files.add(
          http.MultipartFile.fromBytes(
            'InvoiceData',
            finalResult!.files.first.bytes!,
            filename: selectedFileName,
          ),
        );

      final response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var decodedData = json.decode(responseBody);
      if (response.statusCode == 200 && context.mounted) {
        Navigator.pop(context);
        // await getMediaList();

        ToastHelper().sucessToast("${decodedData["Message"]} ");
      } else {
        ToastHelper().errorToast("${decodedData["Message"]} ");
        // Handle errors
        print('Error uploading file: ${decodedData["Message"]}');
      }
    } catch (e) {
          ToastHelper().errorToast(e.toString());
    } finally {
      setLoading(false);
      setFileValue("");
    }
  }

  Future getStudentInvoiceList(String token, int id) async {

    try {
      var result = await ApiHelper.get("GetInvoiceByStudentId/id=$id", token);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        studentInvoiceListModel = StudentInvoiceListModel.fromJson(data);

        return studentInvoiceListModel;
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
    } 
  }

  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

  void setDropDownValue(String value) async {
    dropdownvalue = value;
    notifyListeners();
  }

  void setMediaFileValue(FilePickerResult value) async {
    finalResult = value;
    notifyListeners();
  }

  void setFileValue(String value) async {
    selectedFileName = value;
    notifyListeners();
  }
}
