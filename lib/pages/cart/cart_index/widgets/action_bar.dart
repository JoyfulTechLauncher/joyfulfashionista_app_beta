import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';

/// 顶部操作栏
class ActionBar extends StatelessWidget {
  final bool isAll;
  final Function(bool)? onAll;
  final Function()? onRemove;

  const ActionBar({
    Key? key,
    this.onAll,
    this.isAll = false,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      // 选择框
      CheckBoxWidget.all(
        isAll,
        onAll,
        size: 24.sp,
        fontColor: AppColors.highlight,
        label: TextWidget.body1(
          LocaleKeys.gCartBtnSelectAll.tr,
          weight: FontWeight.bold,
        ),
      ).expanded(),

      // 删除按钮
      ButtonWidget.icon(
        IconWidget.icon(
          CupertinoIcons.delete,
          size: 20.sp,
        ),
        onTap: onRemove,
      ),
    ].toRow();
  }
}
