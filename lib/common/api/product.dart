import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../index.dart';
import 'package:http/http.dart' as http;

const List<String> categoryList = Constants.categoryList;


/// 商品 api
class ProductApi {
  late Map<String, List<String>> categoryProducts;

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

  static Future<Map<String, List<ProductModel>>> categorizeProducts() async {

    List<CategoryModel> _categories = await categories();
    List<ProductModel> _products = await getProducts();

    Map<String, List<ProductModel>> categoryProducts = {};

    for (var _ in _categories) {
      categoryProducts[_.name!] = [];
    }

    for (var productModel in _products) {
        for (var category in productModel.categories!) {
          categoryProducts[category]!.add(productModel);
        }
    }
    return categoryProducts;
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

    List<ProductModel> products = [];
    final jsonResponse = json.decode(res.body);
    for (var item in jsonResponse) {
      products.add(ProductModel.fromJson(item));
    }
    return products;
  }

  static Future<List<ProductModel>> getProducts() async {
    String? token = await UserService.to.getToken("tester");
    final res = await http.get(
        Uri.parse(Constants.wpApiBaseUrl + '/wp-json/wc/v3/products/'),
        headers: {
          'Authorization': 'Bearer $token',
        }
    );

    List<ProductModel> products = [];
    final jsonResponse = json.decode(res.body);
    for (var item in jsonResponse) {
      products.add(ProductModel.fromJson(item));
    }
    return products;
  }

  /// 商品详情
  static Future<ProductModel> productDetail(int? id) async {

    String? token = await UserService.to.getToken("tester");
    final res = await http.get(
        Uri.parse(Constants.wpApiBaseUrl + '/wp-json/wc/v3/products/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        }
    );
    final jsonResponse = json.decode(res.body);
    return ProductModel.fromJson(jsonResponse);
  }

  /// 属性列表
  /// id 1 颜色 2 尺寸
  static Future<List<AttributeModel>> attributes(int id) async {

    String? token = await UserService.to.getToken("tester");
    final res = await http.get(
        Uri.parse(Constants.wpApiBaseUrl + '/wp-json/wc/v3/products/attributes/$id/terms'),
        headers: {
          'Authorization': 'Bearer $token',
        }
    );

    final jsonResponse = json.decode(res.body);
    List<AttributeModel> attributes = [];
    for (var item in jsonResponse) {
      attributes.add(AttributeModel.fromJson(item));
    }
    // 排序 menuOrder , 小号在前
    attributes.sort((a, b) => a.menuOrder!.compareTo(b.menuOrder as int));
    return attributes;
  }

  /// 评论列表
  static Future<List<ReviewModel>> reviews(ReviewsReq? req) async {

    String? token = await UserService.to.getToken("tester");
    final res = await http.get(
        Uri.parse(Constants.wpApiBaseUrl + '/wp-json/wc/v3/products/reviews'),
        headers: {
          'Authorization': 'Bearer $token',
        }
    );

    final jsonResponse = json.decode(res.body);
    List<ReviewModel> reviews = [];
    for (var item in jsonResponse) {
      reviews.add(ReviewModel.fromJson(item));
    }
    return reviews;
  }

  /// tags 列表
  static Future<List<TagsModel>> tags(TagsReq? req) async {

    String? token = await UserService.to.getToken("tester");
    final res = await http.get(
        Uri.parse(Constants.wpApiBaseUrl + '/wp-json/wc/v3/products/tags'),
        headers: {
          'Authorization': 'Bearer $token',
        }
    );

    final jsonResponse = json.decode(res.body);
    List<TagsModel> tags = [];
    for (var item in jsonResponse) {
      tags.add(TagsModel.fromJson(item));
    }
    return tags;
  }
}