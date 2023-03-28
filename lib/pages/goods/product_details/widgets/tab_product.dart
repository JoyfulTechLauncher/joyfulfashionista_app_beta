import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';

import '../index.dart';

/// 商品规格
class TabProductView extends GetView<ProductDetailsController> {
  final String uniqueTag;

  const TabProductView({Key? key, required this.uniqueTag}) : super(key: key);

  @override
  String? get tag => uniqueTag;

  // 标题
  _buildTitle(String title) {
    return TextWidget.body1(title).paddingBottom(AppSpace.listRow);
  }

  @override
  Widget build(BuildContext context) {
    if(ConfigService.to.locale.toLanguageTag() == "en-US") {
      return <Widget>[
        // 颜色
        _buildTitle("Color: Gray"),
        GetBuilder<ProductDetailsController>(
          id: "product_colors",
          tag: uniqueTag,
          builder: (_) {
            return ColorsListWidget(
              itemList: controller.colors,
              keys: controller.colorKeys,
              size: 33.w,
              onTap: controller.onColorTap,
            ).paddingBottom(AppSpace.listRow * 2);
          },
        ),

        // 尺寸
        _buildTitle("Size: 10"),
        GetBuilder<ProductDetailsController>(
          id: "product_sizes",
          tag: uniqueTag,
          builder: (_) {
            return TagsListWidget(
              itemList: controller.sizes,
              keys: controller.sizeKeys,
              onTap: controller.onSizeTap,
            ).paddingBottom(AppSpace.listRow * 2);
          },
        ),

        // 运费说明
        _buildTitle("Shipping Charge"),
        <Widget>[
          // 运费
          const TextWidget.body1(
            "\$12.10",
            size: 18,
            weight: FontWeight.bold,
          ).paddingRight(AppSpace.listItem),
          // 说明
          const TextWidget.body2(
            "by paperfly shipment",
          ),
        ].toRow(),
      ]
          .toColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
      )
          .paddingVertical(AppSpace.page);
    }
    return <Widget>[
      // 颜色
      _buildTitle("颜色: 灰色"),
      GetBuilder<ProductDetailsController>(
        id: "product_colors",
        tag: uniqueTag,
        builder: (_) {
          return ColorsListWidget(
            itemList: controller.colors,
            keys: controller.colorKeys,
            size: 33.w,
            onTap: controller.onColorTap,
          ).paddingBottom(AppSpace.listRow * 2);
        },
      ),

      // 尺寸
      _buildTitle("尺寸: 10"),
      GetBuilder<ProductDetailsController>(
        id: "product_sizes",
        tag: uniqueTag,
        builder: (_) {
          return TagsListWidget(
            itemList: controller.sizes,
            keys: controller.sizeKeys,
            onTap: controller.onSizeTap,
          ).paddingBottom(AppSpace.listRow * 2);
        },
      ),

      // 运费说明
      _buildTitle("运费"),
      <Widget>[
        // 运费
        const TextWidget.body1(
          "\$12.10",
          size: 18,
          weight: FontWeight.bold,
        ).paddingRight(AppSpace.listItem),
        // 说明
        const TextWidget.body2(
          "通过Paperfly物流",
        ),
      ].toRow(),
    ]
        .toColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
    )
        .paddingVertical(AppSpace.page);
  }
}
