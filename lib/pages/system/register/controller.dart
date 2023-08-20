import 'package:flutter/material.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'dart:convert';
import 'package:args/args.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:math';
const scopes = ['https://mail.google.com'];
String basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'ck_79e2c4c70e87dac66405834e972982eb7b02feb5:cs_fb0e4132784e31f0c5ca87ddc2529ecf1d59ca6f'));
var randomNumber = Random().nextInt(900000) + 100000;
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
  //     // aes password
       var password = passwordController.text;
  //
  //
  //    Verified
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


  void Mailer() async {
    var randomnum = Random().nextInt(900000) + 100000;
    randomNumber = randomnum;
    String username = 'qingyang0818@gmail.com';
    String password = 'rpnzuymxtcwnmmix';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Joyful')
      ..recipients.add(emailController.text)
      ..subject = 'Auth test'
      ..text = 'Your authentication code is $randomNumber';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent due to MailerException');
      print('Error: ${e.message}');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    } catch (e) {
      print('Message not sent due to unknown error');
      print('Error: $e');
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

  @override
  void onInit() {
    super.onInit();
  }

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
