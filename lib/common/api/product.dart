import 'dart:convert';

import '../index.dart';
import 'package:http/http.dart' as http;

/// 商品 api
class ProductApi {
  static List<String> categoryList = ['Man', 'Woman', 'Children', 'Inclusive', 'Accessories', 'Shipping', 'Popular'];
  /// 分类列表
  static Future<List<CategoryModel>> categories() async {
    String? token = await UserService.to.getToken("tester");
    final res = await http.get(
        Uri.parse(Constants.wpApiBaseUrl + '/wp-json/wc/v3/products/categories'),
        headers: {
          'Authorization': 'Bearer $token',
        }
    );

    final jsonResponse = json.decode(res.body);
    List<CategoryModel> _categories = [];

    // store correct categories
    for (var item in jsonResponse) {
      CategoryModel serializedItem = CategoryModel.fromJson(item);
      if (categoryList.contains(serializedItem.name)) {
        _categories.add(serializedItem);
      }
    }
    // order categories according to `categoryList`
    List<CategoryModel> categories = [];
    for (var categoryName in categoryList) {
      var category = _categories.firstWhere((cat) => cat.name == categoryName);
      categories.add(category);
    }
    // transform category names to Chinese
    if(ConfigService.to.locale.toLanguageTag() != "en-US") {
      categories[0].name = "男性";
      categories[1].name = "女性";
      categories[2].name = "儿童";
      categories[3].name = "包容性服装";
      // categories[4].name = "海魂衫";
      categories[4].name = "配饰";
      categories[5].name = "流行";
      categories[6].name = "更多";
    }

    return categories;
  }

  /// 商品列表
  static Future<List<ProductModel>> products(ProductsReq? req) async {
    String? token = await UserService.to.getToken("tester");
    final res = await http.get(
        Uri.parse(Constants.wpApiBaseUrl + '/wp-json/wc/v3/products/'),
        headers: {
          'Authorization': 'Bearer $token',
        }
    );
    // var res = await WPHttpService.to.get(
    //     '/wp-json/wc/v3/products',
    //     params: req?.toJson(),
    // );

    List<ProductModel> products = [];
    final jsonResponse = json.decode(res.body);
    for (var item in jsonResponse) {
      products.add(ProductModel.fromJson(item));
    }
    return products;
  }

  /// 商品详情
  static Future<ProductModel> productDetail(int? id) async {
    var res = await WPHttpService.to.get(
      '/wp-json/wc/v3/products$id',
    );
    return ProductModel.fromJson(res.data);
  }

  /// 属性列表
  /// id 1 颜色 2 尺寸
  static Future<List<AttributeModel>> attributes(int id) async {
    var res = await WPHttpService.to.get(
      '/products/attributes/$id/terms',
    );

    List<AttributeModel> attributes = [];
    for (var item in res.data) {
      attributes.add(AttributeModel.fromJson(item));
    }
    // 排序 menuOrder , 小号在前
    attributes.sort((a, b) => a.menuOrder!.compareTo(b.menuOrder as int));
    return attributes;
  }

  /// 评论列表
  static Future<List<ReviewModel>> reviews(ReviewsReq? req) async {
    var res = await WPHttpService.to.get(
      '/products/reviews',
      params: req?.toJson(),
    );

    List<ReviewModel> reviews = [];
    for (var item in res.data) {
      reviews.add(ReviewModel.fromJson(item));
    }
    return reviews;
  }

  /// tags 列表
  static Future<List<TagsModel>> tags(TagsReq? req) async {
    var res = await WPHttpService.to.get(
      '/products/tags',
      params: req?.toJson(),
    );

    List<TagsModel> tags = [];
    for (var item in res.data) {
      tags.add(TagsModel.fromJson(item));
    }
    return tags;
  }
}
