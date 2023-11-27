import 'package:flutter/material.dart';

class CommonProvider extends ChangeNotifier{

         final TextEditingController doaTextController = TextEditingController();
  String get doaController => doaTextController.text;
   void selectdoa(String data) {
    doaTextController.text = data;
    notifyListeners();
  }
}