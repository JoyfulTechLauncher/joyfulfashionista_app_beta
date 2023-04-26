import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joyfulfashionista_app/common/i18n/index.dart';

import 'index.dart';

class MsgIndexPage extends GetView<MsgIndexController> {
  const MsgIndexPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text(LocaleKeys.noMessage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MsgIndexController>(
      init: MsgIndexController(),
      id: LocaleKeys.messagePage,
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.messagePage.tr)),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
