import 'dart:convert';
import 'dart:io';

import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:http/http.dart' as http;
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class ApiHelper {

  static Future<http.Response> get(String endpoint, String token,{Map<String, String>? queryParams}) async {
     String flavorUrl = FlavorConfig.instance.variables["baseUrl"];
 String flavorName =FlavorConfig.instance.variables["flavorName"];
  try {
      Uri uri;

      if (flavorName == "dev") {
        // For dev: assume baseUrl includes protocol (e.g., http://localhost:3000)
        uri = Uri.parse('$flavorUrl/$endpoint');
        if (queryParams != null && queryParams.isNotEmpty) {
          uri = uri.replace(queryParameters: queryParams);
        }
      } else {
        // For prod: using Uri.https to build secure URL
        uri = Uri.https(flavorUrl, "/$endpoint", queryParams);
      }

      final response = await http.get(
        uri,
        headers: {"Authorization": "Bearer $token"},
      );

      return _handleResponse(response);
    } catch (e) {
      if (e is SocketException) {
        return ToastHelper().errorToast("Please Check Your Server Connectivity");
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

  static Future<http.Response> put(String endpoint, Map<String, dynamic> data, String token) async {
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

  static Future<dynamic> delete(String endpoint, String token) async {
         String flavorUrl = FlavorConfig.instance.variables["baseUrl"];
 String flavorName =FlavorConfig.instance.variables["flavorName"];
    final response = await http.delete(
         headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
         "Authorization": "Bearer $token"
      },
      flavorName=="dev" ?Uri.parse('$flavorUrl/$endpoint') : Uri.https(flavorUrl, "/$endpoint"),
      );
    return _handleResponse(response);
  }

  static http.Response _handleResponse(http.Response response) {
    return response;
  }
}
