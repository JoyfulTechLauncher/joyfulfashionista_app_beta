import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

// 视频配置，秒
const videoDurationMin = 6;
const videoDurationMax = 900;

/// picker 选取器
class ActionPicker {
  /// 选取器 array , 多列
  static Picker array({
    required PickerAdapter adapter,
    List<int>? selecteds,
  }) {
    return Picker(
      /// 数据项高度
      itemExtent: 40,

      /// 选取器高度
      height: 270,

      /// 背景色
      backgroundColor: Colors.transparent,

      /// 容器颜色
      containerColor: Colors.transparent,

      /// 头部栏位隐藏
      hideHeader: true,

      /// 文字样式
      textStyle: TextStyle(
        fontSize: 18,
        height: 1.2,
        color: AppColors.secondary,
        // color: AppColors.,
      ),

      /// 数据适配器
      adapter: adapter,

      /// 选中项 [index]
      selecteds: selecteds,
    );
  }

  /// 相册 assets 权限
  static Future<PrivilegeStatus> assetsPrivilege(BuildContext context) async {
    var privilege = await Privilege.photos();
    if (!privilege.result) {
      await ActionDialog.normal(
        context: context,
        content: Text(privilege.message),
        confirm: const Text('Setting'),
        cancel: const Text('Not allowed'),
        onConfirm: () => Privilege.openSettings(),
      );
      return PrivilegeStatus(result: false, message: "");
    }
    return privilege;
  }

  /// 相册 assets 权限
  static Future<List<AssetEntity>?> assets({
    required BuildContext context,
    List<AssetEntity>? selected,
    RequestType type = RequestType.image,
    int maxAssets = 9,
    SpecialPickerType? specialPickerType,
    Widget? Function(BuildContext, AssetPathEntity?, int)? specialItemBuilder,
    SpecialItemPosition specialItemPosition = SpecialItemPosition.none,
  }) async {
    var result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        selectedAssets: selected,
        requestType: type,
        maxAssets: maxAssets,
        themeColor: AppColors.surfaceVariant,
        specialPickerType: specialPickerType,
        filterOptions: FilterOptionGroup(
          orders: [const OrderOption(type: OrderOptionType.createDate)],
          videoOption: const FilterOption(
            durationConstraint: DurationConstraint(
              min: Duration(seconds: videoDurationMin),
              max: Duration(seconds: videoDurationMax),
            ),
          ),
        ),
        specialItemPosition: specialItemPosition,
        specialItemBuilder: specialItemBuilder,
      ),
    );
    return result;
  }

  /// 相机 权限
  static Future<PrivilegeStatus> cameraPrivilege(BuildContext context) async {
    var privilege = await Privilege.camera();
    if (!privilege.result) {
      await ActionDialog.normal(
        context: context,
        content: Text(privilege.message),
        confirm: const Text('Setting'),
        cancel: const Text('Not allowed'),
        onConfirm: () => Privilege.openSettings(),
      );
      return PrivilegeStatus(result: false, message: "");
    }
    return privilege;
  }

  /// 相机
  static Future<AssetEntity?> camera({
    required BuildContext context,
    bool enableRecording = true,
  }) async {
    var result = await CameraPicker.pickFromCamera(
      context,
      pickerConfig: CameraPickerConfig(
        enableRecording: enableRecording,
        enableAudio: enableRecording,
        textDelegate:
            enableRecording ? const EnglishCameraPickerTextDelegate() : null,
        resolutionPreset: ResolutionPreset.veryHigh,
      ),
    );
    return result;
  }
}
