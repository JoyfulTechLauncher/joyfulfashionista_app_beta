import 'dart:convert';
import 'dart:io';

import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryController extends GetxController {
  CategoryController();

  // 分类 id , 获取路由传递参数
  int? categoryId = Get.arguments['id'];

  // 分类导航数据
  List<CategoryModel> categoryItems = [];

  // 刷新控制器
  final RefreshController refreshController = RefreshController(
    initialRefresh: false, // 一开始就自动下拉刷新
  );
  // 列表
  List<ProductModel> items = [];
  // 页码
  int _page = 1;
  // 页尺寸
  final int _limit = 20;

  // 拉取数据
  // isRefresh 是否是刷新
  Future<bool> _loadSearch(bool isRefresh) async {
    // 拉取数据
    var result = await ProductApi.products(ProductsReq(
      // 刷新, 重置页数1
      page: isRefresh ? 1 : _page,
      // 每页条数
      prePage: _limit,
      // 分类id
      category: categoryId.toString(),
    ));

    items = await ProductApi.getCategoryProducts(categoryId!);

    // 下拉刷新
    if (isRefresh) {
      _page = 1; // 重置页数1
      items.clear(); // 清空数据
    }

    // 有数据
    if (result.isNotEmpty) {
      // 页数+1
      _page++;
      items.clear(); // 清空数据

      // 添加数据
      items.addAll(result);
    }

    // 是否空
    return result.isEmpty;
  }

  _initData() async {

    var stringCategories = Storage().getString(Constants.storageProductsCategories);
    var stringCategorizedProduct = Storage().getString(Constants.storageCategorizedProduct + categoryId.toString());

    categoryItems = stringCategories != ""
        ? jsonDecode(stringCategories).map<CategoryModel>((item) {
      return CategoryModel.fromJson(item);
    }).toList()
        : [];

    items = stringCategorizedProduct != ""
        ? jsonDecode(stringCategorizedProduct).map<ProductModel>((item) {
      return ProductModel.fromJson(item);
    }).toList()
        : [];

    if (categoryItems.isEmpty) {
      categoryItems = await ProductApi.categories();// 获取分类数据
      Storage().setJson(Constants.storageProductsCategories, categoryItems);
    }
    if (items.isEmpty){
      items = await ProductApi.getCategoryProducts(categoryId!);
    }

    update(["category", "product_list"]);
  }

  // 分类点击事件
  void onCategoryTap(int id) async {

    refreshController.requestRefresh();
    categoryId = id;

    var stringCategorizedProduct = Storage().getString(Constants.storageCategorizedProduct + categoryId.toString());
    items = stringCategorizedProduct != ""
        ? jsonDecode(stringCategorizedProduct).map<ProductModel>((item) {
      return ProductModel.fromJson(item);
    }).toList()
        : [];

    if (items.isEmpty){
      items = await ProductApi.getCategoryProducts(categoryId!);
    }

    update(["left_nav", "product_list"]);

  }

  // 分类更新
  void onCategoryUpdate() async {

    if (categoryItems.isEmpty) {
      categoryItems = await ProductApi.categories();// 获取分类数据
    }
    update(["left_nav"]);
  }

  // 上拉载入新商品
  void onLoading() async {
    if (items.isNotEmpty) {
      try {
        // 拉取数据是否为空
        var isEmpty = await _loadSearch(false);
        if (isEmpty) {
          // 设置无数据
          refreshController.loadNoData();
        } else {
          // 加载完成
          refreshController.loadComplete();
        }
      } catch (e) {
        // 加载失败
        refreshController.loadFailed();
      }
    } else {
      // 设置无数据
      refreshController.loadNoData();
    }
  }

  // 下拉刷新
  void onRefresh() async {
    try {
      await _loadSearch(true);
      refreshController.refreshCompleted();
    } catch (error) {
      // 刷新失败
      refreshController.refreshFailed();
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();
    // 刷新控制器释放
    refreshController.dispose();
  }
}
