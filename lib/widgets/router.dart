import 'package:flutter/material.dart';

class AtRouter {
  static Future push<T extends Object>(BuildContext context, Widget page) {
    return Navigator.push<T>(context, MaterialPageRoute(builder: (context) => page));
  }

  static bool pop<T extends Object>(BuildContext context, [T result]) {
    return Navigator.pop<T>(context, result);
  }

  static bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }
}
