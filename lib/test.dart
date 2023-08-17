import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';

// "username": "wpausersN4h4Cfb",
// "password": "Pf1x8pQGFX4IsBJnrUa7sMoxKisu28UJ"
const consumer_key = 'ck_79e2c4c70e87dac66405834e972982eb7b02feb5';
const consumer_secret = 'cs_fb0e4132784e31f0c5ca87ddc2529ecf1d59ca6f';
final String baseUrl = 'https://teamjoyful.buzz';

final storage = new FlutterSecureStorage();

String basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        '$consumer_key:$consumer_secret'));

Future<bool> login(String username, String password) async {

  if  (await storage.containsKey(key: username)) {
    String? token = await storage.read(key: username);
    if (await validateToken(token)) {
      print('Token is valid');
      return true;
    }
    else {
      String? token = await fetchJwtToken(username, password);
      storeJwtToken(username, token);
      return true;
    }

  }
  else {
    return false;
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
      Uri.parse(baseUrl),
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

Future<int> profile(String token) async{
  final response = await http.get(
      Uri.parse('$baseUrl/wp-json/wp/v2/users/me'),
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

Future<void> storeJwtToken(String username, String userToken) async {
  await storage.write(key: username, value: userToken);
}

Future<String?> getToken(String username) async {
  return await storage.read(key: username);
}

Future<bool> deleteToken(String username) async {
  await storage.delete(key: username);
  return true;
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  String username = 'tester';
  String password = '123456';
  // fetchJwtToken(username, password);
  //
  // storeJwtToken("123", "12345");
  // storeJwtToken("123", "99999");
  //
  // storeJwtToken("234", "23456");
  //
  //
  // // deleteToken("123");
  // // deleteToken("234");
  // String? token1 = await getToken("123");
  // String? token2 = await getToken("234");
  // print(token1);
  // print(token2);
  //
  // validateToken(await fetchJwtToken(username, password));
  userExists('tester');
}




