/// 订单查询请求
class OrdersReq {
  final int? page;
  final int? prePage;
  final String? consumerKey;
  final String? consumerSecret;
  final int? customer;

  OrdersReq({
    this.page,
    this.prePage,
    this.consumerKey,
    this.consumerSecret,
    this.customer,
  });

  Map<String, dynamic> toJson() => {
    'page': page ?? 1,
    'pre_page': prePage ?? 10,
    if (consumerKey != null) 'consumer_key': consumerKey,
    if (consumerSecret != null) 'consumer_secret': consumerSecret,
    if (customer != null) 'customer': customer,
  };
}

