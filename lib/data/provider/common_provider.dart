import 'package:flutter/material.dart';

class CommonProvider extends ChangeNotifier{

         final TextEditingController doaTextController = TextEditingController();
           bool _isChecked = false;
           bool get isChecked => _isChecked;

  String get doaController => doaTextController.text;
   void selectdoa(String data) {
    doaTextController.text = data;
    notifyListeners();
  }
  // Method to toggle the checkbox state
  void toggleCheckbox(bool newValue) {
    _isChecked = newValue;
    notifyListeners();
  }

}