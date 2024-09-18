import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/media_file_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class FileUploadProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Uint8List? _bytesFromPicker;
  String? _selectedFileName;
  Uint8List? get bytesFromPicker => _bytesFromPicker;
  String? get selectedFileName => _selectedFileName;

  MediaFileModel mediaFileModel = MediaFileModel();
  Future getMediaFileById(String token, int id) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("upload/id=$id", token);

      if (result.statusCode == 200) {
        var data = json.decode(result.body);
        mediaFileModel = MediaFileModel.fromJson(data);

        return mediaFileModel;
      } else if (result.statusCode == 204) {
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
      notifyListeners();
      setLoading(false);
    }
  }



  Future delteMediabyId(String token, int mediaFileId, int userId) async {
    setLoading(true);
    try {
      var result = await ApiHelper.delete("DeleteMedia/id=$mediaFileId", token);
      setLoading(false);

      if (result.statusCode == 200) {
        await getMediaFileById(token, userId);

        notifyListeners();
      } else if (result.statusCode == 404) {
        notifyListeners();
        ToastHelper().errorToast("No Documents Found");
      } else if (result.statusCode == 401) {
        notifyListeners();

        return "Invalid Token";
      } else {
        notifyListeners();
        ToastHelper().errorToast("Internal Server Error");
      }
    } catch (e) {
      setLoading(false);
      ToastHelper().errorToast(e.toString());
      return e.toString();
    }
  }

  void setFileData(FilePickerResult result) {
    _bytesFromPicker = result.files.first.bytes;
    _selectedFileName = result.files.first.name;
    notifyListeners();
  }

  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

  void setSelectedFileName() async {
    _selectedFileName = null;
    notifyListeners();
  }
}
