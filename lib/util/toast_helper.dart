import 'package:fluttertoast/fluttertoast.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';

class ToastHelper {
  sucessToast(String msg) {
    return Fluttertoast.showToast(
        msg: msg, gravity: ToastGravity.TOP_RIGHT, timeInSecForIosWeb: 5);
  }

  errorToast(String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.TOP_RIGHT,
      timeInSecForIosWeb: 5,
      webBgColor: AppColors.colorRed,
    );
  }
}
