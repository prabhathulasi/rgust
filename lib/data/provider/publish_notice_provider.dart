import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class PublishNoticeProvider extends ChangeNotifier {
  final FocusNode textFieldFocusNode = FocusNode();
  final FocusNode quillFocusNode = FocusNode();



  bool _isLoading = false;
  bool get isLoading => _isLoading;
// Store attached files as a list of maps (name + bytes)
  final List<Map<String, dynamic>> attachedFiles = [];
  Future<void> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
      withData: true, // required on Web to get bytes
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;

      attachedFiles.add({
        'name': file.name,
        'bytes': file.bytes, // Uint8List
      });
      notifyListeners(); // Notify listeners about the change

      debugPrint(
          'PDF Attached: ${file.name} | Size: ${file.bytes?.length ?? 0} bytes');
    } else {
      debugPrint('User canceled picking a file.');
    }
  }

  void removeFile(int index) {
    attachedFiles.removeAt(index);
    notifyListeners(); // Notify listeners about the change
  }

  Future<void> sendEmailRequest(Set<int> studentId, String message) async {
    
    // Convert raw Uint8List to base64 inside the loop
    final List<Map<String, dynamic>> encodedFiles = attachedFiles.map((file) {
      final Uint8List rawBytes = file['bytes'] as Uint8List;
      return {
        'filename': file['name'],
        'file_data': base64Encode(rawBytes),
      };
    }).toList();

    final payload = {
      "text": message,
      "student_ids": studentId.toList(),
      "files": encodedFiles,
    };

     await ApiHelper.post("publish-notice", payload, "");

 ToastHelper().sucessToast("Emails are being sent to the Selected Students. Please wait...");

   
  }



  // set loading value
  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}
