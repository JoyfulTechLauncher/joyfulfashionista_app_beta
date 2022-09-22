import 'package:flutter/material.dart';

/// 基础功能色
@immutable
class ExtBaseColorTheme extends ThemeExtension<ExtBaseColorTheme> {
  /// 亮
  static const light = ExtBaseColorTheme(
    info: Color(0xFF2196F3),
    success: Color(0xFF4CAF50),
    warning: Color(0xFFFFC107),
    danger: Color(0xFFF44336),
  );

  /// 暗
  static const dark = ExtBaseColorTheme(
    info: Color(0xFF2196F3),
    success: Color(0xFF4CAF50),
    warning: Color(0xFFFFC107),
    danger: Color(0xFFF44336),
  );

  /// 信息
  final Color? info;

  /// 成功
  final Color? success;

  /// 警告
  final Color? warning;

  /// 错误
  final Color? danger;

  const ExtBaseColorTheme({
    required this.info,
    required this.success,
    required this.warning,
    required this.danger,
  });

  @override
  ThemeExtension<ExtBaseColorTheme> copyWith({
    Color? info,
    Color? success,
    Color? warning,
    Color? error,
  }) {
    return ExtBaseColorTheme(
      info: info ?? this.info,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: error ?? danger,
    );
  }

  @override
  ThemeExtension<ExtBaseColorTheme> lerp(
      ThemeExtension<ExtBaseColorTheme>? other, double t) {
    if (other is! ExtBaseColorTheme) {
      return this;
    }
    return ExtBaseColorTheme(
      info: Color.lerp(info, other.info, t),
      success: Color.lerp(success, other.success, t),
      warning: Color.lerp(warning, other.warning, t),
      danger: Color.lerp(danger, other.danger, t),
    );
  }

  @override
  String toString() {
    return 'ExtBaseColorTheme('
        'info: $info,'
        'success: $success,'
        'warning: $warning,'
        'error: $danger,'
        ')';
  }
}
