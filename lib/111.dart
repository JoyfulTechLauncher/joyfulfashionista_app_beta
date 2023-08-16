import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';

// "username": "wpausersN4h4Cfb",
// "password": "Pf1x8pQGFX4IsBJnrUa7sMoxKisu28UJ"
const consumer_key = 'ck_79e2c4c70e87dac66405834e972982eb7b02feb5';
const consumer_secret = 'cs_fb0e4132784e31f0c5ca87ddc2529ecf1d59ca6f';
const apiUrl = 'https://teamjoyful.buzz';

String basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        '$consumer_key:$consumer_secret'));
Future<void> fetchCustomers(String consumerKey, String consumerSecret) async {

  // 生成带有凭据的URL
  final String urlWithCredentials =
      apiUrl + '/wp-json/wc/v3/customers'
          + '?consumer_key=$consumerKey&consumer_secret=$consumerSecret';

  try {
    final response = await http.get(
        Uri.parse(urlWithCredentials)
    );

    if (response.statusCode == 200) {
      print("succeeded to send request");
      print(response.body.toString());
    } else {
      print("failed to send request");
      print(response.toString());
    }
  } catch (e) {
  }
}

Future<void> registerUser(String email, String username, String password) async {
  // final String apiUrl = '$apiUrl/wp-json/wc/v3/customers';
  final String url = 'https://joyfulteams.shop';

  final Map<String, String> userData = {
    'email': email,
    'username': username,
    'password': password,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode(userData),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': basicAuth
      }
    );

    if (response.statusCode == 201) {
      // request succeeded, do something with the response
      print('User registered successfully');
      print('Response body: ${response.body}');
    } else {
      // request failed, do something with the response
      print('Failed to register user');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    // handle errors
    print('Error: $e');
  }
}

// ------------------ login user ------------------ //
Future<int> loginUser(String username, String password) async {
  final credentials = base64Encode(utf8.encode('$username:$password'));
  final response = await http.get(
    Uri.parse('$apiUrl/wp-json/wp/v2/users/me'), // doesn't work; need to use jwt for authentication
    headers: {
      'Authorization': 'Basic $credentials',
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    if (jsonResponse.isNotEmpty) {
      print('Status code: ${response.statusCode}');
      print(jsonResponse[0]["id"]);
      return jsonResponse[0]["id"];
    } else {
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("User not found");
    }
  } else {
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception("Failed to login user");
  }
}

Future<int> profile(String token) async{
  final response = await http.get(
      Uri.parse('$apiUrl/wp-json/wp/v2/users/me'),
      headers: {
        'Authorization': 'Bearer $token',
      }
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    if (jsonResponse.isNotEmpty) {
      print('Status code: ${response.statusCode}');
      print(jsonResponse["id"]);
      return jsonResponse["id"];
    } else {
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("User not found");
    }
  } else {
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception("Failed to login user");
  }
}


Future<String> fetchJwtToken(String username, String password) async {
  final String url = 'https://teamjoyful.buzz/wp-json/jwt-auth/v1/token';

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

    // Check if local token is expired or not available
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedToken = prefs.getString('jwt_token');
    final String? storedExpiry = prefs.getString('jwt_token_expiry');

    if (storedToken == null || storedExpiry == null || DateTime.parse(storedExpiry).isBefore(DateTime.now())) {
      // Store the new token and its expiry
      prefs.setString('jwt_token', jsonResponse['token']);
      final DateTime newExpiry = DateTime.now().add(Duration(hours: 1)); // Assuming token expires in 1 hour
      prefs.setString('jwt_token_expiry', newExpiry.toIso8601String());

      return jsonResponse['token'];
    } else {
      return storedToken;
    }
  } else {
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to fetch JWT token');
  }
}

Future<String> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('https://joyfulteams.shop/wp-json/jwt-auth/v1/token'),
    body: {
      'username': email,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    String token = jsonResponse['token'];
    print('Status code: ${response.statusCode}');

    return token;
  } else {
    print('Status code: ${response.statusCode}');
    throw Exception('Failed to login');

  }
}

void main() async{
  // String email = 'tester';
  //String username = 'johnbdoe@google.com';

  WidgetsFlutterBinding.ensureInitialized();
  String username='tester';
  String password = '123456';
  // fetchCustomers(consumer_key, consumer_secret);
  //registerUser(email, username, password);
  // loginUser(username, password);

  //fetchJwtToken(username, password);


  final String expiredToken = 'expired_token'; // 模拟一个过期的 token

  // 模拟 SharedPreferences 返回过期的 token
  SharedPreferences.setMockInitialValues({'jwt_token': expiredToken, 'jwt_token_expiry': '2000-01-01T00:00:00Z'});
  final String newToken = await fetchJwtToken('tester', '123456'); // 替换为您的实际用户名和密码
  if (newToken != expiredToken) {
    print('New token obtained successfully!\n');
  } else {
    print('Token retrieval failed or token is still expired');
  }

}



