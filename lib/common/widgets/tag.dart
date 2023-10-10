import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joyfulfashionista_app/common/index.dart';

class TagWidget extends StatelessWidget {

  // tag
  final String? tag;

  // tag text
  final Text? tagText;

  // color
  final Color? color;

  // border radius
  final BorderRadius? borderRadius;

  // padding
  final EdgeInsets? padding;

  // closeable
  final bool? closeable;

  // on close
  final Function()? onClose;

  const TagWidget({
    Key? key,
    this.tag,
    this.tagText,
    this.color,
    this.borderRadius,
    this.padding,
    this.closeable,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? AppColors.primary,
        borderRadius: borderRadius ?? BorderRadius.circular(4),
      ),
      padding: padding ?? EdgeInsets.all(5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          tagText ?? Text(tag ?? "", style: TextStyle(color: Colors.white, fontSize: 12),),
          SizedBox(width: 5),
          if (closeable ?? false) GestureDetector(
            onTap: () {
              onClose?.call();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}