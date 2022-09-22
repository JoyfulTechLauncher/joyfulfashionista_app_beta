import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  SplashController();

  // _initData() {
  //   // update(["splash"]);
  // }

  void onTap() {}

  _jumpToPage() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      if (!ConfigService.to.isFirstOpen) {
        Get.offAllNamed(RouteNames.main);
      } else {
        Get.offAllNamed(RouteNames.systemWelcome);
      }
    });

    // Get.toNamed(RouteNames.stylesStylesIndex);

    // if (ConfigService.to.isFirstOpen == false) {
    //   Get.offAllNamed(RouteNames.systemWelcome);
    // } else {
    //   Get.offAllNamed(RouteNames.main);
    // }
    // 欢迎页
    // Future.delayed(const Duration(seconds: 1), () {
    //   Get.offAllNamed(RouteNames.systemWelcome);
    // });
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    FlutterNativeSplash.remove(); // 删除设备启动图
    // _initData(); // 初始数据
    _jumpToPage(); // 跳转界面
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
