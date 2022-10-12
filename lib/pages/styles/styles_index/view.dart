import 'package:flutter/material.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class StylesIndexPage extends GetView<StylesIndexController> {
  const StylesIndexPage({Key? key}) : super(key: key);

  // main view
  Widget _buildView() {
    return Column(children: [
      // text
      /*ListTile(
      onTap: () => Get.toNamed(RouteNames.stylesText),
      title: const Text("Text"),
    ),

     Icon 
    ListTile(
      onTap: () => Get.toNamed(RouteNames.stylesIcon),
      title: const TextWidget.body1("Icon"),
    ),

    // Image 
    ListTile(
      onTap: () => Get.toNamed(RouteNames.stylesImage),
      title: const TextWidget.body1("Image"),
    ),

    // Button 
    ListTile(
      onTap: () => Get.toNamed(RouteNames.stylesButtons),
      title: const TextWidget.body1("Button 按钮"),
    ),

    // Input 
    ListTile(
      onTap: () => Get.toNamed(RouteNames.stylesInputs),
      title: const TextWidget.body1("Input 输入框"),
    ),

    // form 
    ListTile(
      onTap: () => Get.toNamed(RouteNames.stylesTextForm),
      title: const TextWidget.body1("form 表单"),
    ),

     */

      ////////////////////////////////////////

      // language
      ListTile(
        onTap: controller.onLanguageSelected,
        title: Text(
          "Language : ${ConfigService.to.locale.toLanguageTag()}",
        ),
      ),

      // theme style
      ListTile(
        onTap: controller.onThemeSelected,
        title:
            Text("Theme : ${ConfigService.to.isDarkModel ? "Dark" : "Light"}"),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StylesIndexController>(
      init: StylesIndexController(),
      id: "styles_index",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.stylesTitle.tr)),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
