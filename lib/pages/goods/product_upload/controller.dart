import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:joyfulfashionista_app/common/index.dart';

class ProductUploadController extends GetxController {
  ProductUploadController();

  // form
  GlobalKey formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController tagController = TextEditingController();

  // images
  List<File> images = [];

  // tags
  List<String> tags = [];

  // 本机图片file
  File? filePhoto;

  _initData() {
    update(["product_upload"]);
  }

  // 选取照片
  void onSelectPhoto() {
    if (images.length >= 5) {
      Loading.error(LocaleKeys.gProductUploadImagesExceedError.trParams({
        "size": "5",
      }));
      return;
    }
    ActionBottomSheet.popModal(
      context: Get.context,
      child: PickerImageWidget(
        // 拍照
        onTapTake: (AssetEntity? result) async {
          if (result != null) {
            filePhoto = await result.file;
            if (filePhoto != null) {
              images.add(filePhoto!);
            }
            update(["product_upload"]);
          }
        },
        // 相册
        onTapAlbum: (List<AssetEntity>? result) async {
          if (result != null && result.isNotEmpty) {
            filePhoto = await result.first.file;
            if (filePhoto != null) {
              images.add(filePhoto!);
            }
            update(["product_upload"]);
          }
        },
      ),
    );
  }

  // 保存
  Future<void> onSave() async {
    if ((formKey.currentState as FormState).validate()) {
      // validate images
      if (images.isEmpty) {
        Loading.error(LocaleKeys.gProductUploadImagesEmptyError.tr);
        return;
      } else if (images.length > 5) {
        Loading.error(LocaleKeys.gProductUploadImagesExceedError.trParams({
          "size": "5",
        }));
        return;
      }
      // validate tags
      if (tags.isEmpty) {
        Loading.error(LocaleKeys.gProductUploadTagsEmptyError.tr);
        return;
      }



      UserApi.uploadProduct(images, titleController.toString(), descriptionController.toString());
      // 提交
      // UserProfileModel profile = await UserApi.saveBaseInfo(UserProfileModel(
      //   firstName: titleController.text,
      //   lastName: descriptionController.text,
      //   email: emailController.text,
      // ));

      // 更新本地
      // UserService.to.setProfile(profile);
      Loading.success();

      resetFrom();
    }
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();
    titleController.dispose();
    descriptionController.dispose();
    sizeController.dispose();
    tagController.dispose();
  }

  void onAddTag() {
    // check tag exists
    if (tags.contains(tagController.text.trim())) {
      Loading.error(LocaleKeys.gProductUploadTagExists.tr);
      return;
    }
    tags.add(tagController.text.trim());
    tagController.text = "";
    update(["product_upload"]);
  }

  void onRemoveTag(String tag) {
    tags.remove(tag);
    update(["product_upload"]);
  }

  void onRemoveImage(File image) {
    images.remove(image);
    update(["product_upload"]);
  }

  // reset form
  void resetFrom() {
    titleController.text = "";
    descriptionController.text = "";
    sizeController.text = "";
    tagController.text = "";
    images.clear();
    tags.clear();
    update(["product_upload"]);
  }
}
