/// 常量
class Constants {
  // wp Server address (Testing)
  static const wpApiBaseUrl = 'https://teamjoyful.buzz';
  static const wcEndpointBaseUrl = '/wp-json/wc/v3';
  static const jwtEndpointUrl = '/jwt-auth/v1/token';

  // 本地存储key
  static const storageLanguageCode = 'language_code';
  static const storageThemeCode = 'theme_code';
  static const storageFirstOpen = 'first_open'; // 首次打开
  static const storageToken = 'token'; // 登录成功后 token
  static const storageProfile = 'profile'; // 用户资料缓存

  // AES
  static const aesKey = 'aH5aH5bG0dC6aA3oN0cK4aU5jU6aK2lN';
  static const aesIV = 'hK6eB4aE1aF3gH5q';

  // key&secret (Testing)
  static const consumer_key = 'ck_b6edf8ca8492e34cbcec6cf3579a5e55745d9b8d';
  static const consumer_secret = 'cs_1fcc12c1ff0aefe208147731cb51925744e089c2';
  
  // 基础数据
  // 商品分类
  static const storageProductsCategories = 'home_categories';
  // 颜色定义
  static const storageProductsAttributesColors = 'products_attributes_colors';
  // 尺寸定义
  static const storageProductsAttributesSizes = 'products_attributes_sizes';
  // 品牌
  static const storageProductsAttributesBrand = 'products_attributes_brand';
  // 性别
  static const storageProductsAttributesGender = 'products_attributes_gender';
  // 新旧
  static const storageProductsAttributesCondition =
      'products_attributes_condition';

  // 首页离线
  static const storageHomeBanner = 'home_banner';
  static const storageHomeCategories = 'home_categories';
  static const storageHomeFlashSell = 'home_flash_sell';
  static const storageHomeNewSell = 'home_new_sell';
}
