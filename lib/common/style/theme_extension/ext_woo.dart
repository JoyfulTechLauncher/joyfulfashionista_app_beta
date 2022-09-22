import 'package:flutter/material.dart';

/// 产品色
@immutable
class ExtWooColorTheme extends ThemeExtension<ExtWooColorTheme> {
  static const light = ExtWooColorTheme(highlight: Color(0xFFF77866));
  static const dark = ExtWooColorTheme(highlight: Color(0xFFFFB4A9));

  /// 强调色
  final Color? highlight;

  const ExtWooColorTheme({
    required this.highlight,
  });

  @override
  ThemeExtension<ExtWooColorTheme> copyWith({
    Color? highlight,
  }) {
    return ExtWooColorTheme(
      highlight: highlight ?? this.highlight,
    );
  }

  @override
  ThemeExtension<ExtWooColorTheme> lerp(
      ThemeExtension<ExtWooColorTheme>? other, double t) {
    if (other is! ExtWooColorTheme) {
      return this;
    }
    return ExtWooColorTheme(
      highlight: Color.lerp(highlight, other.highlight, t),
    );
  }

  @override
  String toString() {
    return 'ExtWooColorTheme('
        'highlight: $highlight,'
        ')';
  }
}
