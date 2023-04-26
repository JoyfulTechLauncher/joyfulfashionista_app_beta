import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class RegisterPinPage extends GetView<RegisterPinController> {
  const RegisterPinPage({Key? key}) : super(key: key);
  // form page
  Widget _buildForm() {
    return Form(
      key: controller.formKey, //Set globalKey to get FormState later
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: <Widget>[
        // tips
        TextWidget.body1(LocaleKeys.registerPinFormTip.tr)
            .paddingBottom(20.w)
            .alignLeft(),

        // pin
        PinPutWidget(
          controller: controller.pinController,
          validator: controller.pinValidator, // 验证函数
          onSubmit: controller.onPinSubmit,
        ).paddingBottom(50.w),

        // submit button
        ButtonWidget.primary(
          LocaleKeys.registerPinButton.tr,
          onTap: controller.onBtnSubmit,
        ).paddingBottom(AppSpace.listRow),

        // return button
        ButtonWidget.text(
          LocaleKeys.commonBottomCancel.tr,
          onTap: controller.onBtnBackup,
        ),

        // end
      ].toColumn(),
    ).paddingAll(AppSpace.card);
  }

  // main view
  Widget _buildView() {
    return SingleChildScrollView(
      child: <Widget>[
        // header
        PageTitleWidget(
          title: LocaleKeys.registerPinTitle.tr,
          desc: LocaleKeys.registerPinDesc.tr,
        ),

        // form
        _buildForm().card(),
      ]
          .toColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
          )
          .paddingHorizontal(AppSpace.page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPinController>(
      init: RegisterPinController(),
      id: "register_pin",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("register_pin")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
