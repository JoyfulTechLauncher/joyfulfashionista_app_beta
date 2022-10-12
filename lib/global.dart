import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'common/index.dart';

class Global {
  static Future<void> init() async {
    var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    setSystemUi();

    // Tools
    await Storage().init();
    Loading();

    // init service
    Get.put<ConfigService>(ConfigService());
    Get.put<WPHttpService>(WPHttpService());
    Get.put<UserService>(UserService());
    Get.put<CartService>(CartService());
  }

  // system
  static void setSystemUi() {
    if (GetPlatform.isMobile) {
      // screen orientation upright
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      // Transparent status bar
      // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      //   statusBarColor: Colors.transparent, // transparent status bar
      // ));
    }

    if (GetPlatform.isAndroid) {
      // Remove top system drop down and bottom system button
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      // Remove the bottom system button
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      //     overlays: [SystemUiOverlay.bottom]);

      // custom style
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        // top status bar color
        // statusBarColor: Colors.transparent,
        // This property is only used for the brightness of the top status bar on iOS devices
        // statusBarBrightness: Brightness.light,
        // Brightness of top status bar icons
        // statusBarIconBrightness: Brightness.light,

        // Bottom status bar and main content divider color
        systemNavigationBarDividerColor: Colors.transparent,
        // Bottom status bar color
        systemNavigationBarColor: Colors.white,
        // Bottom status bar icon style
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
