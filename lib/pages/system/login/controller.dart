import 'package:flutter/material.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  LoginController();

  /// Define the input controller
  TextEditingController userNameController =
      TextEditingController(text: "tester_1");
  TextEditingController passwordController =
      TextEditingController(text: "123456");

  /// form key
  GlobalKey formKey = GlobalKey<FormState>();

  /// Sign In
  Future<void> onSignIn() async {
    if ((formKey.currentState as FormState).validate()) {
      // try {
        Loading.show();

        // aes encrypted password

        // api request
        // UserTokenModel res = await UserApi.login(UserLoginReq(
        //   username: userNameController.text,
        //   password: passwordController.text
        // ));

        final response = await http.post(
          Uri.parse('https://joyfulteams.shop/wp-json/jwt-auth/v1/token'),
          body: {
            'username': userNameController.text,
            'password': passwordController.text
          },
        );

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          String userToken = jsonResponse['token'];

          await UserService.to.setToken(userToken);
          await UserService.to.getProfile();

          Loading.success();
          Get.back(result: true);
        }
        else {
          print('Status code: ${response.statusCode}');
          throw Exception('Failed to login');
        }


        // if (res.statusCode == 200) {
        //   // // local save token
        //   // await UserService.to.setToken(res.token!);
        //   // // get user profile
        //   // await UserService.to.getProfile();
        //   Loading.success();
        //   Get.back(result: true);
        // }
        // else {
        //   print('Status code: ${res.statusCode}');
        //   print('User token: ${res.token}');
        //   Loading.dismiss();
        // }
      // } finally {
      //   Loading.dismiss();
      // }
    }
  }

  /// Sign Up
  void onSignUp() {
    Get.offNamed(RouteNames.systemRegister);
  }

  _initData() {
    update(["login"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  /// dispose
  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    passwordController.dispose();
  }
}
