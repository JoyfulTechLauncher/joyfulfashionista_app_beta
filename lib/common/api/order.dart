import '../index.dart';

// 订单
class OrderApi {
  /// 创建订单
  static Future<OrderModel> crateOrder({
    // 商品列表
    required List<LineItem> lineItem,
    // 优惠券列表
    required List<CouponsModel> lineCoupons,
  }) async {
    var data = {
      // 商品列表
      "line_items": lineItem
          .map((e) => {"product_id": e.productId!, "quantity": e.quantity!})
          .toList(),

      // 优惠券
      "coupon_lines": lineCoupons.map((e) => {"code": e.code!}).toList(),

      // 账单地址
      "billing": UserService.to.profile.billing!.toJson(),

      // 送货地址
      "shipping": UserService.to.profile.shipping!.toJson(),
    };
    var res = await WPHttpService.to.post(
      '/orders',
      data: data,
    );
    return OrderModel.fromJson(res.data);
  }

  /// 订单列表
  static Future<List<OrderModel>> orders(OrdersReq req) async {
    List<OrderModel> orders = [];

    try {
      var res = await WPHttpService.to.get(
        '/wp-json/wc/v3/orders',
        params: req.toJson(),
      );


      var ordersData = res.data;

      // Check if 'orders' key exists and is a List
      if (ordersData is List) {
        for (var item in ordersData) {
          if (item is Map<String, dynamic>) {
            orders.add(OrderModel.fromJson(item));
          } else {
            // Handle the case where an item is not a Map<String, dynamic>
            print('Unexpected item format: $item');
          }
        }
      } else {
        // Handle the case where 'orders' key is missing or its value is not a List
        print('Unexpected response format for orders: $ordersData');
      }
    } catch (e) {
      // 输出错误信息
      print('Error fetching orders: $e');
    }

    return orders;
  }

}
