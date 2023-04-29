import 'package:http/http.dart' as http;
import 'dart:convert';
import 'common/index.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

// "username": "wpausersN4h4Cfb",
// "password": "Pf1x8pQGFX4IsBJnrUa7sMoxKisu28UJ"
const consumer_key = 'ck_b6edf8ca8492e34cbcec6cf3579a5e55745d9b8d';
const consumer_secret = 'cs_1fcc12c1ff0aefe208147731cb51925744e089c2';
const apiUrl = 'https://joyfulteams.shop';
String basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'ck_b6edf8ca8492e34cbcec6cf3579a5e55745d9b8d:cs_1fcc12c1ff0aefe208147731cb51925744e089c2'));

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
  final String apiUrl = 'https://joyfulteams.shop/wp-json/wc/v3/customers';
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

Future<int> getSelfId(String token) async{
  final response = await http.get(
      Uri.parse('$apiUrl/wp-json/wp/v2/users/me'),
      headers: {
        'Authorization': 'Bearer $token',
      }
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    if (jsonResponse.isNotEmpty) {
      // print('Status code: ${response.statusCode}');
      // print(jsonResponse["id"]);
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

Future<void> profile(String token, int id) async{

  final response = await http.get(
      Uri.parse('$apiUrl/wp-json/wc/v3/customers/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      }
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    if (jsonResponse.isNotEmpty) {
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      // print(jsonResponse["id"]);
      // return jsonResponse["id"];
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

Future<String> fetchJwtToken() async {
  final String url = 'https://joyfulteams.shop/wp-json/jwt-auth/v1/token';
  final String username = 'wpausersN4h4Cfb';
  final String password = 'Pf1x8pQGFX4IsBJnrUa7sMoxKisu28UJ';

  final Map<String, String> headers = {
    'Authorization': basicAuth,
    'Accept': 'application/json',
  };
  final Map<String, String> body = {
    'username': 'wpausersN4h4Cfb',
    'password': 'Pf1x8pQGFX4IsBJnrUa7sMoxKisu28UJ',
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
    // print('token $token');
    // print(jsonResponse);
    return token;
  } else {
    print('Status code: ${response.statusCode}');
    throw Exception('Failed to login');

  }
}
class UserApi {
  /// 注册
  static Future<bool> register(UserRegisterReq? req) async {
    final String apiUrl = 'https://joyfulteams.shop/wp-json/wc/v3/customers';

    var res = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(req),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth
        }
    );
    if (res.statusCode == 201) {
      return true;
    }
    return false;
  }

  /// login
  // static Future<UserTokenModel> login(UserLoginReq? req) async {
  //   var res = await WPHttpService.to.post(
  //     '/wp-json/jwt-auth/v1/token',
  //     data: req,
  //   );
  //
  //   return UserTokenModel.fromResponse(res);
  // }
  /// login
  static Future<String> login(String email, String password) async {
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
      // print('token $token');
      // print(jsonResponse);
      return token;
    } else {
      print('Status code: ${response.statusCode}');
      throw Exception('Failed to login');

    }
  }



  /// get id
  Future<int> getSelfId(String token) async{
    final response = await http.get(
        Uri.parse('https://joyfulteams.shop/wp-json/wp/v2/users/me'),
        headers: {
          'Authorization': 'Bearer $token',
        }
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse.isNotEmpty) {
        // print('Status code: ${response.statusCode}');
        // print(jsonResponse["id"]);
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


  /// Profile
  ///
  // TODO: Fix getting profile use user token obtained from login
  static Future<UserProfileModel> profile() async {
    var res = await WPHttpService.to.get(
      //'/users/me',
      '/wp-json/wc/v3/customers',
    );
    print('---------------------------'+ UserProfileModel.fromJson(res.data).toString());
    return UserProfileModel.fromJson(res.data);
  }

  /// 保存用户 billing address
  static Future<UserProfileModel> saveBillingAddress(Billing? req) async {
    var res = await WPHttpService.to.put(
      //'/users/me',
      '/wp-json/wc/v3/customers',
      data: {
        "billing": req,
      },
    );
    return UserProfileModel.fromJson(res.data);
  }

  /// 保存用户 shipping address
  static Future<UserProfileModel> saveShippingAddress(Shipping? req) async {
    var res = await WPHttpService.to.put(
      //'/users/me',
      '/wp-json/wc/v3/customers',
      data: {
        "shipping": req,
      },
    );
    return UserProfileModel.fromJson(res.data);
  }

  /// 大陆国家洲省列表
  static Future<List<ContinentsModel>> continents() async {
    var res = await WPHttpService.to.get(
      //'/users/continents',
      '/wp-json/wc/v3/customers/shipping/country',
    );

    List<ContinentsModel> continents = [];
    for (var item in res.data) {
      continents.add(ContinentsModel.fromJson(item));
    }
    return continents;
  }

  /// 保存用户 first name 、 last name 、 email
  static Future<UserProfileModel> saveBaseInfo(UserProfileModel req) async {
    var res = await WPHttpService.to.put(
      //'/users/me',
      '/wp-json/wc/v3/customers',
      data: {
        "first_name": req.firstName,
        "last_name": req.lastName,
        "email": req.email,
      },
    );
    return UserProfileModel.fromJson(res.data);
  }
}


void main() async{
  String email = 'tom@tom.com';
  String username = 'tom';
  String password = '123456';
/// Aa1234567890--
  String? token =  await UserApi.login(username, password);
  print(token);

  // int? id = await getSelfId(token);
  // // print(id);
  //
  // await profile(token, id);

}



