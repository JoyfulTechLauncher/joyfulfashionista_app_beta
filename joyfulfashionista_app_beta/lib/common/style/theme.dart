import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'index.dart';

/// 主题
class AppTheme {
  /// 亮色
  static ThemeData light = ThemeData(
    useMaterial3: false,
    colorScheme: lightColorScheme,
    extensions: const <ThemeExtension<dynamic>>[
      ExtBaseColorTheme.light,
      ExtWooColorTheme.light,
    ],
    fontFamily: "Montserrat",
    appBarTheme: const AppBarTheme(
      // appBar 暗色 , 和主题色相反
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      // 背景透明
      backgroundColor: Colors.transparent,
      // 取消阴影
      elevation: 0,
      // 图标样式
      iconTheme: IconThemeData(
        color: Color(0xFF5F84FF),
      ),
      // 标题
      titleTextStyle: TextStyle(
        color: Color(0xFF4D4D4D),
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  /// 暗色
  static ThemeData dark = ThemeData(
    useMaterial3: false,
    colorScheme: darkColorScheme,
    extensions: const <ThemeExtension<dynamic>>[
      ExtBaseColorTheme.dark,
      ExtWooColorTheme.dark,
    ],
    fontFamily: "Montserrat",
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light, // appBar 亮色 , 和主题色相反
    ),
  );
}
