import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  sucessToast(String msg) {
    return Fluttertoast.showToast(
        webPosition: 'right',
        webBgColor: "linear-gradient(to right, #008000, #008000)",
        msg: msg,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5);
  }

  errorToast(String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      webPosition: 'right',
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      webBgColor: "linear-gradient(to right, #ff0000, #ff0000)",
    );
  }
}
