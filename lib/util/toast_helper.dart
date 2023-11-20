import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  sucessToast(String msg) {
    return Fluttertoast.showToast(
        webPosition: 'right',
        webBgColor: "linear-gradient(to right, #008000, #008000)",
        msg: msg,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2);
  }

  errorToast(String msg) {
    return Fluttertoast.showToast(
      webShowClose: true,
      msg: msg,
      webPosition: 'right',
      gravity: ToastGravity.TOP_RIGHT,
      timeInSecForIosWeb: 2,
      webBgColor: "linear-gradient(to right, #ff0000, #ff0000)",
    );
  }
}
