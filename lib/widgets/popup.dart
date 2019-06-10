import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'rpx.dart';
import 'colors.dart';

class AtPopup {
  static List<BuildContext> _contexts = [];

  static Future show({
    @required BuildContext context,
    @required Widget child,
    double height,
    EdgeInsetsGeometry padding,
    bool barrierDismissible = false,
  }) {
    // 保存当前上下文句柄
    _contexts.add(context);

    return _showPopup(
      context: context,
      builder: (BuildContext context) {
        return _Popup(
          child: child,
          height: height,
          padding: padding,
          barrierDismissible: barrierDismissible,
        );
      },
    );
  }

  static hide() {
    if (_contexts.isEmpty) {
      return;
    }
    BuildContext _context = _contexts[_contexts.length - 1];
    if (_context != null && Navigator.of(_context).canPop()) {
      Navigator.of(_context).pop();
      _contexts.remove(_context);
      _context = null;
    }
  }
}

class _Popup extends Dialog {
  final Widget child;
  final double height;
  final EdgeInsetsGeometry padding;
  final bool barrierDismissible;

  _Popup({
    @required this.child,
    this.height,
    this.padding,
    this.barrierDismissible = false,
  });

  @override
  Widget build(BuildContext context) {
    // 背景
    Widget _bg = Container(color: Colors.transparent);
    if (barrierDismissible) {
      _bg = GestureDetector(
        onTap: AtPopup.hide,
        child: _bg,
      );
    }

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: <Widget>[
          _bg,
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: height,
              padding: padding,
              color: Colors.white,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

Future<T> _showPopup<T>({
  @required BuildContext context,
  Widget child,
  WidgetBuilder builder,
}) {
  assert(child == null || builder == null);
  assert(debugCheckHasMaterialLocalizations(context));
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
      final Widget pageChild = child ?? Builder(builder: builder);
      return Builder(builder: (BuildContext context) => pageChild);
    },
    barrierDismissible: false,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: AtColors.maskColor,
    transitionDuration: const Duration(milliseconds: 350),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  Rpx r = Rpx.init(context);

  double _v = CurveTween(curve: Curves.fastOutSlowIn).animate(animation).value;
  return Transform.translate(
    offset: Offset(0, (1 - _v) * r.vh()),
    child: child,
  );
}
