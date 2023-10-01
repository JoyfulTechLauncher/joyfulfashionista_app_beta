import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';
import 'package:joyfulfashionista_app/common/widgets/tag.dart';
import 'package:validatorless/validatorless.dart';

import 'index.dart';

class ProductUploadPage extends GetView<ProductUploadController> {
  const ProductUploadPage({Key? key}) : super(key: key);

  //  product 表单
  Widget _buildUploadForm() {
    FormFieldValidator<String> tagValidator = Validatorless.multiple([
      Validatorless.required("The field is obligatory"),
      Validatorless.min(
          1, "Length cannot be less than @size".trParams({"size": "1"})),
      Validatorless.max(
          10, "Length cannot be greater than @size".trParams({"size": "10"})),
    ]);
    return <Widget>[
      // images
      Row(
        children: [
          Text("*${LocaleKeys.gProductUploadImages.tr}"),
        ],
      ).marginOnly(bottom: AppSpace.listRow),
      Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: AppSpace.listView,
          runSpacing: AppSpace.listView,
          children: () {
            List<Widget> children = [];
            List<Widget> images = controller.images.map((e) {
              return Stack(
                children: [
                  ImageWidget.file(
                    e.path,
                    width: 100.w,
                    height: 100.w,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () {
                        controller.onRemoveImage(e);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList();
            if (images.isNotEmpty) {
              children.addAll(images);
            }
            children.add(ElevatedButton(
              onPressed: () {
                controller.onSelectPhoto();
              },
              child: Icon(Icons.add_a_photo),
            ).marginOnly(left: AppSpace.listRow));
            return children;
          }(),
        ),
      ).marginOnly(bottom: AppSpace.listRow),

      // title
      TextFormWidget(
        controller: controller.titleController,
        decoration: InputDecoration(
          labelText: '*${LocaleKeys.gProductUploadTitle.tr}',
          hintText: LocaleKeys.gProductUploadTitleHint.tr,
        ),
        validator: Validatorless.multiple([
          Validatorless.required("The field is obligatory"),
          Validatorless.min(
              1, "Length cannot be less than @size".trParams({"size": "1"})),
          Validatorless.max(18,
              "Length cannot be greater than @size".trParams({"size": "18"})),
        ]),
      ).marginOnly(bottom: AppSpace.listRow),

      // price
      TextFormWidget(
        controller: controller.priceController,
        decoration: InputDecoration(
          labelText: '*${LocaleKeys.gProductUploadPrice.tr}',
          hintText: LocaleKeys.gProductUploadPriceHint.tr,
        ),
        validator: Validatorless.multiple([
          Validatorless.required("The field is obligatory"),
          Validatorless.min(
              1, "Length cannot be less than @size".trParams({"size": "1"})),
          Validatorless.max(18,
              "Length cannot be greater than @size".trParams({"size": "18"})),
        ]),
      ).marginOnly(bottom: AppSpace.listRow),

      // size
      TextFormWidget(
        controller: controller.sizeController,
        decoration: InputDecoration(
          labelText: '*${LocaleKeys.gProductUploadSize.tr}',
          hintText: LocaleKeys.gProductUploadSizeHint.tr,
        ),
        validator: Validatorless.multiple([
          Validatorless.required("The field is obligatory"),
          Validatorless.min(
              1, "Length cannot be less than @size".trParams({"size": "1"})),
          Validatorless.max(18,
              "Length cannot be greater than @size".trParams({"size": "18"})),
        ]),
      ).marginOnly(bottom: AppSpace.listRow),




      // colour
      TextFormWidget(
        controller: controller.colourController,
        decoration: InputDecoration(
          labelText: '*${LocaleKeys.gProductUploadColour.tr}',
          hintText: LocaleKeys.gProductUploadColourHint.tr,
        ),
        validator: Validatorless.multiple([
          Validatorless.required("The field is obligatory"),
          Validatorless.min(
              1, "Length cannot be less than @size".trParams({"size": "1"})),
          Validatorless.max(18,
              "Length cannot be greater than @size".trParams({"size": "18"})),
        ]),
      ).marginOnly(bottom: AppSpace.listRow),

      
      // description
      TextFormWidget(
        controller: controller.descriptionController,
        minLines: 5,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: '*${LocaleKeys.gProductUploadDescription.tr}',
          // border: OutlineInputBorder(),
          hintText: LocaleKeys.gProductUploadDescriptionHint.tr,
          alignLabelWithHint: true,
        ),
        validator: Validatorless.multiple([
          Validatorless.required("The field is obligatory"),
          Validatorless.min(
              10, "Length cannot be less than @size".trParams({"size": "10"})),
          Validatorless.max(150,
              "Length cannot be greater than @size".trParams({"size": "150"})),
        ]),
      ).marginOnly(bottom: AppSpace.listRow),



      // tags
      Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: AppSpace.listView,
          runSpacing: AppSpace.listView,
          children: () {
            List<Widget> children = [];
            List<Widget> tags = controller.tags
                .map((e) => TagWidget(
                      tag: e,
                      closeable: true,
                      onClose: () {
                        controller.onRemoveTag(e);
                      },
                    ))
                .toList();
            if(tags.isNotEmpty) {
              children.add(Text("Tags: "));
            }
            children.addAll(tags);
            return tags.isEmpty ? [Text("No Tags")] : children;
          }(),
        ).marginOnly(bottom: AppSpace.listRow),
      ),

      // tag
      TextFormWidget(
        controller: controller.tagController,
        decoration: InputDecoration(
          labelText: '*${LocaleKeys.gProductUploadTag.tr}',
          hintText: LocaleKeys.gProductUploadTagHint.tr,
          suffixIcon: IconButton(
            icon: Icon(Icons.add_circle_rounded),
            onPressed: () {
              if (tagValidator.call(controller.tagController.text.trim()) ==
                  null) {
                controller.onAddTag();
              }
            },
          ),
        ),
        // validator: tagValidator,
      ).paddingBottom(AppSpace.listRow),

      // end
    ].toColumn().paddingAll(AppSpace.card).card().paddingBottom(AppSpace.card);
  }

  // 主视图
  Widget _buildView() {
    return SingleChildScrollView(
      child: <Widget>[
        // 头像
        // _buildProductImages(),
        // 表单
        Form(
          key: controller.formKey, //设置globalKey，用于后面获取FormState
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: <Widget>[
            _buildUploadForm(),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        ).paddingBottom(AppSpace.card),

        // 上传按钮
        ButtonWidget.primary(
          LocaleKeys.commonBottomUpload.tr,
          onTap: controller.onSave,
          height: AppSpace.buttonHeight,
        ).paddingHorizontal(AppSpace.page),
      ].toColumn().padding(
            top: 45.h,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductUploadController>(
      init: ProductUploadController(),
      id: "product_upload",
      builder: (_) {
        return Scaffold(
          appBar: mainAppBarWidget(titleString: LocaleKeys.gProductUpload.tr),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
