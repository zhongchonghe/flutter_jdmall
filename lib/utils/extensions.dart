import 'package:flutter/cupertino.dart';

import '../service/config.dart';

// 转换图片路径中双反斜杠'\\'为'/'
extension HandleUrl on String {
  String get toURL {
    return Config.baseURL + replaceAll('\\', '/');
  }
}

// 颜色 hex字符串转16进制
// 使用 "#ffffff".toColor 或 "ffffff".toColor
extension ColorFormat on String {
  Color get toColor {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

// 防止文字中英文换行
extension FixAutoLines on String {
  String get fixAutoLines {
    return Characters(this).join("\u{200B}");
  }
}
