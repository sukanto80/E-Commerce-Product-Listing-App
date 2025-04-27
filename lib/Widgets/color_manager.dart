import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  // Convert hex string to Color
  static Color fromHex(String hexCode) {
    final buffer = StringBuffer();
    if (hexCode.length == 6 || hexCode.length == 7) buffer.write('ff'); // add opacity if not provided
    buffer.write(hexCode.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
