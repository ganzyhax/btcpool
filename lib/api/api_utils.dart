import 'dart:developer';

import 'package:btcpool_app/controllers/update_controller.dart';
import 'package:btcpool_app/local_data/cache_data/cache_hive.dart';
import 'package:btcpool_app/local_data/const.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthUtils {
  static const FlutterSecureStorage storage = FlutterSecureStorage();
  static Future<void> logout() async {
    await AuthUtils.setIndexSubAccount(0);
    await AuthUtils.clearStorage();
    await LocalCache().clearHive();
  }

  static Future<int> getIndexSubAccount() async {
    String? data = await storage.read(key: 'subAccountIndex');
    if (data != null) {
      return int.parse(data);
    } else {
      return 0;
    }
  }

  static Future<void> setIndexSubAccount(int index) async {
    await storage.write(key: 'subAccountIndex', value: index.toString());
  }

  static Future<void> saveToken(String key, String value) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(value);

    await storage.write(
        key: 'userId', value: decodedToken['user_id'].toString());
    await storage.write(
        key: 'userName', value: decodedToken['user']['username']);
    await storage.write(
        key: 'userEmail', value: decodedToken['user']['email'].toString());
    await storage.write(key: key, value: value);
  }

  static Future<void> setLanguage(String lang) async {
    await storage.write(key: 'localLang', value: lang.toString());
  }

  static Future<String> getLanguage() async {
    String userId = await storage.read(key: 'localLang') ?? 'null';
    return userId;
  }

  static Future<void> setIsSecure(bool isSecure) async {
    await storage.write(key: 'isSecure', value: isSecure.toString());
  }

  static Future<bool> getIsSecure() async {
    String value = await storage.read(key: 'isSecure') ?? 'false';
    if (value == 'true') {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getUserId() async {
    String userId = await storage.read(key: 'userId') ?? 'null';
    return userId;
  }

  static Future<String> getUserName() async {
    String userName = await storage.read(key: 'userName') ?? 'null';
    return userName;
  }

  static Future<String> getUserEmail() async {
    String userName = await storage.read(key: 'userEmail') ?? 'null';
    return userName;
  }

  static Future<void> saveMobileVer() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String buildNumber = packageInfo.buildNumber;
    await storage.write(key: 'buildVer', value: buildNumber);
  }

  static Future<String> getIndexMobileVersion() async {
    String? data = await storage.read(key: 'buildVer');
    if (data != null) {
      return data;
    } else {
      return '0';
    }
  }

  static Future<void> setRecUpdateSkip() async {
    await storage.write(key: 'isSkip', value: 'true');
  }

  static Future<bool> getRecUpdateSkip() async {
    String? data = await storage.read(key: 'isSkip');
    if (data != null) {
      if (data == 'true') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<void> setThemeMode(value) async {
    await storage.write(key: 'themeIsDark', value: value);
  }

  static Future<bool> getThemeMode() async {
    String? data = await storage.read(key: 'themeIsDark');
    if (data != null) {
      if (data == 'true') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> isAccess() async {
    String? res = await storage.read(key: 'accessToken');
    if (res == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> clearStorage() async {
    await storage.write(key: 'refreshToken', value: null);
    await storage.write(key: 'accessToken', value: null);
  }

  static Future<String?> getToken(String key) async {
    return await storage.read(key: key);
  }

  static Future<dynamic> login(
      String username, String password, String otp) async {
    final MyController controller = Get.put(MyController());

    String mbVer = await AuthUtils.getIndexMobileVersion();

    final url = Uri.parse(AppData.baseUrl + '/api/v1/users/token/');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Mobapp-Version': mbVer,
        },
        body: (otp.isEmpty)
            ? jsonEncode({'username': username, 'password': password})
            : jsonEncode(
                {'username': username, 'password': password, 'otp_code': otp}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('oauth_token')) {
          return data;
        } else {
          log(data['access'].toString());
          await saveToken('accessToken', data['access']);
          await saveToken('refreshToken', data['refresh']);
        }

        return true;
      } else {
        if (jsonDecode(utf8.decode(response.bodyBytes))
            .containsKey('error_code')) {
          if (jsonDecode(utf8.decode(response.bodyBytes))['error_code'] ==
              17000) {
            controller.changeAndShowDialog();

            return jsonDecode(response.body);
          } else {
            return jsonDecode(response.body);
          }
        } else {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> loginWithOtp(String token, String otp) async {
    final MyController controller = Get.put(MyController());

    final url =
        Uri.parse(AppData.baseUrl + '/api/v2/users/token_with_otp_code/');
    String mbVer = await AuthUtils.getIndexMobileVersion();

    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Mobapp-Version': mbVer,
          },
          body: jsonEncode({'oauth_token': token, 'otp_code': otp}));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        await saveToken('accessToken', data['access']);
        await saveToken('refreshToken', data['refresh']);
        return true;
      } else {
        if (jsonDecode(utf8.decode(response.bodyBytes))
            .containsKey('error_code')) {
          if (jsonDecode(utf8.decode(response.bodyBytes))['error_code'] ==
              17000) {
            controller.changeAndShowDialog();
            return jsonDecode(response.body);
          } else {
            return jsonDecode(response.body);
          }
        } else {
          return jsonDecode(response.body);
        }
      }
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> register(
    String email,
    String fio,
    String phone,
    String password,
    String organizationBin,
  ) async {
    final MyController controller = Get.put(MyController());
    String mbVer = await AuthUtils.getIndexMobileVersion();

    final url = Uri.parse('https://back.btcpool.kz/api/v1/users/register/');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Mobapp-Version': mbVer,
        },
        body: jsonEncode({
          "username": fio,
          "organization_bin": organizationBin,
          "email": email,
          "password": password,
          "password2": password,
          "phone": phone,
        }),
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        // await saveToken('accessToken', data['access']);
        // await saveToken('refreshToken', data['refresh']);
        return jsonDecode(response.body);
      } else {
        if (jsonDecode(utf8.decode(response.bodyBytes))
            .containsKey('error_code')) {
          if (jsonDecode(utf8.decode(response.bodyBytes))['error_code'] ==
              17000) {
            controller.changeAndShowDialog();

            return jsonDecode(response.body);
          } else {
            return jsonDecode(response.body);
          }
        } else {
          return jsonDecode(response.body);
        }
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool> auth(
    String email,
  ) async {
    final MyController controller = Get.put(MyController());

    String mbVer = await AuthUtils.getIndexMobileVersion();

    final url = Uri.parse(
        'https://back.btcpool.kz/api/v1/users/verification_code/send/');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Mobapp-Version': mbVer,
        },
        body: jsonEncode({
          "email": email,
        }),
      );

      if (response.statusCode == 200) {
        // await saveToken('accessToken', data['access']);
        // await saveToken('refreshToken', data['refresh']);
        return true;
      } else {
        if (jsonDecode(utf8.decode(response.bodyBytes))
            .containsKey('error_code')) {
          if (jsonDecode(utf8.decode(response.bodyBytes))['error_code'] ==
              17000) {
            controller.changeAndShowDialog();

            return false;
          } else {
            return false;
          }
        } else {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> verify(
    String email,
    String code,
  ) async {
    final MyController controller = Get.put(MyController());

    String mbVer = await AuthUtils.getIndexMobileVersion();
    final url = Uri.parse(
        'https://back.btcpool.kz/api/v1/users/verification_code/verify/');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Mobapp-Version': mbVer,
        },
        body: jsonEncode({
          "email": email,
          "code": code,
        }),
      );

      if (response.statusCode == 200) {
        print(response.body);
        print(response);

        // await saveToken('accessToken', data['access']);
        // await saveToken('refreshToken', data['refresh']);
        // await saveToken('accessToken', data['access']);
        // await saveToken('refreshToken', data['refresh']);
        return true;
      } else {
        if (jsonDecode(utf8.decode(response.bodyBytes))
            .containsKey('error_code')) {
          if (jsonDecode(utf8.decode(response.bodyBytes))['error_code'] ==
              17000) {
            controller.changeAndShowDialog();
            return jsonDecode(response.body);
          } else {
            return jsonDecode(response.body);
          }
        } else {
          return jsonDecode(response.body);
        }
      }
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> reset(
    String email,
  ) async {
    final MyController controller = Get.put(MyController());

    String mbVer = await AuthUtils.getIndexMobileVersion();
    final url =
        Uri.parse('https://back.btcpool.kz/api/v1/users/reset_password/send/');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Mobapp-Version': mbVer,
        },
        body: jsonEncode({
          "email": email,
        }),
      );

      if (response.statusCode == 200) {
        print(response);
        // await saveToken('accessToken', data['access']);
        // await saveToken('refreshToken', data['refresh']);
        return true;
      } else {
        if (jsonDecode(utf8.decode(response.bodyBytes))
            .containsKey('error_code')) {
          if (jsonDecode(utf8.decode(response.bodyBytes))['error_code'] ==
              17000) {
            controller.changeAndShowDialog();
            return jsonDecode(response.body);
          } else {
            return jsonDecode(response.body);
          }
        } else {
          return jsonDecode(response.body);
        }
      }
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> resetConfirmCode(String email, String code) async {
    final url = Uri.parse(
        'https://back.btcpool.kz/api/v1/users/reset_password/verify/');
    final MyController controller = Get.put(MyController());

    String mbVer = await AuthUtils.getIndexMobileVersion();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Mobapp-Version': mbVer,
        },
        body: jsonEncode({"email": email, 'code': code}),
      );

      if (response.statusCode == 200) {
        // await saveToken('accessToken', data['access']);
        // await saveToken('refreshToken', data['refresh']);
        return jsonDecode(response.body);
      } else {
        if (jsonDecode(utf8.decode(response.bodyBytes))
            .containsKey('error_code')) {
          if (jsonDecode(utf8.decode(response.bodyBytes))['error_code'] ==
              17000) {
            controller.changeAndShowDialog();
            return jsonDecode(response.body);
          } else {
            return jsonDecode(response.body);
          }
        } else {
          return jsonDecode(response.body);
        }
      }
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> resetSetPassword(
      String email, String password, String resetToken) async {
    final url =
        Uri.parse('https://back.btcpool.kz/api/v1/users/reset_password/');
    final MyController controller = Get.put(MyController());

    String mbVer = await AuthUtils.getIndexMobileVersion();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Mobapp-Version': mbVer,
        },
        body: jsonEncode({
          "email": email,
          'password': password,
          'password2': password,
          'reset_token': resetToken
        }),
      );

      if (response.statusCode == 200) {
        // await saveToken('accessToken', data['access']);
        // await saveToken('refreshToken', data['refresh']);
        return true;
      } else {
        if (jsonDecode(utf8.decode(response.bodyBytes))
            .containsKey('error_code')) {
          if (jsonDecode(utf8.decode(response.bodyBytes))['error_code'] ==
              17000) {
            controller.changeAndShowDialog();
            return jsonDecode(response.body);
          } else {
            return jsonDecode(response.body);
          }
        } else {
          return jsonDecode(response.body);
        }
      }
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> delete(
    String endpoint,
  ) async {
    final MyController controller = Get.put(MyController());
    String mbVer = await AuthUtils.getIndexMobileVersion();
    final token = await AuthUtils.getToken('accessToken');
    final url = Uri.parse(AppData.baseUrl + '/$endpoint');
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
      );
      print(response.body);
      if (jsonDecode(utf8.decode(response.bodyBytes))
          .containsKey('error_code')) {
        if (jsonDecode(utf8.decode(response.bodyBytes))['error_code'] ==
            17000) {
          controller.changeAndShowDialog();

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
    final url = Uri.parse(AppData.baseUrl + '/api/v1/users/token/refresh/');
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
