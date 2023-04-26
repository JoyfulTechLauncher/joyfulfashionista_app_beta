import 'package:flutter/material.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';

import '../index.dart';

/// 商品详情
class TabDetailView extends GetView<ProductDetailsController> {
  final String uniqueTag;

  const TabDetailView({Key? key, required this.uniqueTag}) : super(key: key);

  @override
  String? get tag => uniqueTag;

  // 标题
  _buildTitle(String title) {
    return TextWidget.title3(title).paddingBottom(AppSpace.listRow);
  }

  // 内容
  _buildContent(String? title) {
    return TextWidget.title2(
      title ?? "-",
      softWrap: true,
      maxLines: 10,
    ).paddingBottom(AppSpace.listRow * 2);
  }

  @override
  Widget build(BuildContext context) {
    if(ConfigService.to.locale.toLanguageTag() == "en-US") {
      return <Widget>[
      // 说明
      _buildTitle("Description"),
      _buildContent(controller.product?.description?.clearHtml),

      // sku
      _buildTitle("SKU"),
      _buildContent(controller.product?.sku ?? "-"),

      // price
      _buildTitle("Price"),
      _buildContent(controller.product?.price ?? "-"),

      // 市场价
      _buildTitle("Regular price"),
      _buildContent(controller.product?.regularPrice ?? "-"),

      // 重量
      _buildTitle("Weight"),
      _buildContent(controller.product?.weight ?? "-"),

      // 尺寸
      _buildTitle("dimensions"),
      _buildContent(
          "${controller.product?.dimensions?.length} x ${controller.product?.dimensions?.width} x ${controller.product?.dimensions?.height}"),

      // end
    ]
        .toColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
        )
        .scrollable()
        .paddingVertical(AppSpace.page);
    }
    return <Widget>[
      // 说明
      _buildTitle("描述"),
      _buildContent(controller.product?.description?.clearHtml),

      // sku
      _buildTitle("SKU"),
      _buildContent(controller.product?.sku ?? "-"),

      // price
      _buildTitle("价格"),
      _buildContent(controller.product?.price ?? "-"),

      // 市场价
      _buildTitle("市场价"),
      _buildContent(controller.product?.regularPrice ?? "-"),

      // 重量
      _buildTitle("重量"),
      _buildContent(controller.product?.weight ?? "-"),

      // 尺寸
      _buildTitle("尺寸"),
      _buildContent(
          "${controller.product?.dimensions?.length} x ${controller.product?.dimensions?.width} x ${controller.product?.dimensions?.height}"),

      // end
    ]
        .toColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
    )
        .scrollable()
        .paddingVertical(AppSpace.page);
  }
}
