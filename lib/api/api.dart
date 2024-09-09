import 'dart:developer';

import 'package:btcpool_app/api/api_utils.dart';
import 'package:btcpool_app/controllers/update_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  static const String baseUrl = 'https://back.btcpool.kz';

  static Future<dynamic> get(String endpoint, {bool isJson = true}) async {
    final MyController _controller = Get.put(MyController());

    String mbVer = await AuthUtils.getIndexMobileVersion();
    final url = Uri.parse('$baseUrl/$endpoint');
    int retryCount = 0;
    log('Trtying get ' + url.toString());

    while (retryCount < 3) {
      final token = await AuthUtils.getToken('accessToken');
      final response = await http.get(url,
          headers: (isJson == true)
              ? {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $token',
                  'Mobapp-Version': mbVer
                }
              : {'Authorization': 'Bearer $token', 'Mobapp-Version': mbVer});

      await _handleResponse(response);
      if (response.statusCode == 200) {
        if (isJson == false) {
          return response.body;
        } else {
          return jsonDecode(response.body);
        }
      } else {
        if (jsonDecode(utf8.decode(response.bodyBytes))
            .containsKey('error_code')) {
          if (jsonDecode(utf8.decode(response.bodyBytes))['title'] == 17000) {
            _controller.changeAndShowDialog();

            return 17000;
          } else if (jsonDecode(utf8.decode(response.bodyBytes))['message'] ==
              'Email is not verified.') {
            log('mustmreuter');
            return 403;
          } else {
            return null;
          }
        } else {
          retryCount++;
          print(
              'Attempt $retryCount: Error ${response.statusCode} - ${response.reasonPhrase}');
          if (retryCount >= 3) {
            return null;
          }
        }
      }
    }
    return null;
  }

  static Future<dynamic> getUnAuth(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    String mbVer = await AuthUtils.getIndexMobileVersion();
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'Mobapp-Version': mbVer},
    );
    if (response.statusCode == 200) {
      Map<String, String> headers = response.headers;
      String? isUpdateRecommendedHeader = headers['is-update-recommended'];

      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      if (jsonDecode(utf8.decode(response.bodyBytes))
          .containsKey('error_code')) {
        if (jsonDecode(utf8.decode(response.bodyBytes))['error_code'] ==
            17000) {
          return 17000;
        }
      } else {
        return null;
      }
    }

    // return null;
  }

  static Future<dynamic> checkUpdate(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    String mbVer = await AuthUtils.getIndexMobileVersion();
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'Mobapp-Version': mbVer},
    );
    if (response.statusCode == 200) {
      Map<String, String> headers = response.headers;
      String? isUpdateRecommendedHeader = headers['is-update-recommended'];

      if (headers.containsKey('is-update-recommended')) {
        if (isUpdateRecommendedHeader!.toLowerCase() == 'true') {
          return 16000;
        } else {
          return 15000;
        }
      }
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      if (jsonDecode(utf8.decode(response.bodyBytes))
          .containsKey('error_code')) {
        if (jsonDecode(utf8.decode(response.bodyBytes))['error_code'] ==
            17000) {
          return 17000;
        }
      } else {
        return null;
      }
    }

    // return null;
  }

  Future<double> fetchBTCPrice() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final btcPrice = data['bitcoin']['usd'];
        return btcPrice.toDouble();
      } else {
        return 60000;
      }
    } catch (e) {
      return 60000;
    }
  }

  static Future<dynamic> post(String endpoint, Map<String, dynamic> data,
      {bool withBadRequest = false}) async {
    final MyController _controller = Get.put(MyController());
    String mbVer = await AuthUtils.getIndexMobileVersion();
    final token = await AuthUtils.getToken('accessToken');
    final url = Uri.parse('$baseUrl/$endpoint');
    int retryCount = 0;
    while (retryCount < 10) {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Mobapp-Version': mbVer,
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      await _handleResponse(response);
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          return true;
        } else {
          return jsonDecode(response.body);
        }
      } else {
        log(response.body.toString());
        if (response.body.toString() == '' || response.body.toString() == ' ') {
          return '';
        }

        if (jsonDecode(utf8.decode(response.bodyBytes))
            .containsKey('error_code')) {
          if (jsonDecode(utf8.decode(response.bodyBytes))['error_code'] ==
              17000) {
            _controller.changeAndShowDialog();

            return 17000;
          }
          if (jsonDecode(utf8.decode(response.bodyBytes))
                  .containsKey('title') ||
              jsonDecode(utf8.decode(response.bodyBytes))
                  .containsKey('detail')) {
            return jsonDecode(response.body);
          }
        } else {
          await _handleResponse(response);
          var data = jsonDecode(utf8.decode(response.bodyBytes));

          if (withBadRequest == false) {
            retryCount++;
            print(
                'Attempt $retryCount: Error ${response.statusCode} - ${response.reasonPhrase}');
            if (retryCount >= 10) {
              return null;
            }
            await Future.delayed(const Duration(seconds: 1));
          } else {
            print(response.body);
            var data = jsonDecode(response.body);

            if (data.containsKey('detail')) {
              await _handleResponse(response);

              await Future.delayed(const Duration(seconds: 1));
            } else {
              return data;
            }
          }
        }
      }
    }
    return null;
  }

  static Future<dynamic> del(String endpoint, Map<String, dynamic> data) async {
    final MyController _controller = Get.put(MyController());
    String mbVer = await AuthUtils.getIndexMobileVersion();
    final token = await AuthUtils.getToken('accessToken');
    final url = Uri.parse('$baseUrl/$endpoint');
    int retryCount = 0;
    while (retryCount < 3) {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Mobapp-Version': mbVer,
        },
        body: jsonEncode(data),
      );
      if (response.body.toString() == '') {
        return true;
      } else {
        if (jsonDecode(utf8.decode(response.bodyBytes))
            .containsKey('error_code')) {
          if (jsonDecode(utf8.decode(response.bodyBytes))['error_code'] ==
              17000) {
            _controller.changeAndShowDialog();

            return 17000;
          }
          if (jsonDecode(utf8.decode(response.bodyBytes))
              .containsKey('title')) {
            return jsonDecode(response.body);
          }
        } else {
          await _handleResponse(response);
          if (response.statusCode == 200 || response.statusCode == 204) {
            return true;
          } else {
            retryCount++;
            print(
                'Attempt $retryCount: Error ${response.statusCode} - ${response.reasonPhrase}');
            if (retryCount >= 3) {
              // print('Max retries reached. Failing with error.');
              return null;
            }
            await Future.delayed(const Duration(seconds: 2));
          }
        }
      }
    }
    return null;
  }

  static Future<dynamic> patch(
      String endpoint, Map<String, dynamic> data) async {
    final MyController _controller = Get.put(MyController());
    String mbVer = await AuthUtils.getIndexMobileVersion();
    final token = await AuthUtils.getToken('accessToken');
    final url = Uri.parse('$baseUrl/$endpoint');
    int retryCount = 0;
    while (retryCount < 3) {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Mobapp-Version': mbVer,
        },
        body: jsonEncode(data),
      );
      if (response.body.toString() == '' || response.body.toString() == ' ') {
        return '';
      }
      if (jsonDecode(utf8.decode(response.bodyBytes))
          .containsKey('error_code')) {
        if (jsonDecode(utf8.decode(response.bodyBytes))['error_code'] ==
            17000) {
          _controller.changeAndShowDialog();

          return 17000;
        }
        if (jsonDecode(utf8.decode(response.bodyBytes)).containsKey('title')) {
          return jsonDecode(response.body);
        }
      } else {
        await _handleResponse(response);
        if (response.statusCode == 200 || response.statusCode == 204) {
          return true;
        } else {
          retryCount++;
          print(
              'Attempt $retryCount: Error ${response.statusCode} - ${response.reasonPhrase}');
          if (retryCount >= 3) {
            // print('Max retries reached. Failing with error.');
            return null;
          }
          await Future.delayed(const Duration(seconds: 2));
        }
      }
    }
    return null;
  }

  static Future<void> _handleResponse(http.Response response) async {
    if (response.statusCode == 401) {
      await _refreshToken();
    }
  }

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
