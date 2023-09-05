import 'package:flutter/material.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/authentication/authentication_screen.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/login_screen.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/request_information/feedback_screen.dart';
import 'package:rugst_alliance_academia/mobile_view/screens/request_information/request_data_screen.dart';

class AppRouter {
  static MaterialPageRoute _generateMaterialRoute({required Widget page}) =>
      MaterialPageRoute(
        builder: (_) => page,
      );

  static MaterialPageRoute mobileLogin() {
    return _generateMaterialRoute(
      page: const MobileLoginScreen(),
    );
  }

  static MaterialPageRoute mobileAuth() {
    return _generateMaterialRoute(
      page: const AuthenticationScreen(),
    );
  }

  static MaterialPageRoute mobileRequestData() {
    return _generateMaterialRoute(
      page: const MobileRequestDataScreen(),
    );
  }

  static MaterialPageRoute mobileFeedbackData() {
    return _generateMaterialRoute(
      page: const MobileFeedbackScreen(),
    );
  }
}
