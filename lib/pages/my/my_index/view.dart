import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/index.dart';

class MyIndexPage extends GetView<MyIndexController> {
  const MyIndexPage({Key? key}) : super(key: key);

  // 顶部 APP 导航栏
  Widget _buildAppBar() {
    return SliverAppBar(
      // 背景色
      backgroundColor: Colors.transparent,
      // 固定在顶部
      pinned: true,
      // 浮动在顶部
      floating: true,
      // 自动弹性显示
      snap: true,
      // 是否应拉伸以填充过度滚动区域。
      stretch: true,
      // 高度
      expandedHeight: 280.h,
      // 此小组件堆叠在工具栏和选项卡栏后面。其高度将与应用栏的整体高度相同。
      flexibleSpace: FlexibleSpaceBar(
        // // // 折叠模式
        // collapseMode: CollapseMode.parallax,
        // // // 折叠动画
        // stretchModes: const [
        //   // 模糊
        //   StretchMode.blurBackground,
        //   // 尺寸
        //   StretchMode.zoomBackground,
        //   // 标题动画
        //   StretchMode.fadeTitle,
        // ],
        // // // 标题
        // title: const TextWidget.navigation(text: "Ducafecat"),
        // 背景
        background: <Widget>[
          // 背景图
          <Widget>[
            IconWidget.svg(
              AssetsSvgs.profileHeaderBackgroundSvg,
              color: AppColors.primaryContainer,
              fit: BoxFit.cover,
            ).expanded(),
            // const ImageWidget.(
            //   AssetsImages.profileBackgroundPng,
            //   fit: BoxFit.cover,
            // ).expanded(),
          ].toColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),

          // 内容
          <Widget>[
            // 用户信息
            <Widget>[
              // 头像
              ImageWidget.url(
                // 测试需要改成自定义头像
                "https://joyfulfashionista.com.au/wp-content/uploads/2022/01/JF-logo-colour-darkbg-scaled-300x209.jpg",
                width: 100.w,
                height: 100.w,
                fit: BoxFit.fill,
                radius: 50.w,
              ).paddingRight(AppSpace.listItem),

              // 称呼
              TextWidget.title1(
                "Joyful Team",
                color: Colors.white,
                size: 21.sp,
              ),
            ].toRow().paddingHorizontal(AppSpace.card),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 30.w,
              children: [
                Column(
                  children: [
                    TextWidget.title3(
                      LocaleKeys.myFollowers.tr,
                      color: Colors.white,
                    ),
                    TextWidget.body2(
                      '${20}',
                      color: Colors.white,
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextWidget.title3(
                      LocaleKeys.mySettled.tr,
                      color: Colors.white,
                    ),
                    TextWidget.body2(
                      '${6} months',
                      color: Colors.white,
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextWidget.title3(
                      LocaleKeys.myTrading.tr,
                      color: Colors.white,
                    ),
                    TextWidget.body2(
                      '${56}',
                      color: Colors.white,
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextWidget.title3(
                      LocaleKeys.myRating.tr,
                      color: Colors.white,
                    ),
                    TextWidget.body2(
                      '${99}%',
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ).paddingBottom(20.h),

            // 功能栏位
            <Widget>[
              // 1
              BarItemWidget(
                title: LocaleKeys.myTabWishlist.tr,
                svgPath: AssetsSvgs.iLikeSvg,
              ),
              // 2
              BarItemWidget(
                title: LocaleKeys.myTabFollowing.tr,
                svgPath: AssetsSvgs.iAddFriendSvg,
              ),
              // 3
              BarItemWidget(
                title: LocaleKeys.myTabVoucher.tr,
                svgPath: AssetsSvgs.iCouponSvg,
              ),
            ]
                .toRow(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                )
                .paddingAll(AppSpace.card)
                .card()
                .paddingHorizontal(AppSpace.page),
          ].toColumn(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ].toStack(),
      ),
    );
  }

  // My Order
  Widget _buildMyOrder() {
    return ButtonItemWidget(
      title: LocaleKeys.myBtnMyOrder.tr,
      svgPath: AssetsSvgs.pDeliverySvg,
      color: "4061FF".toColor,
      onTap: () => Get.toNamed(RouteNames.myOrderList),
    ).card().paddingVertical(AppSpace.page);
  }

  // 按钮列表
  Widget _buildButtonsList() {
    return <Widget>[
      // Edit Profile
      ButtonItemWidget(
        title: LocaleKeys.myBtnEditProfile.tr,
        svgPath: AssetsSvgs.pCurrencySvg,
        color: "4971FF".toColor,
        onTap: () => Get.toNamed(RouteNames.myProfileEdit),
      ),

      // Billing Address
      ButtonItemWidget(
        title: LocaleKeys.myBtnBillingAddress.tr,
        svgPath: AssetsSvgs.pHomeSvg,
        color: "F43284".toColor,
        onTap: () => controller.onToAddress(LocaleKeys.billingAddress.tr), // 类型 billing
      ),

      // Billing Address
      ButtonItemWidget(
        title: LocaleKeys.myBtnShippingAddress.tr,
        svgPath: AssetsSvgs.pHomeSvg,
        color: "5F84FF".toColor,
        onTap: () => controller.onToAddress(LocaleKeys.shippingAddress.tr), // 类型 shipping
      ),

      // Language
      //ButtonItemWidget(
      //  title: LocaleKeys.myBtnLanguage.tr,
      //  svgPath: AssetsSvgs.pTranslateSvg,
      //  color: "41AA3D".toColor,
      //  onTap: () => Get.toNamed(RouteNames.myLanguage),
      //),

      // Theme
      // ButtonItemWidget(
      //   title: LocaleKeys.myBtnTheme.tr,
      //   svgPath: AssetsSvgs.pThemeSvg,
      //   color: "F89C52".toColor,
      //   onTap: () => ConfigService.to.switchThemeModel(),
      // ),

      //About me
      ButtonItemWidget(
        title: LocaleKeys.myBtnAboutMe.tr,
        svgPath: AssetsSvgs.pCurrencySvg,
        color: "4971FF".toColor,
        onTap: () => Get.toNamed(RouteNames.aboutMe),
      ),

      // 调试工具
      ButtonItemWidget(
        title: LocaleKeys.myBtnStylesSetting.tr,
        svgPath: AssetsSvgs.pThemeSvg,
        color: "4971FF".toColor,
        onTap: () => Get.toNamed(RouteNames.stylesSettingIndex),
      ),

      // product upload
      ButtonItemWidget(
        title: LocaleKeys.gProductUpload.tr,
        svgPath: AssetsSvgs.navCartSvg,
        color: "4971FF".toColor,
        onTap: () => Get.toNamed(RouteNames.goodsProductUpload),
      ),
      // end
    ].toColumn().card().paddingBottom(30.h);
  }

  // 主视图
  Widget _buildView() {
    return CustomScrollView(
      slivers: <Widget>[
        // 顶部 APP 导航栏
        _buildAppBar(),
        // My Order
        _buildMyOrder().sliverBox,
        // 按钮列表
        _buildButtonsList().sliverBox,

        // 注销
        ButtonWidget.primary(
          LocaleKeys.myBtnLogout.tr,
          height: 60,
          onTap: () => controller.onLogout(),
        )
            .padding(
              left: AppSpace.page,
              right: AppSpace.page,
              bottom: AppSpace.listRow * 2,
            )
            .sliverBox,

        // 版权
        // const TextWidget.body2(
        //   "Code by: https://ducafefcat.tech",
        // ).alignCenter().paddingBottom(AppSpace.listRow).sliverBox,

        // 版本号
        TextWidget.body2(
          "v ${ConfigService.to.version}",
        ).alignCenter().paddingBottom(200).sliverBox,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyIndexController>(
      init: MyIndexController(),
      id: "my_index",
      builder: (_) {
        return Scaffold(
          // appBar: AppBar(title: const Text("my_index")),
          body: _buildView(),
        );
      },
    );
  }
}
