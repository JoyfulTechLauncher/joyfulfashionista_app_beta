import 'package:flutter/material.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';
import 'package:joyfulfashionista_app/pages/index.dart';
class RegisterPinController extends GetxController {
  RegisterPinController();
  // register interface pass value
  UserRegisterReq? req = Get.arguments;

  // pin text input controller
  TextEditingController pinController = TextEditingController();

  // form key
  GlobalKey formKey = GlobalKey<FormState>();

  // verify pin
  String? pinValidator(val) {
    print(randomNumber);
    return val == '$randomNumber'
        ? null
        : LocaleKeys.commonMessageIncorrect.trParams({"method": "Pin"});
  }

  // register
  Future<void> _register() async {
    try {
      Loading.show();

      // Temporarily submitted, subsequent changes to aes encryption post-processing
      bool isOk = await UserApi.register(req);
      if (isOk) {
        Loading.success(
            LocaleKeys.commonMessageSuccess.trParams({"method": "Register"}));
        Get.back(result: true);
      }
      // // succes
      // Loading.success(
      //     LocaleKeys.commonMessageSuccess.trParams({"method": "Register"}));
      // Get.back(result: true);
    } finally {
      Loading.dismiss();
    }
  }

  _initData() {
    update(["register_pin"]);
  }

  // pin trigger commit
  void onPinSubmit(String val) {
    debugPrint("onPinSubmit: $val");
  }

  // button trigger commit
  void onBtnSubmit() {
    _register();
  }

  //button trigger backup
  void onBtnBackup() {
    Get.back();
  }

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
    pinController.dispose();
  }
}
