import 'package:flutter/material.dart';

class CommonProvider extends ChangeNotifier{

         final TextEditingController doaTextController = TextEditingController();
           bool _isChecked = false;
           bool get isChecked => _isChecked;
 String _selectedOption = '';
 String get selectedOption => _selectedOption;
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
   void updateSelectedOption(String value) {
    _selectedOption = value;
    notifyListeners();
    // Perform any other actions based on the selected option here
    print('Selected option: $_selectedOption');
  }

}