import 'dart:convert';
import 'dart:io';

import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:http/http.dart' as http;
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class ApiHelper {

  static Future<http.Response> get(String endpoint, String token) async {
     String flavorUrl = FlavorConfig.instance.variables["baseUrl"];
 String flavorName =FlavorConfig.instance.variables["flavorName"];
    try {
      final response = await http.get(
        flavorName=="dev" ?Uri.parse('$flavorUrl/$endpoint') : Uri.https(flavorUrl, "/$endpoint"),
          headers: {"Authorization": "Bearer $token"});
      return _handleResponse(response);
    } catch (e) {
      if (e is SocketException) {
        //treat SocketException

        return ToastHelper()
            .errorToast("Please Check Your Server Connectivity");
      } else {
        return ToastHelper().errorToast("Internal Server Error");
      }
    }
  }

  static Future<http.Response> post(
      String endpoint, Map<String, dynamic> data, String token) async {
            String flavorUrl = FlavorConfig.instance.variables["baseUrl"];
 String flavorName =FlavorConfig.instance.variables["flavorName"];
    final response = await http.post(
     flavorName=="dev" ?Uri.parse('$flavorUrl/$endpoint') : Uri.https(flavorUrl, "/$endpoint"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(data),
    );

    return _handleResponse(response);
  }

  static Future<dynamic> put(String endpoint, Map<String, dynamic> data, String token) async {
         String flavorUrl = FlavorConfig.instance.variables["baseUrl"];
 String flavorName =FlavorConfig.instance.variables["flavorName"];
    final response = await http.put(
     flavorName=="dev" ?Uri.parse('$flavorUrl/$endpoint') : Uri.https(flavorUrl, "/$endpoint"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
         "Authorization": "Bearer $token"
      },
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> delete(String endpoint) async {
         String flavorUrl = FlavorConfig.instance.variables["baseUrl"];
 String flavorName =FlavorConfig.instance.variables["flavorName"];
    final response = await http.delete(
      flavorName=="dev" ?Uri.parse('$flavorUrl/$endpoint') : Uri.https(flavorUrl, "/$endpoint"),
      );
    return _handleResponse(response);
  }

  static http.Response _handleResponse(http.Response response) {
    return response;
  }
}
