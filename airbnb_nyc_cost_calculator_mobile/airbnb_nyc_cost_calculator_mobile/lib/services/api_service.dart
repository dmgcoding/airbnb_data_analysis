import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3001';

  static Future<Response?> getRequest(String path, {String? token}) async {
    final url = Uri.parse('$baseUrl/$path');
    try {
      Map<String, String> headers = {};
      if (token != null) {
        headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };
      } else {
        headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        };
      }
      final response = await get(url, headers: headers);
      return response;
    } catch (e) {
      throw HttpException('Failed to fetch data: $e');
    }
  }

  static Future<Response?> postRequest(String path,
      {Map<String, dynamic>? bodyJson, String? token}) async {
    final url = Uri.parse('$baseUrl/$path');

    try {
      Map<String, String> headers = {};
      if (token != null) {
        headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };
      } else {
        headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        };
      }

      final body = jsonEncode(bodyJson);

      final response = await post(url, body: body, headers: headers);
      return response;
    } catch (e) {
      throw HttpException('Failed to fetch data: $e');
    }
  }
}
