import 'dart:math';

import 'package:flutter/material.dart';

import 'rpx.dart';

class AtToast {
  static BuildContext _context;
  static int _id = 0;

  static Future show(
    String content, {
    BuildContext context,
    int duration = 2000,
  }) {
    assert(content != '' && duration >= 2000);

    // 如果当前有toast，先关闭
    if (_context != null) {
      hide();
    }

    // 保存当前上下文句柄
    _context = context;

    return _showToast(
      context: context,
      duration: duration,
      builder: (BuildContext context) => _Toast(content: content),
    );
  }

  static hide() {
    if (_context != null && Navigator.of(_context).canPop()) {
      Navigator.of(_context).pop();
      _context = null;
    }
  }
}

class _Toast extends Dialog {
  final String content;

  _Toast({
    this.content = '',
  }) : assert(content != '');

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: r.px(36),
                horizontal: r.px(40),
              ),
              constraints: BoxConstraints(
                maxWidth: r.px(580),
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(r.px(4)),
              ),
              child: Text(
                content,
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GestureDetector(
            onTapDown: (_) => AtToast.hide(),
            child: Container(color: Colors.transparent),
          ),
        ],
      ),
    );
  }
}

Future<T> _showToast<T>({
  @required BuildContext context,
  int duration = 2000,
  @required WidgetBuilder builder,
}) {
  assert(duration >= 2000);
  assert(debugCheckHasMaterialLocalizations(context));

  // 每次生成一个不同的toast id
  AtToast._id++;
  if (AtToast._id > 100000) {
    AtToast._id = 1;
  }
  int _id = AtToast._id;

  Future.delayed(Duration(milliseconds: duration), () {
    if (_id == AtToast._id) {
      AtToast.hide();
    }
  });

  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
      return SafeArea(
        child: Builder(builder: (BuildContext context) => Builder(builder: builder)),
      );
    },
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 200),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  Animation _a = CurveTween(curve: Curves.fastOutSlowIn).animate(animation);
  return ScaleTransition(
    scale: Tween(begin: 0.9, end: 1.0).animate(_a),
    child: Opacity(
      opacity: max(_a.value * 1.5 - 0.5, 0),
      child: child,
    ),
  );
}
