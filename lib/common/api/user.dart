import '../index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


String basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'ck_b6edf8ca8492e34cbcec6cf3579a5e55745d9b8d:cs_1fcc12c1ff0aefe208147731cb51925744e089c2'));

/// 用户 api
class UserApi {
  /// 注册
  // static Future<bool> register(UserRegisterReq? req) async {
  //   var res = await WPHttpService.to.post(
  //     //'/users/register',
  //     '/wp-json/wc/v3/customers',
  //
  //     data: req,
  //   );
  //   if (res.statusCode == 201) {
  //     return true;
  //   }
  //   return false;
  // }

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
  static Future<UserTokenModel> login(UserLoginReq? req) async {
    var res = await WPHttpService.to.post(
      '/wp-json/jwt-auth/v1/token',
      data: req,
    );

    return UserTokenModel.fromResponse(res);
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
