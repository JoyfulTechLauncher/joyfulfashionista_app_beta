import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import '../index.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

/// 用户服务
class UserService extends GetxService {
  static UserService get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;
  final String baseUrl = Constants.wpApiBaseUrl;
  // 用户令牌
  String token = '';

  // 用户的资料
  final _profile = UserProfileModel().obs;

  /// 是否登录
  bool get isLogin => _isLogin.value;

  /// 用户 profile
  UserProfileModel get profile => _profile.value;

  /// 是否有令牌 token
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    // 读 token
    token = Storage().getString(Constants.storageToken);
    // 读 profile
    var profileOffline = Storage().getString(Constants.storageProfile);
    if (profileOffline.isNotEmpty) {
      _profile(UserProfileModel.fromJson(jsonDecode(profileOffline)));
    }
  }

  Future<String> fetchJwtToken(String username, String password) async {
    final String url = '$baseUrl/wp-json/jwt-auth/v1/token';

    final Map<String, String> headers = {
      'Connection': 'keep-alive',
      'Content-Type': 'application/json',
    };

    final Map<String, String> body = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return jsonResponse['token'];
    } else {
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to fetch JWT token');
    }
  }

  Future<bool> validateToken(String? token) async {
    String url = '$baseUrl/wp-json/jwt-auth/v1/token/validate';

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Connection': 'keep-alive',
      'Content-Type': 'application/json',
    };

    final response = await http.post(
        Uri.parse(url),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        print('Token validated successfully');
        print('Response: ${response.body}');
        return true;
      } else {
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to validate JWT token');
    }
  }

  /// Checks if a user exists
  Future<bool> userExists(String username) async {
    final String url = '$baseUrl/wp-json/wp/v2/users?search=$username';

    // use tester's token as it has administrative privileges
    String? token = await fetchJwtToken('tester', '123456');

    final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        }
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse.isNotEmpty) {
        print('user exists');
        return true;
      } else {
        print('user does not exist');
        return false;
      }
    } else {
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("Failed to login user");
    }
  }

  Future<void> storeToken(String username, String userToken) async {
    await Storage().secureStorage.write(key: username, value: userToken);
    token = userToken;
    _isLogin.value = true;
  }

  Future<String?> getToken(String username) async {
    return await Storage().secureStorage.read(key: username);
  }

  Future<bool> deleteToken(String username) async {
    await Storage().secureStorage.delete(key: username);
    return true;
  }


  /// 设置令牌
  Future<void> setToken(String value) async {
    await Storage().setString(Constants.storageToken, value);
    token = value;
  }

  /// 获取用户 profile
  Future<void> getProfile() async {
    if (token.isEmpty) return;

    // TODO: Fix getting profile
    UserProfileModel result = await UserApi.profile(token);
    _profile(result);
    _isLogin.value = true;

    Storage().setString(Constants.storageProfile, jsonEncode(result));
  }

  /// 设置用户 profile
  Future<void> setProfile(UserProfileModel profile) async {
    if (token.isEmpty) return;
    _isLogin.value = true;
    _profile(profile);
    Storage().setString(Constants.storageProfile, jsonEncode(profile));
  }

  /// 注销
  Future<void> logout() async {
    // if (_isLogin.value) await UserAPIs.logout();
    await Storage().remove(Constants.storageToken);
    _profile(UserProfileModel());
    _isLogin.value = false;
    token = '';
  }



  /// 检查是否登录
  Future<bool> checkIsLogin() async {
    if (_isLogin.value == false) {
      await Get.toNamed(RouteNames.systemLogin);
      return false;
    }
    return true;
  }

  /// 送货地址
  String get shipping =>
      "${profile.shipping?.address1}, ${profile.shipping?.postcode}, ${profile.shipping?.state}, ${profile.shipping?.country}";
}
