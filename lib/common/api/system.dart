import '../index.dart';

/// 系统 api
class SystemApi {
  /// Banner Ads
  static Future<List<KeyValueModel>> banners() async {
    List<KeyValueModel> bannerItems = [
      KeyValueModel(
          key: "01",
          value:
              "https://the-riotact.com/wp-content/uploads/2021/10/2021-10-13_13-23-35-810x406.jpg"),
      KeyValueModel(
          key: "02",
          value:
              "https://joyfulfashionista.com.au/wp-content/uploads/2021/12/yz-pTJ0U-scaled-300x148.jpeg"),
      KeyValueModel(
          key: "03",
          value:
              "https://scontent.fcbr2-1.fna.fbcdn.net/v/t39.30808-6/305566231_502672698532270_62980227276076846_n.png?_nc_cat=105&ccb=1-7&_nc_sid=e3f864&_nc_ohc=7rnJZPHjk4IAX-olANA&_nc_ht=scontent.fcbr2-1.fna&oh=00_AT_Uye7N4_vYe1h_sksc1abdLKeJEqgVTJRngzIl7nRPFw&oe=634B9E31"),
    ];

    return bannerItems;
  }
}
