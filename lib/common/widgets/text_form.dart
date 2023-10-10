import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:joyfulfashionista_app/common/index.dart';

class ThisWidget extends StatefulWidget {
  const ThisWidget({super.key});

  @override
  State<ThisWidget> createState() => _ThisWidgetState();
}

class _ThisWidgetState extends State<ThisWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// TextFormField 表单 输入框
class TextFormWidget extends StatefulWidget {
  /// 控制器
  final TextEditingController? controller;

  /// 输入框样式
  final InputDecoration? decoration;

  /// 验证函数
  final String? Function(String?)? validator;

  /// 自动焦点
  final bool? autofocus;

  /// 标题
  final String? labelText;

  /// 必须输入
  final bool? isMustBeEnter;

  /// 是否密码
  final bool? isObscure;

  /// 是否只读
  final bool? readOnly;

  /// 输入法类型
  final TextInputType? keyboardType;

  /// 输入格式定义
  final List<TextInputFormatter>? inputFormatters;

  /// 提示文字
  final String? hintText;

  /// 点击事件
  final Function()? onTap;

  /// 最小行数
  final int? minLines;

  /// 最大行数
  final int? maxLines;

  const TextFormWidget({
    Key? key,
    this.controller,
    this.autofocus = false,
    this.labelText,
    this.isMustBeEnter = false,
    this.validator,
    this.isObscure = false,
    this.decoration,
    this.keyboardType,
    this.inputFormatters,
    this.readOnly = false,
    this.onTap,
    this.hintText,
    this.minLines,
    this.maxLines,
  }) : super(key: key);

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  // 是否显示明文按钮
  bool _isShowObscureIcon = false;

  @override
  void initState() {
    super.initState();
    _isShowObscureIcon = widget.isObscure!;
  }

  @override
  Widget build(BuildContext context) {
    final withObscure = TextFormField(
      onTap: widget.onTap,
      // 点击事件
      readOnly: widget.readOnly!,
      // 是否只读
      autofocus: widget.autofocus!,
      // 自动焦点
      keyboardType: widget.keyboardType,
      // 输入法类型
      controller: widget.controller,
      // 控制器
      decoration: InputDecoration(
        hintText: widget.hintText, // 提示文字
        // 标题
        labelText: widget.isMustBeEnter == true
            ? "* ${widget.labelText}"
            : widget.labelText,
        // 密码按钮
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isShowObscureIcon = !_isShowObscureIcon;
            });
          },
          icon: Icon(
            _isShowObscureIcon == true
                ? Icons.visibility
                : Icons.visibility_off,
            size: 15,
            color: AppColors.surfaceVariant,
          ),
        ),
      ),
      // 校验
      validator: widget.validator,
      // 是否密码
      obscureText: _isShowObscureIcon,
      // 输入格式
      inputFormatters: widget.inputFormatters,
    );
    final withoutObscure = TextFormField(
      onTap: widget.onTap,
      // 点击事件
      readOnly: widget.readOnly!,
      // 是否只读
      autofocus: widget.autofocus!,
      // 自动焦点
      keyboardType: widget.keyboardType,
      // 输入法类型
      controller: widget.controller,
      // 控制器
      decoration: widget.decoration ??
          InputDecoration(
            hintText: widget.hintText,
            labelText: widget.isMustBeEnter == true
                ? "* ${widget.labelText}"
                : widget.labelText,
          ),
      // 校验
      validator: widget.validator,
      // 是否密码
      obscureText: _isShowObscureIcon,
      // 输入格式
      inputFormatters: widget.inputFormatters,
    );
    return widget.isObscure == true ? withObscure : withoutObscure;
  }
}
