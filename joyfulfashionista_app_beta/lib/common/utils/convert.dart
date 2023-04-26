/// 转换
class Convert {
  // 阿里图片尺寸调整
  static String aliImageResize(
    String url, {
    double width = 300,
    double? maxHeight,
  }) {
    var crop = '';
    int iWidth = width.toInt();
    int? iMaxHeight = maxHeight?.toInt();

    if (maxHeight != null) {
      crop = '/crop,h_$iMaxHeight,g_center';
    }
    return '$url?x-oss-process=image/resize,w_$iWidth,m_lfit$crop';
  }
}
