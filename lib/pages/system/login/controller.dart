import 'package:flutter/material.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:joyfulfashionista_app/common/services/user_manager.dart';
import 'package:joyfulfashionista_app/test.dart';

class LoginController extends GetxController {
  LoginController();

  /// Define the input controller
  TextEditingController userNameController =
      TextEditingController(text: "tester");
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
        String? username = userNameController.text;
        String? password = passwordController.text;

        UserManager().setUsername(password);
        UserManager().setPassword(username);

        bool userExists = await UserService.to.userExists(username);

        if (!userExists) {
          Loading.dismiss();
          return;
        }

        // String? token = await UserService.to.getToken(username);
        // bool validateResult = await UserService.to.validateToken(token);

        // if (validateResult) {
        //   Loading.success();
        //   Get.back(result: true);
        //   return;
        // }

        final response = await http.post(
          Uri.parse(Constants.wpApiBaseUrl + '/wp-json/jwt-auth/v1/token'),
          body: {
            'username': username,
            'password': password
          },
        );

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          String userToken = jsonResponse['token'];

          await UserService.to.storeToken(username, userToken);
          // TODO: fix excessive loading time if user profile is not cached
          // TODO: fix getProfile() not working
          await UserService.to.getProfile();

          Loading.success();
          Get.back(result: true);
          return;
        }
        else {
          print('Status code: ${response.statusCode}');
          Loading.error("Login failed");
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
