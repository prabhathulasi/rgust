import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/data/model/media_file_model.dart';
import 'package:rugst_alliance_academia/util/api_service.dart';
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class FileUploadProvider extends ChangeNotifier{
    bool _isLoading = false;
  bool get isLoading => _isLoading;
  int _hoveredIndex = -1;

  int get hoveredIndex => _hoveredIndex;

    Uint8List? _bytesFromPicker;
    String? _selectedFileName;
      Uint8List? get bytesFromPicker => _bytesFromPicker;
  String? get selectedFileName => _selectedFileName;


MediaFileModel mediaFileModel =MediaFileModel();
  Future getMediaFileById(String token, int id) async {
    setLoading(true);
    try {
      var result = await ApiHelper.get("upload/id=$id", token);
      setLoading(false);
        
      if (result.statusCode == 200) {
     
 var data = json.decode(result.body);
        mediaFileModel = MediaFileModel.fromJson(data);

        notifyListeners();

        return mediaFileModel;
      } else if (result.statusCode == 204) {
       
        notifyListeners();
        ToastHelper().errorToast("No Documents Uploaded Yet");
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
uploadMediaFile(){

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
    void setHoveredIndex(int index) {
    _hoveredIndex = index;
    notifyListeners();
  }

  void clearHoveredIndex() {
    _hoveredIndex = -1;
    notifyListeners();
  }
}