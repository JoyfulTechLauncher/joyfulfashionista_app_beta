import 'package:flutter/material.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class LoginQuickPage extends GetView<LoginQuickController> {
  const LoginQuickPage({Key? key}) : super(key: key);

  // main view
  Widget _buildView() {
    return <Widget>[
      // logo
      const ImageWidget.asset(
        AssetsImages.logoPng,
        width: 60,
        height: 57,
      ).paddingBottom(22),

      // header 1
      TextWidget.title2(
        "Let’s Sign You In",
        color: AppColors.onPrimary,
      ).paddingBottom(10),

      // header 2
      TextWidget.body2(
        "Welcome back, you’ve",
        color: AppColors.onPrimary,
      ).paddingBottom(55),

      // form
      <Widget>[
        // username
        const TextWidget.body1(
          "Username or E-Mail",
          color: Color(0xff838383),
        ).paddingBottom(AppSpace.listRow),

        // username input
        InputWidget.iconTextFilled(IconWidget.icon(Icons.person))
            .paddingBottom(AppSpace.listRow * 2),

        // password
        const TextWidget.body1(
          "Password",
          color: Color(0xff838383),
        ).paddingBottom(AppSpace.listRow),

        // password input
        InputWidget.iconTextFilled(IconWidget.icon(Icons.lock_outline))
            .paddingBottom(29),

        // login button
        const ButtonWidget.primary(
          "Sıgn In",
          backgroundColor: Color(0xffFD8700),
          borderRadius: 18,
        ).tight(width: double.infinity, height: 57),

        // register
        <Widget>[
          // text
          const TextWidget.body1(
            "Don’t have an account?",
            color: Color(0xff838383),
          ).paddingRight(AppSpace.listItem),

          // register button
          ButtonWidget.text(
            "Sign Up",
            textColor: const Color(0xff0274BC),
            textWeight: FontWeight.bold,
          ),
        ].toRow(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ]
          .toColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
          )
          .paddingAll(20)
          .card(
            color: Colors.white,
            radius: 35,
          ),

      // end
    ]
        .toColumn(
          mainAxisAlignment: MainAxisAlignment.center,
        )
        .paddingHorizontal(15);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginQuickController>(
      init: LoginQuickController(),
      id: "login_quick",
      builder: (_) {
        return Scaffold(
          backgroundColor: const Color(0xff0274BC),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
