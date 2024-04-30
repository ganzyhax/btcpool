import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthUtils {
  static final FlutterSecureStorage storage = FlutterSecureStorage();
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
    await storage.write(key: key, value: value);
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
    print(otp.length);
    final url = Uri.parse('https://back.btcpool.kz/api/v1/users/token/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: (otp.length == 0)
          ? jsonEncode({'username': username, 'password': password})
          : jsonEncode(
              {'username': username, 'password': password, 'otp_code': otp}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      await saveToken('accessToken', data['access']);
      await saveToken('refreshToken', data['refresh']);
      return true;
    } else {
      return jsonDecode(response.body);
    }
  }

  static Future<dynamic> register(
    String username,
    String email,
    String password,
    String password2,
    String organization_bin,
    String phone,
  ) async {
    final url = Uri.parse('https://back.btcpool.kz/api/v1/users/register/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
        "password2": password2,
        "organization_bin": organization_bin,
        "phone": phone
      }),
    );

    if (response.statusCode == 200) {
      // await saveToken('accessToken', data['access']);
      // await saveToken('refreshToken', data['refresh']);
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  static Future<bool> auth(
    String email,
  ) async {
    final url = Uri.parse(
        'https://back.btcpool.kz/api/v1/users/verification_code/send/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
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
      return false;
    }
  }

  static Future<dynamic> verify(
    String email,
    String code,
  ) async {
    final url = Uri.parse(
        'https://back.btcpool.kz/api/v1/users/verification_code/verify/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "code": code,
      }),
    );

    if (response.statusCode == 200) {
      // await saveToken('accessToken', data['access']);
      // await saveToken('refreshToken', data['refresh']);
      return true;
    } else {
      return jsonDecode(response.body);
    }
  }

  static Future<dynamic> reset(
    String email,
  ) async {
    final url =
        Uri.parse('https://back.btcpool.kz/api/v1/users/reset_password/send/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
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
      return jsonDecode(response.body);
    }
  }

  static Future<dynamic> resetConfirmCode(String email, String code) async {
    final url = Uri.parse(
        'https://back.btcpool.kz/api/v1/users/reset_password/verify/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({"email": email, 'code': code}),
    );

    if (response.statusCode == 200) {
      // await saveToken('accessToken', data['access']);
      // await saveToken('refreshToken', data['refresh']);
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  static Future<dynamic> resetSetPassword(
      String email, String password, String resetToken) async {
    final url =
        Uri.parse('https://back.btcpool.kz/api/v1/users/reset_password/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
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
      return jsonDecode(response.body);
    }
  }
}
