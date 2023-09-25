import 'dart:convert';


import 'package:http/http.dart' as http;

class ApiHelper {
  static const String baseUrl = "http://localhost:3013"; // Replace with your API base URL

  static Future<http.Response> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  static Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
  
      
      },
      body: jsonEncode(data),
    );
   
    return _handleResponse(response);
  }

  static Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
