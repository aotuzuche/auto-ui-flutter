import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'rpx.dart';
import 'colors.dart';

class AtDialog {
  static List<BuildContext> _contexts = [];

  static Future show({
    @required BuildContext context,
    @required Widget child,
    double width,
    double height,
    EdgeInsetsGeometry padding,
    bool barrierDismissible = false,
  }) {
    // 保存当前上下文句柄
    _contexts.add(context);

    return _showDialog(
      context: context,
      builder: (BuildContext context) {
        return _Dialog(
          child: child,
          width: width,
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

class _Dialog extends Dialog {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final bool barrierDismissible;

  _Dialog({
    @required this.child,
    this.width,
    this.height,
    this.padding,
    this.barrierDismissible = false,
  });

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    // 背景
    Widget _bg = Container(color: Colors.transparent);
    if (barrierDismissible) {
      _bg = GestureDetector(
        onTap: AtDialog.hide,
        child: _bg,
      );
    }

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: <Widget>[
          _bg,
          Center(
            child: Container(
              width: width ?? r.px(580),
              height: height,
              padding: padding,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(r.px(8)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 20,
                    offset: Offset(0, 10),
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

Future<T> _showDialog<T>({
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
      return SafeArea(
        child: Builder(builder: (BuildContext context) => pageChild),
      );
    },
    barrierDismissible: false,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: AtColors.maskColor,
    transitionDuration: const Duration(milliseconds: 200),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  Animation _a = CurveTween(curve: Curves.fastOutSlowIn).animate(animation);
  return ScaleTransition(
    scale: Tween(begin: 0.95, end: 1.0).animate(_a),
    child: Opacity(
      opacity: max(_a.value * 1.5 - 0.5, 0),
      child: child,
    ),
  );
}
