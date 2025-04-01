import 'dart:convert';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rugst_alliance_academia/data/model/invoice/invoice_model.dart';
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
  final TextEditingController conversionRateController =
      TextEditingController();
  final TextEditingController gydAmountController = TextEditingController();
  final TextEditingController invoiceDescriptionController =
      TextEditingController();
        final TextEditingController scholarshipController =
      TextEditingController();
            final TextEditingController customMsgController =
      TextEditingController();


      String ?customMessage ;

 // Define a list of items for the dropdown
  List<String> scholarShipItems = ['N/A', 'Partial', 'Full'];
  String? selectedScholarshipItem; // To store the selected item


  String? dropdownvalue;
  String? selectedFileName;
  FilePickerResult? finalResult;
  StudentInvoiceListModel studentInvoiceListModel = StudentInvoiceListModel();

  List<InvoiceModel> invoiceList = [];

  var dropDownItems = ["Bank Payment", "Wire Transfer"];
  List<String> importantNotes = [
   
  ];

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

  addInvoice(InvoiceModel invoice) {
    invoiceList.add(invoice);
    invoiceDescriptionController.clear();
    usdAmountController.clear();
    conversionRateController.clear();
    gydAmountController.clear();
    notifyListeners();
  }

  void updateConvertedAmount(String amount) {
    // Check if the USD amount and conversion rate are not empty
    final amountInUsd = int.tryParse(usdAmountController.text);
  

    // Calculate the converted amount
    gydAmountController.text = (amountInUsd! * int.parse(amount)).toString();
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

  clearInvoiceList(){
    scholarshipController.clear();
    invoiceList.clear();
    notifyListeners();
  }

}
