import 'package:flutter/material.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class ButtonsPage extends GetView<ButtonsController> {
  const ButtonsPage({Key? key}) : super(key: key);

  // main
  Widget _buildView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildButtons(),
        ],
      ).paddingAll(AppSpace.card),
    );
  }

  Widget _buildButtons() {
    return <Widget>[
      // primary button
      ButtonWidget.primary(
        "主按钮",
        onTap: () {},
      ).paddingBottom(AppSpace.listRow),

      // secondary button
      ButtonWidget.secondary(
        "次按钮",
        onTap: () {},
      ).paddingBottom(AppSpace.listRow),

      // text button
      ButtonWidget.text(
        "文字按钮",
        textSize: 16,
        onTap: () {},
        // onTap: () async {
        //   await ConfigService.to.switchThemeModel();
        //   controller.update(["buttons"]);
        // },
      ).paddingBottom(AppSpace.listRow),

      // icon button
      ButtonWidget.icon(
        IconWidget.svg(
          AssetsSvgs.cHomeSvg,
          size: 30,
        ),
        onTap: () {},
      ).tightSize(30).paddingBottom(AppSpace.listRow),

      // Text/fill button
      ButtonWidget.textFilled(
        "15",
        bgColor: Get.theme.colorScheme.surfaceVariant.withOpacity(0.5),
        textSize: 14,
        onTap: () {},
      ).paddingBottom(AppSpace.listRow),

      // Text/Fill/Round Button
      ButtonWidget.textRoundFilled(
        "5",
        bgColor: Get.theme.colorScheme.surfaceVariant.withOpacity(0.4),
        borderRadius: 12,
        textSize: 12,
        onTap: () {},
      ).tight(width: 24, height: 24).paddingBottom(AppSpace.listRow),

      // iconTextUpDown, /
      ButtonWidget.iconTextUpDown(
        IconWidget.svg(
          AssetsSvgs.cHomeSvg,
          size: 30,
        ),
        "Home",
        onTap: () {},
      ).paddingBottom(AppSpace.listRow),

      // iconTextOutlined,
      ButtonWidget.iconTextOutlined(
        IconWidget.svg(
          AssetsSvgs.cHomeSvg,
          size: 30,
        ),
        "Home",
        onTap: () {},
      )
          .tight(
            width: 100,
            height: 50,
          )
          .paddingBottom(AppSpace.listRow),

      // iconTextUpDownOutlined,
      ButtonWidget.iconTextUpDownOutlined(
        IconWidget.svg(
          AssetsSvgs.cHomeSvg,
          size: 30,
        ),
        "Home",
        onTap: () {},
      )
          .tight(
            width: 100,
            height: 50,
          )
          .paddingBottom(AppSpace.listRow),

      // textIcon,
      ButtonWidget.textIcon(
        "Home",
        IconWidget.svg(
          AssetsSvgs.cHomeSvg,
          size: 30,
        ),
        onTap: () {},
      ).paddingBottom(AppSpace.listRow),

      //
    ].toColumn();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ButtonsController>(
      init: ButtonsController(),
      id: "buttons",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("buttons")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
