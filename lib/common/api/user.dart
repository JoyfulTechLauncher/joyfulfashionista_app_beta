import '../index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'ck_b6edf8ca8492e34cbcec6cf3579a5e55745d9b8d:cs_1fcc12c1ff0aefe208147731cb51925744e089c2'));

/// 用户 api
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
  static Future<int> getSelfId(String token) async{
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

  static Future<UserProfileModel> profile1() async {
    var res = await WPHttpService.to.get(
      //'/users/me',
      '/wp-json/wc/v3/customers',
    );
    print('---------------------------'+ UserProfileModel.fromJson(res.data).toString());
    return UserProfileModel.fromJson(res.data);
  }
  static Future<UserProfileModel> profile(String token) async{
    int id = await UserApi.getSelfId(token);

    final response = await http.get(
        Uri.parse('https://joyfulteams.shop/wp-json/wc/v3/customers/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        }
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse.isNotEmpty) {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return UserProfileModel.fromJson(jsonResponse);
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
  // String email = 'tom@tom.com';
  String username = 'tom';
  String password = '8h76\$PlAb*CK%vz%kK#wPxvh';
  // UserApi api = UserApi();

  // String token =  await UserApi.login(username, password);
  // print(token);

  // int? id = await getSelfId(token);
  print("hello");
  //
  // await profile(token, id);

}