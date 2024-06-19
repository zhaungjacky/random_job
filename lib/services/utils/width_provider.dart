import 'package:flutter/widgets.dart';

class WidthProvider {
  static String widthStr = "width";
  static String heightStr = "height";
  static Map<String, double> setWidthAndHeight(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (width > 1366) {
      width = width * 0.5;
    } else if (width > 960) {
      width *= 0.6;
    } else if (width > 660) {
      width *= 0.7;
    } else {
      width *= 0.8;
    }
    return {
      widthStr: width,
      heightStr: height,
    };
  }
}
