import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joyfulfashionista_app/common/index.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

String formatDate(String dateStr) {
  DateTime parsedDate = DateTime.parse(dateStr);
  return DateFormat('yyyy-MM-dd').format(parsedDate);
}


/// 订单列表项
class BuildOrderListItem extends StatelessWidget {
  const BuildOrderListItem({Key? key, required this.item}) : super(key: key);

  final OrderModel item;

  // 标签
  Widget _buildTag(String tag) {
    return ButtonWidget.primary(
      tag,
    ).tight(
      width: 100.w,
      height: 32.w,
    );
  }

  // 主视图
  Widget _buildView() {
    return <Widget>[
      // id tag
      <Widget>[
        // 编号
        TextWidget.body1("# ${item.id}").expanded(),

        // 标签tag
        _buildTag(item.status ?? "-"),
      ].toRow().paddingBottom(AppSpace.listRow),

      // orderKey date
      <Widget>[
        // 订单号
        TextWidget.body1("${item.orderKey}").expanded(),

        // 日期
        // 日期
        TextWidget.body2(item.dateCreated != null
            ? formatDate(item.dateCreated!)
            : "N/A"),

        // TextWidget.body2("${item.dateCreated}".dateFormatOfyyyyMMdd),

      ].toRow(),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // delivery notify
          ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.doorbell,size: 14,), label: TextWidget.body2(LocaleKeys.orderDelivery.tr)),
          SizedBox(width: 10.w,),
          // edit address
          ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.edit,size: 14,), label: TextWidget.body2(LocaleKeys.orderAddressEdit.tr)),
        ],
      )
    ].toColumn().paddingAll(AppSpace.card).card();
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
}
