import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joyfulfashionista_app/common/i18n/index.dart';
import 'package:joyfulfashionista_app/common/routers/names.dart';

import 'index.dart';

class MsgIndexPage extends GetView<MsgIndexController> {
  const MsgIndexPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return Column(
      children: [
        _buildIcon(),
        SizedBox(
          height: 10,
        ),
        _buildActions(),
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 1,
        ),
        SizedBox(
          height: 10,
        ),
        _buildList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MsgIndexController>(
      init: MsgIndexController(),
      id: LocaleKeys.messagePage,
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.messagePage.tr),
            leading: Icon(Icons.arrow_back_ios_new),
            centerTitle: true,
          ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }

  Widget _buildList() {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(
            "assets/images/coupons.jpg",
            width: 60,
            fit: BoxFit.fill,
            height: 60,
          ),
          trailing: Text("09/01/2023"),
          title: Text(
            textAlign: TextAlign.left,
            LocaleKeys.coupons.tr,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Your coupon expires tommorrow !",
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Image.asset(
            "assets/images/survery_center.jpg",
            width: 60,
            height: 60,
            fit: BoxFit.fill,
          ),
          title: Text(
            LocaleKeys.surverycenter.tr,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Session close"),
          trailing: Text("09/01/2023"),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Container(
      height: 128,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // 阴影颜色
            offset: Offset(0, 2), // 阴影偏移量
            blurRadius: 4, // 阴影模糊半径
          ),
        ],
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // Get.toNamed(
                //   RouteNames.goodsProductList,
                // );
                Get.toNamed(RouteNames.myOrderList);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        "assets/images/delivery.jpg",
                        height: 80,
                        width: 80,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Text(
                            "1",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(LocaleKeys.delivery.tr)
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset(
                      "assets/images/disco.jpg",
                      height: 80,
                      width: 80,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Text(
                          "0",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(LocaleKeys.discount.tr)
              ],
            ),
          ]),
    );
  }

  Widget _buildIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.cleaning_services),
        SizedBox(
          width: 10,
        ),
        Text(LocaleKeys.deleteAllMessage.tr),
      ],
    );
  }
}
