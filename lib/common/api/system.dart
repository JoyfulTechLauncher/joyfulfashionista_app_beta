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
              "https://joyfulfashionista.com.au/wp-content/uploads/2021/12/yz-pTJ0U-scaled-300x148.jpeg"),
      KeyValueModel(
          key: "03",
          value:
              "https://s3.bmp.ovh/imgs/2023/10/01/61760a8c86efe889.png"),
    ];

    return bannerItems;
  }
}
