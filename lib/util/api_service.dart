import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rugst_alliance_academia/util/toast_helper.dart';

class ApiHelper {
  static const String baseUrl =
      "http://172.16.20.151:3014"; // Replace with your API base URL

  static Future<http.Response> get(String endpoint, String token) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpoint'),
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
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(data),
    );

    return _handleResponse(response);
  }

  static Future<dynamic> put(String endpoint, Map<String, dynamic> data, String token) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
         "Authorization": "Bearer $token"
      },
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  static http.Response _handleResponse(http.Response response) {
    return response;
  }
}
