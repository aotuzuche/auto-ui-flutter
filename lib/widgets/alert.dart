import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'rpx.dart';
import 'colors.dart';
import 'button.dart';
import 'enums.dart';

class AtAlert {
  static List<BuildContext> _contexts = [];

  static Future show({
    // 上下文context
    @required BuildContext context,

    // 标题
    String title,

    // 内容文字
    String content = '',

    // child widget, 用于自定义内容，权重不及content
    Widget child,

    // content的对齐方式
    TextAlign contentTextAlign = TextAlign.center,

    // 取消按钮的文字内容，定义按钮文字后才会显示该按钮
    String cancelText,

    // 确定按钮的文字内容
    String confirmText = '确定',

    // 取消事件，默认为关闭alert
    VoidCallback onCancelPressed,

    // 确定事件，默认为关闭alert
    VoidCallback onConfirmPressed,

    // 按钮组，当需要自定义alert的按钮时，使用buttons，会覆盖默认的按钮
    List<AtButton> buttons,

    // 空白区域点击是否关闭alert
    bool barrierDismissible = false,
  }) {
    assert(child != null || content != '');

    // 当buttons没有数据时，使用默认按钮
    if (buttons == null || buttons.length == 0) {
      buttons = [];
      if (cancelText != null && cancelText != '') {
        buttons.add(AtButton(
          text: cancelText,
          theme: AtTheme.Default,
          onPressed: () {
            hide();
            if (onCancelPressed != null) onCancelPressed();
          },
        ));
      }
      buttons.add(AtButton(
        text: confirmText,
        onPressed: () {
          hide();
          if (onConfirmPressed != null) onConfirmPressed();
        },
      ));
    }

    // 保存当前上下文句柄
    _contexts.add(context);

    return _showAlert(
      context: context,
      builder: (BuildContext context) {
        return _Alert(
          title: title,
          content: content,
          child: child,
          contentTextAlign: contentTextAlign,
          buttons: buttons,
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

class _Alert extends Dialog {
  final String title;
  final String content;
  final Widget child;
  final TextAlign contentTextAlign;
  final List<AtButton> buttons;
  final bool barrierDismissible;

  _Alert({
    this.title,
    this.content = '',
    this.child,
    this.contentTextAlign = TextAlign.justify,
    @required this.buttons,
    this.barrierDismissible = false,
  }) : assert(content != '' || child != null);

  @override
  Widget build(BuildContext context) {
    Rpx r = Rpx.init(context);

    List<Widget> _children = [];

    // 如果有title
    if (title != null && title != '') {
      _children.add(Text(
        title,
        style: TextStyle(
          color: AtColors.titleColor,
          fontWeight: FontWeight.bold,
          fontSize: r.fpx(36),
        ),
      ));
      _children.add(SizedBox(
        height: r.px(15),
      ));
    } else {
      _children.add(SizedBox(height: r.px(10)));
    }

    // content
    if (content != '') {
      AlignmentGeometry _containerAlign;
      switch (this.contentTextAlign) {
        case TextAlign.center:
          _containerAlign = Alignment.topCenter;
          break;
        case TextAlign.end:
        case TextAlign.right:
          _containerAlign = Alignment.topRight;
          break;
        default:
          _containerAlign = Alignment.topLeft;
      }
      _children.add(
        Container(
          width: double.infinity,
          alignment: _containerAlign,
          child: Text(
            content,
            textAlign: contentTextAlign,
            style: TextStyle(
              color: title != null && title != '' ? AtColors.spanColor : AtColors.textColor,
              fontSize: r.fpx(28),
            ),
          ),
        ),
      );
    } else {
      _children.add(child);
    }
    _children.add(SizedBox(height: r.px(60)));

    // 按钮
    List<Widget> _buttons = [];
    for (int i = 0; i < buttons.length; i++) {
      _buttons.add(Expanded(child: buttons[i]));
      if (i < buttons.length - 1) {
        _buttons.add(SizedBox(width: r.px(20)));
      }
    }
    _children.add(Container(
      height: r.px(88),
      child: Row(children: _buttons),
    ));

    // 背景
    Widget _bg = Container(color: Colors.transparent);
    if (barrierDismissible) {
      _bg = GestureDetector(
        onTap: AtAlert.hide,
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
              width: r.px(580),
              padding: EdgeInsets.only(
                top: r.px(50),
                left: r.px(40),
                right: r.px(40),
                bottom: r.px(40),
              ),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<T> _showAlert<T>({
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
    transitionDuration: const Duration(milliseconds: 250),
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
