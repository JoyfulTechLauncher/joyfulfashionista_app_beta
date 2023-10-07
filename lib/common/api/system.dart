import '../index.dart';

/// 系统 api
class SystemApi {
  /// Banner Ads
  static Future<List<KeyValueModel>> banners() async {
    List<KeyValueModel> bannerItems = [
      KeyValueModel(
          key: "01",
          value:
              "https://s3.bmp.ovh/imgs/2023/10/01/3203a9f96f7abf7c.png"),
      KeyValueModel(
          key: "02",
          value:
              "https://s3.bmp.ovh/imgs/2023/10/01/61760a8c86efe889.png"),
      KeyValueModel(
          key: "03",
          value:
              "https://s3.bmp.ovh/imgs/2023/10/07/58db8c2a5d3c272e.png"),
    ];

    return bannerItems;
  }
}
