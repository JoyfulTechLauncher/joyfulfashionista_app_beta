import 'package:flutter/material.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  RegisterController();

  GlobalKey formKey = GlobalKey<FormState>();

  // User
  TextEditingController userNameController =
      TextEditingController(text: "ducafecat5");
  // Mail
  TextEditingController emailController =
      TextEditingController(text: "ducafecat5@gmail.com");
  // last name
  TextEditingController firstNameController =
      TextEditingController(text: "ducafe");
  // first name
  TextEditingController lastNameController = TextEditingController(text: "cat");
  // password
  TextEditingController passwordController =
      TextEditingController(text: "12345678");

  // sign up
  void onSignUp() {
    if ((formKey.currentState as FormState).validate()) {
      // aes password
      var password = EncryptUtil().aesEncode(passwordController.text);

      //Verified
      Get.offNamed(
        RouteNames.systemRegisterPin,
        arguments: UserRegisterReq(
          username: userNameController.text,
          email: emailController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          password: password,
        ),
      );
    }
  }

  // Sign in
  void onSignIn() {
    Get.offNamed(RouteNames.systemLogin);
  }

  _initData() {
    update(["register"]);
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

  @override
  void onClose() {
    super.onClose();
    userNameController.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
  }
}
