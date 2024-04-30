import 'package:btcpool_app/api/api_utils.dart'; // Assuming necessary utilities are defined here
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  static const String baseUrl = 'https://back.btcpool.kz';

  static Future<dynamic> get(String endpoint, {bool isJson = true}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    int retryCount = 0;
    while (retryCount < 6) {
      final token = await AuthUtils.getToken('accessToken');
      print("Trying to get " + url.toString());
      final response = await http.get(url,
          headers: (isJson == true)
              ? {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $token',
                }
              : {
                  'Authorization': 'Bearer $token',
                });
      if (response.statusCode == 200) {
        if (isJson == false) {
          return response.body;
        } else {
          return jsonDecode(response.body);
        }
      } else {
        await _handleResponse(response);

        retryCount++;
        print(
            'Attempt $retryCount: Error ${response.statusCode} - ${response.reasonPhrase}');
        if (retryCount >= 10) {
          print('Max retries reached. Failing with error.');
          return null; // Maximum retries reached, return null or handle as appropriate
        }
        // Wait before retrying
      }
    }
    return null;
  }

  static Future<dynamic> getUnAuth(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    }

    return null;
  }

  static Future<dynamic> post(String endpoint, Map<String, dynamic> data,
      {bool withBadRequest = false}) async {
    final token = await AuthUtils.getToken('accessToken');
    final url = Uri.parse('$baseUrl/$endpoint');
    int retryCount = 0;
    while (retryCount < 10) {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      await _handleResponse(response);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        if (withBadRequest == false) {
          retryCount++;
          print(
              'Attempt $retryCount: Error ${response.statusCode} - ${response.reasonPhrase}');
          if (retryCount >= 10) {
            print('Max retries reached. Failing with error.');
            return null;
          }
          await Future.delayed(Duration(seconds: 1));
        } else {
          return jsonDecode(response.body);
        }
      }
    }
    return null;
  }

  static Future<dynamic> del(String endpoint, Map<String, dynamic> data) async {
    final token = await AuthUtils.getToken('accessToken');
    final url = Uri.parse('$baseUrl/$endpoint');
    int retryCount = 0;
    while (retryCount < 10) {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      await _handleResponse(response);
      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        retryCount++;
        print(
            'Attempt $retryCount: Error ${response.statusCode} - ${response.reasonPhrase}');
        if (retryCount >= 10) {
          print('Max retries reached. Failing with error.');
          return null;
        }
        await Future.delayed(Duration(seconds: 2));
      }
    }
    return null;
  }

  // Handle responses
  static Future<void> _handleResponse(http.Response response) async {
    if (response.statusCode == 401) {
      await _refreshToken();
    }
  }

  // Refresh Token Logic
  static Future<void> _refreshToken() async {
    final refreshToken = await AuthUtils.getToken('refreshToken');
    final url = Uri.parse('$baseUrl/api/v1/users/token/refresh/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await AuthUtils.saveToken('accessToken', data['access']);
      await AuthUtils.saveToken('refreshToken', data['refresh']);
    } else {
      print('Failed to refresh token');
    }
  }
}
