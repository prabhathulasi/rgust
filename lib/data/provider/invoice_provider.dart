import 'dart:convert';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rugst_alliance_academia/data/model/invoice/invoice_model.dart';
import 'package:rugst_alliance_academia/data/model/invoice/invoice_response_model.dart';
import 'package:rugst_alliance_academia/data/model/student/student_invoice_model.dart';
import 'package:rugst_alliance_academia/data/provider/student_provider.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoiceProvider extends ChangeNotifier {
  final StudentProvider studentProvider;

  InvoiceProvider(this.studentProvider);
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final TextEditingController usdAmountController = TextEditingController();
  final TextEditingController regularTuitionFeeController =
      TextEditingController();
  final TextEditingController conversionRateController =
      TextEditingController();
  final TextEditingController gydAmountController = TextEditingController();
  final TextEditingController invoiceDescriptionController =
      TextEditingController();
  final TextEditingController scholarshipController = TextEditingController();
  final TextEditingController customMsgController = TextEditingController();

  String? customMessage;
  List<String> miscList = [
    "Student Government Fee",
    "One-Time Registration Fee",
    "Application Fee",
    "Matriculation Fee",
    "Seat Deposit Fee",
    "Health Insurance (optional)",
    "Visa Application Fee",
    "Examination Fee",
    "Supplimental Exam Fee",
  ];

  

  String? selectedMiscItem; // To store the selected item

  // Define a list of items for the dropdown
  List<String> scholarShipItems = ['N/A', 'Partial', 'Full'];
  String? selectedScholarshipItem; // To store the selected item

  String? dropdownvalue;
  String? selectedFileName;
  FilePickerResult? finalResult;
  StudentInvoiceListModel studentInvoiceListModel = StudentInvoiceListModel();
  InvoiceResponseModel invoiceResponseModel = InvoiceResponseModel();

  List<InvoiceModel> invoiceList = [];
  List<MiscInvoiceModel> miscInvoiceList = [];
  String? invoiceType;
  String feeType = "tution";
  String? semesterValue;

  var dropDownItems = ["Bank Payment", "Wire Transfer"];
  List<String> importantNotes = [];
  int ?selectedInvoiceIndex ;
  int? selectedInvoiceId;
  int ?selectedMiscIndex;
  int? selectedMiscInvoiceId;

  void uploadStudentInvoice(BuildContext context,
      {String? token,
      int? studentId,
      int? amountInGyd,
      int? amountInUsd,
      String? studentRegNo,
      int? semfeeId}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userName = sharedPreferences.getString("username");
    String flavorUrl = FlavorConfig.instance.variables["baseUrl"];
    String flavorName = FlavorConfig.instance.variables["flavorName"];
    Random random = Random();
    int randomNumber =
        random.nextInt(9000) + 1000; // Generates a number between 1000 and 9999
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
        ..fields["AmountInGyd"] = amountInGyd!.toString()
        ..fields["AmountInUsd"] = amountInUsd.toString()
        ..fields["Status"] = "Approved"
        ..fields["UpdatedBy"] = userName!
        ..fields["ClassId"] = semfeeId!.toString()
        ..fields["ReceiptNumber"] =
            "RGUST/${DateFormat("yyyy/MMM-dd").format(DateTime.now())}/$randomNumber"
        ..headers.addAll(headers);
      // ..files.add(
      // http.MultipartFile.fromBytes(
      //   'InvoiceData',
      //   finalResult!.files.first.bytes!,
      //   filename: "$studentRegNo-${DateFormat("yyyy-MM-HH:mm").format(DateTime.now())}-$randomNumber.pdf",
      // ),
      // );

      final response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var decodedData = json.decode(responseBody);
      if (response.statusCode == 200 && context.mounted) {
        Navigator.pop(context);

        await getStudentInvoiceList(token!, studentId);
        await studentProvider.getStudentDetailById(studentId, token);

        ToastHelper().sucessToast("${decodedData["Message"]} ");
      } else {
        ToastHelper().errorToast("${decodedData["Message"]} ");
        // Handle errors
        print('Error uploading file: ${decodedData["Message"]}');
      }
    } catch (e) {
      ToastHelper().errorToast("data" + e.toString());
    } finally {
      studentProvider.notifyListeners();
      notifyListeners();
      setLoading(false);
    }
  }




  Future postFeeInvoice(int studentId, String token, int year) async {
    setLoading(true);
    var body = {
      "studentId": studentId,
      "scholorshipType": invoiceList[0].scholarshipType,
      "invoiceType": invoiceType,
      "year": year,
      "regularTutionFee": invoiceList[0].regularTuitionFee,
      "scholarshipAmount": invoiceList[0].scholarshipAmount,
      "invoiceDescription": invoiceList[0].description,
      "amountInUsd": invoiceList[0].usd,
      "currentConversionRate": int.parse(conversionRateController.text),
      "customMessage": customMsgController.text,
      "invoiceNumber":
          "RGUST/${DateFormat("yyyy/MMM-dd").format(DateTime.now())}/${generateRandomString(5)}",
    };

    print(body.toString());
    try {
      var result = await ApiHelper.post("post-invoice-data", body, token);

      if (result.statusCode == 201) {
        var data = json.decode(result.body);

        ToastHelper().sucessToast("Invoice Added Successfully");
        getFeeInvoice(token, studentId);
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



  Future getFeeInvoice(String token, int studentId) async {
    invoiceResponseModel.invoiceData?.clear();
    try {
      var result = await ApiHelper.get("get-invoice-data/id=$studentId", token);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        invoiceResponseModel = InvoiceResponseModel.fromJson(data);

        return invoiceResponseModel;
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
      notifyListeners();
    }
    
  }


Future deleteTutionInvoice(int invoiceId, String token, int studentId ) async{
  setLoading(true);
  try {
    var result = await ApiHelper.delete("delete-invoice-data/id=$invoiceId", token);

    if (result.statusCode == 200) {
      var data = json.decode(result.body);
      getFeeInvoice(token, studentId);
      
      ToastHelper().sucessToast("Invoice Deleted Successfully");
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

Future deleteMiscInvoice(int invoiceId, String token, int studentId ) async{
  setLoading(true);
  try {
    var result = await ApiHelper.delete("delete-misc-invoice-data/id=$invoiceId", token);

    if (result.statusCode == 200) {
      var data = json.decode(result.body);
      getFeeInvoice(token, studentId);
      
      ToastHelper().sucessToast("Invoice Deleted Successfully");
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

  Future postMiscInvoice(int studentId, String token, int year) async {
    setLoading(true);
    var body = {
      
      "studentId": studentId,
      "year": year,
      "invoiceDescription": miscInvoiceList[0].description,
      "amountInUsd": miscInvoiceList[0].usd,
      "currentConversionRate": int.parse(conversionRateController.text),
      "customMessage": customMsgController.text,
      "invoiceNumber":
          "RGUST/${DateFormat("yyyy/MMM-dd").format(DateTime.now())}/${generateRandomString(5)}",
    };

    print(body.toString());
    try {
      var result = await ApiHelper.post("post-misc-invoice-data", body, token);

      if (result.statusCode == 201) {
        var data = json.decode(result.body);

        ToastHelper().sucessToast("Invoice Added Successfully");
        getFeeInvoice(token, studentId);
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



  Future getStudentInvoiceList(String token, int id) async {
    studentInvoiceListModel.invoiceList?.clear();
    try {
      var result = await ApiHelper.get("GetInvoiceByStudentId/id=$id", token);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);

        studentInvoiceListModel = StudentInvoiceListModel.fromJson(data);

        return studentInvoiceListModel;
      } else if (result.statusCode == 404) {
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

  Future updateStudentInvoiceStatus(
      String token, int invoiceId, int studentId, String status) async {
    var data = {"Status": status};
    setLoading(true);
    try {
      var result = await ApiHelper.put(
          "UpdateStudentInvoiceById/id=$invoiceId", data, token);

      if (result.statusCode == 200) {
        await getStudentInvoiceList(token, studentId);
        return 200;
      } else if (result.statusCode == 204) {
        ToastHelper().errorToast("No Invoice Details Found");
        return 204;
      } else if (result.statusCode == 401) {
        return "Invalid Token";
      } else {
        ToastHelper().errorToast("Internal Server Error");
        return 500;
      }
    } catch (e) {
      return e.toString();
    } finally {
      notifyListeners();
      setLoading(false);
    }
  }

  String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxy0123456789';
    Random random = Random.secure();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  addInvoice(InvoiceModel invoice) {
    invoiceList.add(invoice);

    notifyListeners();
  }

  addMiscInvoice(MiscInvoiceModel invoice) {
    if (!miscInvoiceList
        .any((item) => item.description == invoice.description)) {
      miscInvoiceList.add(invoice);
    } else {
      ToastHelper().errorToast("Misc Fee Already Added");
    }
  
    notifyListeners();
  }

  void updateConvertedAmount(String amount) {
    // Check if the USD amount and conversion rate are not empty
    final amountInUsd = int.tryParse(usdAmountController.text);

    // Calculate the converted amount
    gydAmountController.text = (amountInUsd! * int.parse(amount)).toString();
    }


void setInvoiceIndex(int value, int invoiceId){
  selectedInvoiceIndex = value;
  selectedInvoiceId = invoiceId;
  selectedMiscIndex = null;
  notifyListeners();

}

void setMiscIndex(int value, int miscId){
  selectedMiscIndex = value;
  selectedMiscInvoiceId = miscId;
  selectedInvoiceIndex = null;
  notifyListeners();
}
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

  void setDropDownValue(String value) async {
    dropdownvalue = value;
    notifyListeners();
  
  }

  void setScholarshipValue(String value) async {
    selectedScholarshipItem = value;
  notifyListeners();
  }

  void setCustomMessageValue(String value) async {
    customMessage = value;
    notifyListeners();
  }

  void setInvoiceType(String value) {
    invoiceType = value;
    notifyListeners();
  }

  void setFeeType(String value) {
    feeType = value;
    notifyListeners();
  }

  void setSemValue(String value) {
    semesterValue = value;
    notifyListeners();
  }

  void setSelectedMiscItem(String value) {
    selectedMiscItem = value;
    notifyListeners();
  }

  clearInvoiceList() {
    scholarshipController.clear();
    invoiceList.clear();
    notifyListeners();
  }


}
