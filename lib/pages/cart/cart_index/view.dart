import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';
import 'package:joyfulfashionista_app/pages/cart/buy_now/view.dart';

import 'index.dart';
import 'widgets/index.dart';

class CartIndexPage extends GetView<CartIndexController> {
  const CartIndexPage({Key? key}) : super(key: key);

  // 订单列表
  Widget _buildOrders() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        LineItem item = CartService.to.lineItems[index];
        return Dismissible(
          direction: DismissDirection.endToStart,
          key: Key('${item.id}'),
          onDismissed: (direction) {
            print(
              "delete product :${item.productId}",
            );
            // todo: delete product from cart
          },
          background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10),
              child: Text(
                LocaleKeys.commonMessageSwipeLeftToDelete.tr,
                style: TextStyle(color: Colors.white),
              )),
          child: CartItem(
            lineItem: item,
            onTap: () {
              controller.goProductDetail(item.productId!);
            },
            // 是否选中
            isSelected: controller.isSelected(item.productId!),
            // 选中回调
            onSelect: (isSelected) =>
                controller.onSelect(item.productId!, isSelected),
            // 修改数量
            onChangeQuantity: (quantity) =>
                controller.onChangeQuantity(item, quantity),
          ).paddingAll(AppSpace.card),
        );
        // return Text(item.product?.name ?? "").paddingAll(AppSpace.card).card();
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: AppSpace.listRow);
      },
      itemCount: CartService.to.lineItems.length,
    );
  }

  // 优惠券, 568935ab
  Widget _buildCoupons() {
    return <Widget>[
      // 输入框
      InputWidget.textBorder(
        hintText: LocaleKeys.placeOrderPriceVoucherCode.tr,
        fillColor: AppColors.surface,
        // 输入优惠券代码
        onChanged: (value) => controller.couponCode = value,
      ).expanded(),

      SizedBox(
        width: AppSpace.listItem,
      ),

      // 应用按钮
      ButtonWidget.text(
        LocaleKeys.gCartBtnApplyCode.tr,
        textColor: AppColors.highlight,
        textSize: 12.sp,
        textWeight: FontWeight.w500,
        onTap: controller.onApplyCoupon, // 应用事件
      ),
    ].toRow();
  }

  // 统计
  Widget _buildTotal() {
    return <Widget>[
      // 运费、代金券
      <Widget>[
        // 运费
        TextWidget.body3(
            "${LocaleKeys.gCartTextShippingCost.tr}: \$${CartService.to.shipping}"),
        // 代金券
        TextWidget.body3(
            "${LocaleKeys.gCartTextVocher.tr}: \$${CartService.to.discount}"),
      ]
          .toColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          )
          .expanded(),

      // 费用小计
      TextWidget.body2(
              "${LocaleKeys.gCartTextTotal.tr}: \$${CartService.to.totalItemsPrice - CartService.to.discount + CartService.to.shipping}")
          .paddingRight(AppSpace.iconTextMedium),

      // 确认下单 checkout
      ButtonWidget.primary(
        LocaleKeys.gCartBtnCheckout.tr,
        borderRadius: 3.sp,
        onTap: () {
          // 立刻购买 checkout
          ActionBottomSheet.barModel(
            BuyNowPage(
              product: CartService.to.product,
            ),
          );
        },
      ).tight(
        width: 100.w,
        height: 40.w,
      ),
    ]
        .toRow()
        .paddingAll(AppSpace.card)
        .decorated(
          color: AppColors.highlight.withOpacity(0.1),
          border: Border.all(color: AppColors.highlight, width: 1),
        )
        .height(60.w);
  }

  // 主视图
  Widget _buildView() {
    return <Widget>[
      // 顶部操作栏
      ActionBar(
        onAll: controller.onSelectAll,
        onRemove: controller.onOrderCancel,
        isAll: controller.isSelectedAll,
      ).paddingAll(AppSpace.page),

      // 订单列表
      _buildOrders().expanded(),

      // 优惠券
      _buildCoupons().paddingAll(AppSpace.page),

      // 费用小计
      _buildTotal(),
    ].toColumn();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartIndexController>(
      init: CartIndexController(),
      id: "cart_index",
      builder: (_) {
        return Scaffold(
          appBar: mainAppBarWidget(titleString: LocaleKeys.gCartTitle.tr),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
