import 'package:flutter/material.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class ImagePage extends GetView<ImageController> {
  const ImagePage({Key? key}) : super(key: key);

  // main
  Widget _buildView() {
    return ListView(
      children: const [
        ListTile(
          leading: ImageWidget.url(
              "https://scontent.fcbr2-1.fna.fbcdn.net/v/t39.30808-6/305566231_502672698532270_62980227276076846_n.png?_nc_cat=105&ccb=1-7&_nc_sid=e3f864&_nc_ohc=7rnJZPHjk4IAX-olANA&_nc_ht=scontent.fcbr2-1.fna&oh=00_AT_Uye7N4_vYe1h_sksc1abdLKeJEqgVTJRngzIl7nRPFw&oe=634B9E31"),
          title: TextWidget.body1("ImageWidget.url"),
        ),
        ListTile(
          leading: ImageWidget.asset(AssetsImages.pPaypalPng),
          title: TextWidget.body1("ImageWidget.asset"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageController>(
      init: ImageController(),
      id: "image",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("image")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
