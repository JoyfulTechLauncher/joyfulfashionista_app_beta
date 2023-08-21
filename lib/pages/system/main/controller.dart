import 'package:flutter/material.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  MainController();

  // page controller
  final PageController pageController = PageController();

  //current tab index
  int currentIndex = 0;

  // Navigation bar toggle
  void onIndexChanged(int index) {
    currentIndex = index;
    update(['navigation']);
  }

  // jump to page
  void onJumpToPage(int page) {
    if ((page != 0) && !UserService.to.isLogin) {
      Get.toNamed(RouteNames.systemLogin);
    } else {
      pageController.jumpToPage(page);
    }
  }

  _initData() async {
    // read profile
    // await UserService.to.getProfile();

    // test
    // Get.toNamed(RouteNames.systemLogin);

    update(["main"]);
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
    // dispose page controller
    pageController.dispose();
  }
}
